package com.example.IntelligentTutorSystem.service;

import com.example.IntelligentTutorSystem.mode.User;
import com.example.IntelligentTutorSystem.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    // @Autowired
   // private BCryptPasswordEncoder bCryptPasswordEncoder;

     /* public String register(User user){
        if(userRepository.findByUsername(user.getUsername()) != null || userRepository.findByEmail(user.getEmail()) != null){
            return "Exists";
        }
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        userRepository.save(user);
        return "Success";
    } */

    public User findUserByUsernameOrEmail(String identifier){
        User user = userRepository.findByUsername(identifier);
        if(user == null){
            user = userRepository.findByEmail(identifier);
        }
        return user;
    }
}
