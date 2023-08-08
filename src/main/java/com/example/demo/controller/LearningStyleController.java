package com.example.demo.controller;

import com.example.demo.entity.LearningStyle;
import com.example.demo.service.LearningStyleService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * (LearningStyle) controller
 *
 * @author qianyongru
 * @since 2023-07-08 04:19:23
 */
//@CrossOrigin(origins = "http://localhost:3000")
@RestController
@RequestMapping("/api/learningStyle")
public class LearningStyleController {
    /**
     * learningStyle service
     */
    @Resource
    private LearningStyleService learningStyleService;

    /**
     * page query
     *
     * @param learningStyle condition
     * @param pageable      pageable
     * @return  Page<LearningStyle>
     */
    @GetMapping
    public ResponseEntity<Page<LearningStyle>> queryByPage(LearningStyle learningStyle, Pageable pageable) {
        return ResponseEntity.ok(this.learningStyleService.queryByPage(learningStyle, pageable));
    }

    /**
     * query by id
     *
     * @param id primary key
     * @return query result
     */
    @GetMapping("{id}")
    public ResponseEntity<LearningStyle> queryById(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(this.learningStyleService.queryById(id));
    }

    /**
     * add data
     *
     * @param learningStyle entity
     * @return add result
     */
    @PostMapping
    public ResponseEntity<LearningStyle> add(@RequestBody LearningStyle learningStyle) {
        return ResponseEntity.ok(this.learningStyleService.insert(learningStyle));
    }

    /**
     * edit data
     *
     * @param learningStyle entity
     * @return edit result
     */
    @PutMapping
    public ResponseEntity<LearningStyle> edit(@RequestBody LearningStyle learningStyle) {
        return ResponseEntity.ok(this.learningStyleService.update(learningStyle));
    }

    /**
     * delete by id
     *
     * @param id primary key
     * @return delete result
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(Integer id) {
        return ResponseEntity.ok(this.learningStyleService.deleteById(id));
    }

}

