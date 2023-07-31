package com.example.demo.dao;

import com.example.demo.entity.Comments;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;


import java.sql.Timestamp;

import static org.junit.jupiter.api.Assertions.assertEquals;


@SpringBootTest
@Transactional
public class CommentsDaoTest {

    @Autowired
    private CommentsDao commentsDao;

    private Comments comments;

    @BeforeEach
    public void setUp() {
        // Set up test data
        Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
        comments = new Comments();
        comments.setCommentId(99);
        comments.setStudentId(1);
        comments.setQuestionId(1);
        comments.setComment("test");
        comments.setTime(currentTimestamp);
        comments.setLikes(1);
        commentsDao.insert(comments);
    }

    @Test
    public void testQueryById() {
        // Call the method and verify the result
        Comments result = commentsDao.queryById(comments.getCommentId());
        System.out.println(result);
        assertEquals(comments.getCommentId(), result.getCommentId());
    }

    @AfterEach
    public void tearDown() {
        // Delete the test data after each test method
        commentsDao.deleteById(comments.getCommentId());
    }
}
