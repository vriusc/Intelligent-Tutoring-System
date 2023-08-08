package com.example.demo.controller;

import com.example.demo.entity.*;
import com.example.demo.service.StudentUserService;
import org.springframework.beans.BeanUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * (StudentUser)表控制层
 *
 * @author qianyongru
 * @since 2023-06-21 06:36:40
 */
@RestController
@RequestMapping("/api/studentUser")
public class StudentUserController {
    /**
     *
     * studentUserService
     */
    @Resource
    private StudentUserService studentUserService;

    /**
     * page query
     *
     * @param id condition
     * @return Page<StudentUser>
     */
    @GetMapping("{id}")
    public ResponseEntity<StudentUser> queryById(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(this.studentUserService.queryById(id));
    }

    /**
     * register
     *
     * @param studentUser entity
     * @return register result
     */
    @PostMapping("/register")
    public ResponseEntity<RegisterResponseDTO> add(@RequestBody StudentUser studentUser) {

        // Encrypt passwords with bcrypt
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        String encodedPassword = passwordEncoder.encode(studentUser.getPassword());
        studentUser.setPassword(encodedPassword);

        this.studentUserService.insert(studentUser);

        // transform entity to dto
        RegisterResponseDTO responseDTO = new RegisterResponseDTO();
        BeanUtils.copyProperties(studentUser, responseDTO);
        responseDTO.setId(studentUser.getId());


        return ResponseEntity.ok(responseDTO);
    }

    /**
     * login
     *
     * @param loginRequest login request
     * @return login result
     */
    @PostMapping("/login")
    public ResponseEntity<LoginResponseDTO> login(@RequestBody LoginRequestDTO loginRequest) {
        String usernameOrEmail = loginRequest.getUsernameOrEmail();
        String password = loginRequest.getPassword();

        // Calling the login service to perform operations such as authentication and token generation
        try {
            StudentUser user=studentUserService.login(usernameOrEmail, password);
            Integer studentId=user.getId();

            // Login successful, create login response object
            LoginResponseDTO responseDTO = new LoginResponseDTO();
            responseDTO.setStudentId(studentId);
            responseDTO.setToken("generated_token");
            responseDTO.setMessage("Login successful");

            // return login response
            return ResponseEntity.ok(responseDTO);
        } catch (RuntimeException e) {
            // Login failed, create login response object
            LoginResponseDTO responseDTO = new LoginResponseDTO();
            responseDTO.setToken(null);
            responseDTO.setMessage("Login failed: " + e.getMessage());

            // return failure response
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(responseDTO);
        }
    }

    /**
     * change password
     *
     * @param request change password request
     * @return change password result
     */

    @PostMapping("/password")
    public ResponseEntity<String> updatePassword(@RequestBody UpdatePasswordRequestDTO request) {
        try {
            studentUserService.updatePassword(request.getUsername(), request.getEmail(), request.getCurrentPassword(), request.getNewPassword());
            return ResponseEntity.ok("Password updated successfully");
        } catch (RuntimeException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    /**
     * edit data
     *
     * @param studentUser entity
     * @return edit result
     */
    @PutMapping
    public ResponseEntity<StudentUser> edit(StudentUser studentUser) {
        return ResponseEntity.ok(this.studentUserService.update(studentUser));
    }

    /**
     * delete by id
     *
     * @param id primary key
     * @return delete result
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(Integer id) {
        return ResponseEntity.ok(this.studentUserService.deleteById(id));
    }


}

