package com.example.IntelligentTutorSystem.controller;

import com.example.IntelligentTutorSystem.pojo.Msg;
import com.example.IntelligentTutorSystem.pojo.User;
import com.example.IntelligentTutorSystem.service.UserService;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;


@RestController
public class AuthController {

    @Autowired
    private AuthenticationManager authenticationManager;
    @Autowired
    private UserService userService;

    @Autowired
    private PasswordEncoder passwordEncoder;


    @PostMapping("/myLogin")
    public Msg doLogin(@RequestBody User loginUser,
                       HttpSession session) {
        String username = loginUser.getUsername();
        String password = loginUser.getPassword();
        String email = loginUser.getEmail();
        User user = this.userService.findUserByUsernameOrEmail(username, email);
        if (user == null) {
            return new Msg<User>(20000, "账户不存在");
        }
        // 使用自己的用户服务来验证用户名和密码
        if (!user.getPassword().equals(passwordEncoder.encode(password))) {
            System.out.println("yyy");
            // 如果密码正确，创建一个简单的认证信息并存入HttpSession
            List<GrantedAuthority> authorities = new ArrayList<>();
            authorities.add(new SimpleGrantedAuthority("ROLE_USER"));
            UsernamePasswordAuthenticationToken authentication =
                    new UsernamePasswordAuthenticationToken(username, null, authorities);
            SecurityContextHolder.getContext().setAuthentication(authentication);
            session.setAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY, SecurityContextHolder.getContext());
            return new Msg<User>(20000, "登录成功", user);
        } else {
            // 密码错误
            return new Msg<User>(20000, "密码错误");
        }
    }

    @PostMapping("/register")
    public ResponseEntity<String> registerUser(@RequestBody User newUser) {
        String status = userService.register(newUser);
        if(status.equals("Exists")){
            return new ResponseEntity<>("User Already Exists", HttpStatus.CONFLICT);
        } else {
            return new ResponseEntity<>("Registration Successful", HttpStatus.CREATED);
        }
    }

    @RequestMapping ("/MyLogout")
    public Msg<Object> logout(HttpServletRequest request, HttpServletResponse response) {
        // 执行登出操作，例如清除用户信息、清除缓存等
        // 使用Spring Security提供的登出功能
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            new SecurityContextLogoutHandler().logout(request, response, auth);
            SecurityContextHolder.clearContext();
            System.out.println("ddddd");
        } else {
            System.out.println("xxxxx");
        }
        HttpSession session = request.getSession();
        if (session != null) {
            session.invalidate();
        }
        // 重定向到登录页面或其他页面
        return new Msg<>(20000, "登出成功");
    }
}