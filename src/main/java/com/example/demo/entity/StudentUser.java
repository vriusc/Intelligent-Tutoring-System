package com.example.demo.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;

import java.io.Serializable;

/**
 * (StudentUser)实体类
 *
 * @author vriusc
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

