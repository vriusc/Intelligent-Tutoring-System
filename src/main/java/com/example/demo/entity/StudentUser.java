package com.example.demo.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * (StudentUser) entity
 *
 * @author qianyongru
 * @since 2023-06-21 06:36:40
 */
@Data
public class StudentUser implements Serializable {
    private static final long serialVersionUID = -56269051532249524L;
    private Integer id;

    private String username;

    private String password;

    private String email;

}

