package com.example.demo.entity;

import com.example.demo.entity.StudentUser;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;


public class StudentUserTest {

    // lombok test
    @Test
    void testLombok() {
        StudentUser studentUser = new StudentUser();
        studentUser.setId(1);
        studentUser.setUsername("qianyongru");
        studentUser.setEmail("qianyongru@icloud.com");
        studentUser.setPassword("123446");
        System.out.println(studentUser);
        assertEquals(1, studentUser.getId());
        assertEquals("qianyongru", studentUser.getUsername());
        assertEquals("qianyongru@icloud.com", studentUser.getEmail());
        assertEquals("123446", studentUser.getPassword());
    }
}
