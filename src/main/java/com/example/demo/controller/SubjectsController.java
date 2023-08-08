package com.example.demo.controller;

import com.example.demo.entity.Subjects;
import com.example.demo.service.SubjectsService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;


/**
 * (Subjects) controller
 *
 * @author qianyongru
 * @since 2023-06-22 06:24:38
 */
//@CrossOrigin(origins = "http://localhost:3000")
@RestController
@RequestMapping("/api/subjects")
public class SubjectsController {
    /**
     * subjectsService
     */
    @Resource
    private SubjectsService subjectsService;


    /**
     * page query
     *
     * @param subjects condition
     * @param page      page
     * @param size      size
     * @return Page<Subjects>
     */
    @GetMapping("/queryAllSubjects")
    public Page<Subjects> getAllSubjects(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            Subjects subjects) {
        PageRequest pageRequest = PageRequest.of(page, size);
        return this.subjectsService.queryByPage(subjects, pageRequest);
    }

    /**
     * page query
     *
     * @param subjects condition
     * @param pageRequest pageRequest
     * @return Page<Subjects>
     */
    @GetMapping
    public ResponseEntity<Page<Subjects>> queryByPage(Subjects subjects, Pageable pageRequest) {
        return ResponseEntity.ok(this.subjectsService.queryByPage(subjects, pageRequest));
    }



    /**
     * query by id
     *
     * @param id primary key
     * @return query result
     */
    @GetMapping("{id}")
    public ResponseEntity<Subjects> queryById(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(this.subjectsService.queryById(id));
    }

    /**
     * add data
     *
     * @param subjects entity
     * @return add result
     */
    @PostMapping
    public ResponseEntity<Subjects> add(Subjects subjects) {
        return ResponseEntity.ok(this.subjectsService.insert(subjects));
    }

    /**
     * edit data
     *
     * @param subjects entity
     * @return edit result
     */
    @PutMapping
    public ResponseEntity<Subjects> edit(Subjects subjects) {
        return ResponseEntity.ok(this.subjectsService.update(subjects));
    }

    /**
     * delete by id
     *
     * @param id primary key
     * @return delete result
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(Integer id) {
        return ResponseEntity.ok(this.subjectsService.deleteById(id));
    }

}

