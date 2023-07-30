package com.example.demo;

import com.example.demo.entity.StudentUser;
import org.junit.jupiter.api.Test;


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
    }




}
