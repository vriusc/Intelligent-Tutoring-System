package com.example.demo.entity;

import lombok.Data;

@Data
public class UpdatePasswordRequestDTO {
    private String username;
    private String email;
    private String currentPassword;
    private String newPassword;
}
