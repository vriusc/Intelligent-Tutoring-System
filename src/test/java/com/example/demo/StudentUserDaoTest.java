package com.example.demo;

import com.example.demo.dao.StudentUserDao;
import com.example.demo.entity.StudentUser;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
@Transactional
public class StudentUserDaoTest {

    @Autowired
    private StudentUserDao dao;

    private StudentUser student;

    @BeforeEach
    public void setUp() {
        // 在每个测试方法执行前，插入一些测试数据
        student = new StudentUser();
        student.setUsername("Test");
        student.setPassword("Password");
        student.setEmail("test@example.com");
        dao.insert(student);
    }

    @Test
    public void testQueryById() {
        // 调用方法并验证结果
        StudentUser result = dao.queryById(student.getId());
        System.out.println(result);
        assertEquals(student.getUsername(), result.getUsername());
        assertEquals(student.getPassword(), result.getPassword());
        assertEquals(student.getEmail(), result.getEmail());
    }

    @AfterEach
    public void tearDown() {
        // 在每个测试方法执行后，删除测试数据
        dao.deleteById(student.getId());
    }
}
