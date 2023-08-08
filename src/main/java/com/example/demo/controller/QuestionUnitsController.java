package com.example.demo.controller;

import com.example.demo.entity.QuestionUnits;
import com.example.demo.service.QuestionUnitsService;
import org.springframework.data.domain.Page;

import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * (QuestionUnits) controller
 *
 * @author qianyongru
 * @since 2023-06-23 09:31:50
 */
//@CrossOrigin(origins = "http://localhost:3000")
@RestController
@RequestMapping("/api/questionUnits")
public class QuestionUnitsController {
    /**
     * questionUnitsService
     */
    @Resource
    private QuestionUnitsService questionUnitsService;

    /**
     * page query
     *
     * @param questionUnits condition
     * @param pageable     pageable
     * @return Page<QuestionUnits>
     */
    @GetMapping
    public ResponseEntity<Page<QuestionUnits>> queryByPage(QuestionUnits questionUnits, Pageable pageable) {
        return ResponseEntity.ok(this.questionUnitsService.queryByPage(questionUnits, pageable));
    }

    /**
     * query by id
     *
     * @param id primary key
     * @return query result
     */
    @GetMapping("{id}")
    public ResponseEntity<QuestionUnits> queryById(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(this.questionUnitsService.queryById(id));
    }

    /**
     * add data
     *
     * @param questionUnits entity
     * @return add result
     */
    @PostMapping
    public ResponseEntity<QuestionUnits> add(QuestionUnits questionUnits) {
        return ResponseEntity.ok(this.questionUnitsService.insert(questionUnits));
    }

    /**
     * edit data
     *
     * @param questionUnits entity
     * @return edit result
     */
    @PutMapping
    public ResponseEntity<QuestionUnits> edit(QuestionUnits questionUnits) {
        return ResponseEntity.ok(this.questionUnitsService.update(questionUnits));
    }

    /**
     * delete by id
     *
     * @param id primary key
     * @return delete result
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(Integer id) {
        return ResponseEntity.ok(this.questionUnitsService.deleteById(id));
    }

}

