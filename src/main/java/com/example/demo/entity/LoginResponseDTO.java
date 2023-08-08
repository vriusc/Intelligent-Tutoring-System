package com.example.demo.entity;

import lombok.Data;

/**
 * (LoginResponseDTO) entityDTO
 *
 * @author qianyongru
 * @since 2023-06-23 19:50:35
 */

@Data
public class LoginResponseDTO {
    private Integer studentId;
    private String token;
    private String message;
}

