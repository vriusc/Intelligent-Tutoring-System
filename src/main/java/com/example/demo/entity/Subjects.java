package com.example.demo.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * (Subjects)实体类
 *
 * @author qianyongru
 * @since 2023-06-22 06:24:38
 */
@Data
public class Subjects implements Serializable {
    private static final long serialVersionUID = -83155117087968677L;

    private Integer subjectId;

    private String subjectName;

    private String level;

    private String description;


}

