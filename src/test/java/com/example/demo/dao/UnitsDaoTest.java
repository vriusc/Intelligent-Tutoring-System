package com.example.demo.dao;

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
        List<Units> results = unitsDao.queryBySubjectId(1);
        System.out.println(results);
        assertTrue(results.size() > 0);
    }




    @AfterEach
    public void tearDown() {
        // Delete the test data after each test method
        unitsDao.deleteById(units.getUnitId());
    }
}