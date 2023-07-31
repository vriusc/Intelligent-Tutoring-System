package com.example.demo.dao;

import com.example.demo.entity.Record;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;


import static org.junit.jupiter.api.Assertions.assertEquals;


@SpringBootTest
@Transactional
public class RecordDaoTest {

    @Autowired
    private RecordDao recordDao;

    private Record record;

    @BeforeEach
    public void setUp() {
        // Set up test data
        record = new Record();
        record.setRecordId(99);
        record.setStudentId(1);
        record.setQuestionId(1);
        record.setOptionId(1);
        recordDao.insert(record);
    }

    @Test
    public void testQueryById() {
        // Call the method and verify the result
        Record result = recordDao.queryById(record.getRecordId());
        System.out.println(result);
        assertEquals(record.getRecordId(), result.getRecordId());
    }

    @AfterEach
    public void tearDown() {
        // Delete the test data after each test method
        recordDao.deleteById(record.getRecordId());
    }
}
