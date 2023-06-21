package com.example.demo.entity;

import org.apache.ibatis.annotations.Mapper;

import java.util.Date;
import java.io.Serializable;

/**
 * (ListeningJudgementByPicture)实体类
 *
 * @author makejava
 * @since 2023-06-21 14:08:45
 */
@Mapper
public class ListeningJudgementByPicture implements Serializable {
    private static final long serialVersionUID = 861604753680562053L;
    
    private Integer listeningJudgementByPictureId;
    
    private String question;
    
    private Integer pictureFilePath;
    
    private Integer audioFilePath;
    
    private String answer;
    
    private Date date;


    public Integer getListeningJudgementByPictureId() {
        return listeningJudgementByPictureId;
    }

    public void setListeningJudgementByPictureId(Integer listeningJudgementByPictureId) {
        this.listeningJudgementByPictureId = listeningJudgementByPictureId;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public Integer getPictureFilePath() {
        return pictureFilePath;
    }

    public void setPictureFilePath(Integer pictureFilePath) {
        this.pictureFilePath = pictureFilePath;
    }

    public Integer getAudioFilePath() {
        return audioFilePath;
    }

    public void setAudioFilePath(Integer audioFilePath) {
        this.audioFilePath = audioFilePath;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

}

