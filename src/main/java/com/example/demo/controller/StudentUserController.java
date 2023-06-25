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
@CrossOrigin(origins = "http://localhost:3000")
@RestController
@RequestMapping("studentUser")
public class StudentUserController {
    /**
     * 服务对象
     */
    @Resource
    private StudentUserService studentUserService;

    /**
     * 通过主键查询单条数据
     *
     * @param id 主键
     * @return 单条数据
     */
    @GetMapping("{id}")
    public ResponseEntity<StudentUser> queryById(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(this.studentUserService.queryById(id));
    }

    /**
     * 注册
     *
     * @param studentUser 实体
     * @return 注册
     */
    @PostMapping("/register")
    public ResponseEntity<RegisterResponseDTO> add(@RequestBody StudentUser studentUser) {

        // 对密码进行bcrypt加密
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        String encodedPassword = passwordEncoder.encode(studentUser.getPassword());
        studentUser.setPassword(encodedPassword);

        this.studentUserService.insert(studentUser);

        // 将StudentUser转换为RegisterResponseDTO
        RegisterResponseDTO responseDTO = new RegisterResponseDTO();
        BeanUtils.copyProperties(studentUser, responseDTO);
        responseDTO.setId(studentUser.getId());


        return ResponseEntity.ok(responseDTO);
    }

    /**
     * 登录
     *
     * @param loginRequest 登录请求
     * @return 登录结果
     */
    @PostMapping("/login")
    public ResponseEntity<LoginResponseDTO> login(@RequestBody LoginRequestDTO loginRequest) {
        String usernameOrEmail = loginRequest.getUsernameOrEmail();
        String password = loginRequest.getPassword();

        // 调用登录服务进行身份验证和生成令牌等操作
        try {
            StudentUser user=studentUserService.login(usernameOrEmail, password);
            Integer studentId=user.getId();

            // 登录成功，创建登录响应对象
            LoginResponseDTO responseDTO = new LoginResponseDTO();
            responseDTO.setStudentId(studentId);
            responseDTO.setToken("generated_token");
            responseDTO.setMessage("Login successful");

            // 返回登录成功的响应
            return ResponseEntity.ok(responseDTO);
        } catch (RuntimeException e) {
            // 登录失败，创建失败响应对象
            LoginResponseDTO responseDTO = new LoginResponseDTO();
            responseDTO.setToken(null);
            responseDTO.setMessage("Login failed: " + e.getMessage());

            // 返回登录失败的响应
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(responseDTO);
        }
    }

    /**
     * 修改密码
     *
     * @param request 修改密码请求
     * @return 修改结果
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
     * 编辑数据
     *
     * @param studentUser 实体
     * @return 编辑结果
     */
    @PutMapping
    public ResponseEntity<StudentUser> edit(StudentUser studentUser) {
        return ResponseEntity.ok(this.studentUserService.update(studentUser));
    }

    /**
     * 删除数据
     *
     * @param id 主键
     * @return 删除是否成功
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(Integer id) {
        return ResponseEntity.ok(this.studentUserService.deleteById(id));
    }


}

