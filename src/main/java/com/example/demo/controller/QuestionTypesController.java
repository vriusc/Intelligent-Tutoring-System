package com.example.demo.controller;

import com.example.demo.entity.QuestionTypes;
import com.example.demo.service.QuestionTypesService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * (QuestionTypes) controller
 *
 * @author qianyongru
 * @since 2023-06-23 08:12:09
 */
//@CrossOrigin(origins = "http://localhost:3000")
@RestController
@RequestMapping("/api/questionTypes")
public class QuestionTypesController {
    /**
     * questionTypesService
     */
    @Resource
    private QuestionTypesService questionTypesService;

    /**
     * page query
     *
     * @param questionTypes condition
     * @param pageable      pageable
     * @return Page<QuestionTypes>
     */
    @GetMapping
    public ResponseEntity<Page<QuestionTypes>> queryByPage(QuestionTypes questionTypes, Pageable pageable) {
        return ResponseEntity.ok(this.questionTypesService.queryByPage(questionTypes, pageable));
    }

    /**
     * query by id
     *
     * @param id primary key
     * @return query result
     */
    @GetMapping("{id}")
    public ResponseEntity<QuestionTypes> queryById(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(this.questionTypesService.queryById(id));
    }

    /**
     * add data
     *
     * @param questionTypes entity
     * @return add result
     */
    @PostMapping
    public ResponseEntity<QuestionTypes> add(QuestionTypes questionTypes) {
        return ResponseEntity.ok(this.questionTypesService.insert(questionTypes));
    }

    /**
     * edit data
     *
     * @param questionTypes entity
     * @return edit result
     */
    @PutMapping
    public ResponseEntity<QuestionTypes> edit(QuestionTypes questionTypes) {
        return ResponseEntity.ok(this.questionTypesService.update(questionTypes));
    }

    /**
     * delete by id
     *
     * @param id primary key
     * @return delete result
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(Integer id) {
        return ResponseEntity.ok(this.questionTypesService.deleteById(id));
    }

}

