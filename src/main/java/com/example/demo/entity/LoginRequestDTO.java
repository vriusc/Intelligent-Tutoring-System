package com.example.demo.entity;
import lombok.Data;

/**
 * (LoginRequestDTO) entityDTO
 *
 * @author qianyongru
 * @since 2023-06-23 19:40:35
 */
@Data
public class LoginRequestDTO {
    private String usernameOrEmail;
    private String password;
}
