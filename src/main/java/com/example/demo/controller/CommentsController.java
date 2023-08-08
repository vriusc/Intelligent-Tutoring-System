package com.example.demo.controller;

import com.example.demo.entity.Comments;
import com.example.demo.service.CommentsService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * (Comments) controller
 *
 * @author qianyongru
 * @since 2023-07-08 05:07:47
 */
@RestController
@RequestMapping("/api/comments")
public class CommentsController {
    /**
     * commentsService
     */
    @Resource
    private CommentsService commentsService;

    /**
     * page query
     *
     * @param comments conditions
     * @param pageRequest      page request
     * @return page result
     */
    @GetMapping
    public ResponseEntity<Page<Comments>> queryByPage(Comments comments, Pageable pageRequest) {
        return ResponseEntity.ok(this.commentsService.queryByPage(comments, pageRequest));
    }

    /**
     * query by id
     *
     * @param id primary key
     * @return entity
     */
    @GetMapping("{id}")
    public ResponseEntity<Comments> queryById(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(this.commentsService.queryById(id));
    }

    /**
     * add data
     *
     * @param comments entity
     * @return add result
     */
    @PostMapping
    public ResponseEntity<Comments> add(@RequestBody Comments comments) {
        return ResponseEntity.ok(this.commentsService.insert(comments));
    }

    /**
     * edit data
     *
     * @param comments entity
     * @return edit result
     */
    @PutMapping
    public ResponseEntity<Comments> edit(@RequestBody Comments comments) {
        return ResponseEntity.ok(this.commentsService.update(comments));
    }

    /**
     * delete data
     *
     * @param id primary key
     * @return delete result
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(Integer id) {
        return ResponseEntity.ok(this.commentsService.deleteById(id));
    }

}

