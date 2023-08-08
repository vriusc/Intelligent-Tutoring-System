package com.example.demo.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * (Units) entity
 *
 * @author qianyongru
 * @since 2023-06-22 20:46:33
 */
@Data
public class Units implements Serializable {
    private static final long serialVersionUID = -41646255081207024L;
    
    private Integer unitId;
    
    private String unitName;
    
    private Integer subjectId;

    private Integer unitOrder;

    private String materials_path;
    
    private String description;

    private String text;

    private String text_description;

    private Subjects subject;

}

