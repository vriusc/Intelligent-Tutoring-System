package com.example.demo.dao;

import com.example.demo.entity.Subjects;
import com.example.demo.entity.Units;
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
public class UnitsDaoTest {

    @Autowired
    private UnitsDao unitsDao;

    @Autowired
    private SubjectsDao subjectsDao;

    private Units units;


    @BeforeEach
    public  void setUp() {
        units = new Units();
        units.setUnitId(99);
        units.setUnitName("test");
        units.setSubjectId(1);
        units.setUnitOrder(1);
        units.setMaterials_path("test");
        units.setDescription("test");
        units.setText("test");
        units.setText_description("test");
        unitsDao.insert(units);
        System.out.println(units);
    }


    @Test
    public void testQueryById() {
        // Call the method and verify the result
        Units result = unitsDao.queryById(units.getUnitId());
        System.out.println(result);
        assertEquals(units.getUnitId(), result.getUnitId());
    }

    @Test
    public void testQueryBySubjectId() {
        // Assuming your setUp method inserts a Units object with a SubjectId of 1
        List<Units> results = unitsDao.queryBySubjectId(1);
        System.out.println(results);

        // Depending on the data in your database, this check may vary.
        // Here we are checking if the method returns at least one result.
        assertTrue(results.size() > 0);
        // Optionally, if you know more about the expected result, you could add more assertions. For example:
        // assertEquals(expectedUnitId, results.get(0).getUnitId());
    }




    @AfterEach
    public void tearDown() {
        // Delete the test data after each test method
        unitsDao.deleteById(units.getUnitId());
    }
}