package com.example.IntelligentTutorSystem.controller;

import com.example.IntelligentTutorSystem.mode.User;
import com.example.IntelligentTutorSystem.repository.UserRepository;
import com.example.IntelligentTutorSystem.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class UserController {


    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserService userService;

   /* @PostMapping("/register")
    public ResponseEntity<String> registerUser(@RequestBody User newUser) {
        String status = userService.register(newUser);
        if(status.equals("Exists")){
            return new ResponseEntity<>("User Already Exists", HttpStatus.CONFLICT);
        } else {
            return new ResponseEntity<>("Registration Successful", HttpStatus.CREATED);
        }
    }

    */

   /* @PostMapping("/login")
    public ResponseEntity<User> loginUser(@RequestBody String identifier, @RequestBody String password) {
        User user = userService.findUserByUsernameOrEmail(identifier);
        if(user == null){
            return new ResponseEntity<>(null, HttpStatus.NOT_FOUND);
        }
        if(!new BCryptPasswordEncoder().matches(password, user.getPassword())){
            return new ResponseEntity<>(null, HttpStatus.UNAUTHORIZED);
        }
        return new ResponseEntity<>(user, HttpStatus.OK);
    } */

    @GetMapping("users")
    public List<User> getUsers() {
        return (List<User>) this.userRepository.findAll();

    }
}