package com.example.demo.dao;

import com.example.demo.entity.Options;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;


import static org.junit.jupiter.api.Assertions.assertEquals;


@SpringBootTest
@Transactional

public class OptionsDaoTest {

    @Autowired
    private OptionsDao optionsDao;

    private Options options;

    @BeforeEach
    public void setUp() {
        // Set up test data
        options = new Options();
        options.setOptionId(99);
        options.setQuestionId(1);
        options.setOption("A");
        options.setIsCorrect(1);
        options.setOrderNumber(1);
        options.setDescription("test");
        optionsDao.insert(options);
//        options = new Options();
//        options.setOptionId(99);
//        options.setQuestionId(1);
//        options.setOption("A");
//        options.setIsCorrect(1);
//        options.setOrderNumber(1);
//        options.setDescription("test");
//        optionsDao.insert(options);
    }

    @Test
    public void testQueryById() {
        // Call the method and verify the result
        Options result = optionsDao.queryById(options.getOptionId());
        System.out.println(result);
        assertEquals(options.getOptionId(), result.getOptionId());
    }


    @AfterEach
    public void tearDown() {
        // Delete the test data after each test method
        optionsDao.deleteById(options.getOptionId());
    }

}
