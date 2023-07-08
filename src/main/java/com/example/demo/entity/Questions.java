package com.example.demo.entity;

import lombok.Data;

import java.io.Serializable;

/**
 * (Questions)实体类
 *
 * @author qianyongru
 * @since 2023-06-23 08:55:36
 */
@Data
public class Questions implements Serializable {
    private static final long serialVersionUID = 259897767434622230L;
    
    private Integer questionId;
    
    private String question;
    
    private Integer questionTypeId;
    
    private String picturePath;
    
    private String videoPath;
    
    private String audioPath;

    private String description;
    
    private Integer questionOrder;
    
    private String explanation;

    private QuestionTypes questionTypes;


}

