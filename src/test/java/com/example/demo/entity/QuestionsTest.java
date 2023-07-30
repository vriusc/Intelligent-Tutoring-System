package com.example.demo.entity;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class QuestionsTest {
    // lombok test
    @Test
    void testLombok() {
        Questions questions = new Questions();
        questions.setQuestionId(1);
        questions.setQuestion("question");
        questions.setQuestionTypeId(1);
        questions.setPicturePath("picturePath");
        questions.setVideoPath("videoPath");
        questions.setAudioPath("audioPath");
        questions.setDescription("description");
        questions.setQuestionOrder(1);
        questions.setExplanation("explanation");
        System.out.println(questions);
        assertEquals(1, questions.getQuestionId());
        assertEquals("question", questions.getQuestion());
        assertEquals(1, questions.getQuestionTypeId());
        assertEquals("picturePath", questions.getPicturePath());
        assertEquals("videoPath", questions.getVideoPath());
        assertEquals("audioPath", questions.getAudioPath());
        assertEquals("description", questions.getDescription());
        assertEquals(1, questions.getQuestionOrder());
        assertEquals("explanation", questions.getExplanation());
    }

}
