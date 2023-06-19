package com.example.IntelligentTutorSystem.service;

import com.example.IntelligentTutorSystem.pojo.User;
import com.example.IntelligentTutorSystem.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private PasswordEncoder passwordEncoder;



    public User findUserByUsernameOrEmail(String username, String email){
        User user = userRepository.findByUsername(username);
        if(user == null){
            user = userRepository.findByEmail(email);
        }
        return user;
    }
    public void save(User user) {
        userRepository.saveAndFlush(user);
    }


    public String register(User user) {
        String username = user.getUsername();
        String password = user.getPassword();
        String email = user.getEmail();
        if (StringUtils.isEmpty(username) || StringUtils.isEmpty(password)) {
            return "Exists";
        }
        User user1 = this.findUserByUsernameOrEmail(username, email);

        if (user1 != null) {
            return "Exists";
        }
        password = passwordEncoder.encode(password);
        user.setPassword(password);
        userRepository.save(user);
        return "sucess";
    }


    public List<User> getAllUser() {
        List<User> users = userRepository.findAll();
        return  users;
    }
}