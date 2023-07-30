package com.example.demo;

import com.example.demo.entity.Subjects;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class SubjectsTest {

    // lombok test
    @Test
    void testLombok() {
        Subjects subjects = new Subjects();
        subjects.setSubjectId(1);
        subjects.setSubjectName("test");
        subjects.setLevel("test");
        subjects.setDescription("test");
        System.out.println(subjects);
        assertEquals(1, subjects.getSubjectId());
        assertEquals("test", subjects.getSubjectName());
        assertEquals("test", subjects.getLevel());
        assertEquals("test", subjects.getDescription());
    }

}
