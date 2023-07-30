package com.example.demo.entity;

import com.example.demo.entity.Comments;
import org.junit.jupiter.api.Test;
import java.sql.Timestamp;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class CommentsTest {
    @Test
    public void testComments() {
        Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
        Comments comments = new Comments();
        comments.setCommentId(1);
        comments.setStudentId(1);
        comments.setQuestionId(1);
        comments.setComment("comment");
        comments.setTime(currentTimestamp);
        comments.setLikes(1);
        System.out.println(comments);
        assertEquals(1, comments.getCommentId());
        assertEquals(1, comments.getStudentId());
        assertEquals(1, comments.getQuestionId());
        assertEquals("comment", comments.getComment());
        assertEquals(currentTimestamp, comments.getTime());
        assertEquals(1, comments.getLikes());
    }

}
