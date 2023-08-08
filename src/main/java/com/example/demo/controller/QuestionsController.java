package com.example.demo.controller;

import com.example.demo.entity.Questions;
import com.example.demo.service.QuestionsService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * (Questions) controller
 *
 * @author qianyongru
 * @since 2023-06-23 08:55:36
 */
//@CrossOrigin(origins = "http://localhost:3000")
@RestController
@RequestMapping("/api/questions")
public class QuestionsController {
    /**
     * questionsService
     */
    @Resource
    private QuestionsService questionsService;

    /**
     * page query
     *
     * @param questions condition
     * @param pageable  pageable
     * @return Page<Questions>
     */
    @GetMapping
    public ResponseEntity<Page<Questions>> queryByPage(Questions questions, Pageable pageable) {
        return ResponseEntity.ok(this.questionsService.queryByPage(questions, pageable));
    }

    /**
     * query by id
     *
     * @param id primary key
     * @return query result
     */
    @GetMapping("{id}")
    public ResponseEntity<Questions> queryById(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(this.questionsService.queryById(id));
    }

    /**
     * add data
     *
     * @param questions entity
     * @return add result
     */
    @PostMapping
    public ResponseEntity<Questions> add(Questions questions) {
        return ResponseEntity.ok(this.questionsService.insert(questions));
    }

    /**
     * edit data
     *
     * @param questions entity
     * @return edit result
     */
    @PutMapping
    public ResponseEntity<Questions> edit(Questions questions) {
        return ResponseEntity.ok(this.questionsService.update(questions));
    }

    /**
     * delete by id
     *
     * @param id primary key
     * @return delete result
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(Integer id) {
        return ResponseEntity.ok(this.questionsService.deleteById(id));
    }

}

