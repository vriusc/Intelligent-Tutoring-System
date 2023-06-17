package com.example.IntelligentTutorSystem.service;

import com.example.IntelligentTutorSystem.model.User;
import com.example.IntelligentTutorSystem.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private PasswordEncoder passwordEncoder;

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
    public void save(User user) {
        userRepository.saveAndFlush(user);
    }


    public String register(User user) {
        String username = user.getUsername();
        String password = user.getPassword();
        if (StringUtils.isEmpty(username) || StringUtils.isEmpty(password)) {
            return "Exists";
        }
        User user1 = userRepository.findByUsername(username);
        if (user1 != null) {
            return "Exists";
        }
        password = passwordEncoder.encode(password);
        user.setPassword(password);
        userRepository.save(user);
        return "sucess";
    }
}
