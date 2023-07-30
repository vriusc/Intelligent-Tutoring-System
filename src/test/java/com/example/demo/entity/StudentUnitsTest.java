package com.example.demo.entity;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;


public class StudentUnitsTest {

    // lombok test
    @Test
    void testLombok() {
        StudentUnits studentUnits = new StudentUnits();
        studentUnits.setStudentUnitId(1);
        studentUnits.setStudentId(1);
        studentUnits.setUnitId(1);
        studentUnits.setIsfinished(1);
        System.out.println(studentUnits);
        assertEquals(1, studentUnits.getStudentUnitId());
        assertEquals(1, studentUnits.getStudentId());
        assertEquals(1, studentUnits.getUnitId());
        assertEquals(1, studentUnits.getIsfinished());

    }

}
