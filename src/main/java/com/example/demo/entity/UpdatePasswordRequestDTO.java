package com.example.demo.entity;

import lombok.Data;


/**
 * (UpdatePasswordRequestDTO) entityDTO
 *
 * @author qianyongru
 * @since 2023-06-23 06:45:38
 */

@Data
public class UpdatePasswordRequestDTO {
    private String username;
    private String email;
    private String currentPassword;
    private String newPassword;
}
