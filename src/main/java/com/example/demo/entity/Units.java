package com.example.demo.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * (Units)实体类
 *
 * @author makejava
 * @since 2023-06-22 20:46:33
 */
@Data
public class Units implements Serializable {
    private static final long serialVersionUID = -41646255081207024L;
    
    private Integer unitId;
    
    private String unitName;
    
    private Integer subjectId;
    
    private String description;

    private Subjects subject;
}

