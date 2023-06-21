package com.example.demo.entity;

import java.io.Serializable;

/**
 * (Materials)实体类
 *
 * @author makejava
 * @since 2023-06-21 14:08:45
 */
public class Materials implements Serializable {
    private static final long serialVersionUID = -51359023858385866L;
    
    private Integer materialsId;
    
    private String filePath;


    public Integer getMaterialsId() {
        return materialsId;
    }

    public void setMaterialsId(Integer materialsId) {
        this.materialsId = materialsId;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

}

