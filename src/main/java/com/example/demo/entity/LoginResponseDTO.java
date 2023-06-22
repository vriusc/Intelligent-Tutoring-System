package com.example.demo.entity;

import lombok.Data;

@Data
public class LoginResponseDTO {
    private Integer studentId;
    private String token;
    private String message;
}

