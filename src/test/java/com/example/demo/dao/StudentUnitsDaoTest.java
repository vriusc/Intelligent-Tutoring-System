package com.example.demo.dao;

import com.example.demo.entity.StudentUnits;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;


@SpringBootTest
@Transactional
public class StudentUnitsDaoTest {

    @Autowired
    private StudentUnitsDao studentUnitsDao;

    private StudentUnits studentUnits;

    @BeforeEach
    public void setUp() {
        // Set up test data
        studentUnits = new StudentUnits();
        studentUnits.setStudentUnitId(99);
        studentUnits.setStudentId(1);
        studentUnits.setUnitId(1);
        studentUnits.setIsfinished(1);
        studentUnitsDao.insert(studentUnits);
    }

    @Test
    public void testQueryById() {
        // Call the method and verify the result
        StudentUnits result = studentUnitsDao.queryById(studentUnits.getStudentUnitId());
        System.out.println(result);
        assertEquals(studentUnits.getStudentUnitId(), result.getStudentUnitId());
    }

    @AfterEach
    public void tearDown() {
        // Delete the test data after each test method
        studentUnitsDao.deleteById(studentUnits.getStudentUnitId());
    }
}
