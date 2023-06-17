package com.example.IntelligentTutorSystem.controller;

import com.example.IntelligentTutorSystem.pojo.User;
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
    private UserService userService;


    @GetMapping("/users")
    public List<User> getUsers() {

       /* List<User> list = new ArrayList<>();
        User user = new User();
        list.add(user);
        return list;*/
        List<User> users = userService.getAllUser();
        return users;
    }
}