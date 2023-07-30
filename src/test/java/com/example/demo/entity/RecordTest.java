package com.example.demo.entity;


import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;


public class RecordTest {
    // lombok test
            @Test
            void testLombok() {
                Record record = new Record();
                record.setRecordId(1);
                record.setStudentId(1);
                record.setQuestionId(1);
                record.setOptionId(1);
                System.out.println(record);
                assertEquals(1, record.getRecordId());
                assertEquals(1, record.getStudentId());
                assertEquals(1, record.getQuestionId());
                assertEquals(1, record.getOptionId());
            }
}
