package com.example.demo.controller;

import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String uri = request.getRequestURI();
        if (!uri.startsWith("/api/studentUser/login")) {
            // 检查session中的登录标识符
            if (request.getSession().getAttribute("loggedIn") == null) {
                // 如果没有登录标识符，重定向到登录页面
                response.sendRedirect("/api/studentUser/login");
                return false; // 中断后续的处理
            }
        }
        return true; // 继续后续的处理
    }
}





