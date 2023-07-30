package com.example.demo.entity;

import com.example.demo.entity.Options;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class OptionsTest {
    @Test
    public void testOptions() {
        Options options = new Options();
        options.setOptionId(1);
        options.setQuestionId(1);
        options.setOption("text");
        options.setIsCorrect(1);
        options.setOrderNumber(1);
        options.setDescription("text");
        assertEquals(1, options.getOptionId());
        assertEquals(1, options.getQuestionId());
        assertEquals("text", options.getOption());
        assertEquals(1, options.getIsCorrect());
        assertEquals(1, options.getOrderNumber());
        assertEquals("text", options.getDescription());
    }
}
