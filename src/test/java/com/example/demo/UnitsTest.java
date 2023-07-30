package com.example.demo;

import com.example.demo.entity.Units;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class UnitsTest {

    // lombok test
    @Test
    void testLombok() {
        Units units = new Units();
        units.setUnitId(1);
        units.setUnitName("test");
        units.setSubjectId(1);
        units.setUnitOrder(1);
        units.setMaterials_path("test");
        units.setDescription("test");
        units.setText("test");
        units.setText_description("test");
        System.out.println(units);
        assertEquals(1, units.getUnitId());
        assertEquals("test", units.getUnitName());
        assertEquals(1, units.getSubjectId());
        assertEquals(1, units.getUnitOrder());
        assertEquals("test", units.getMaterials_path());
        assertEquals("test", units.getDescription());
        assertEquals("test", units.getText());
        assertEquals("test", units.getText_description());

    }

}
