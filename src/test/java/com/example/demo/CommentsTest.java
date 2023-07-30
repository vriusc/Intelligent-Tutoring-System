package com.example.demo;

import com.example.demo.entity.Comments;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class CommentsTest {
    @Test
    public void testComments() {
        Comments comments = new Comments();
        comments.setCommentId(1);
        comments.setStudentId(1);
        comments.setQuestionId(1);
        comments.setComment("comment");
        comments.setTime(null);
        comments.setLikes(1);
        assertEquals(1, comments.getCommentId());
        assertEquals(1, comments.getStudentId());
        assertEquals(1, comments.getQuestionId());
        assertEquals("comment", comments.getComment());
        assertEquals(null, comments.getTime());
        assertEquals(1, comments.getLikes());
    }
}
