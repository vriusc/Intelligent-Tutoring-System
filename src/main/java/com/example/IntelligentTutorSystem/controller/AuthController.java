package com.example.IntelligentTutorSystem.controller;

import com.example.IntelligentTutorSystem.model.User;
import jakarta.annotation.Resource;


import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.*;

@RestController
public class AuthController {

    @Resource
    private AuthenticationManager authenticationManager;

    @PostMapping("/login")
    public ResponseEntity<User> loginUser(@RequestBody User loginUser) {
        System.out.println("检测到这里");
        Authentication authentication =  authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(loginUser.getUsername(), loginUser.getPassword()));

        SecurityContextHolder.getContext().setAuthentication(authentication);

        return new ResponseEntity<>(HttpStatus.OK); // Return status 200 if success
    }
}


