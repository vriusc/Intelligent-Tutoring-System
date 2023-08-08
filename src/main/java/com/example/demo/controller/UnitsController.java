package com.example.demo.controller;

import com.example.demo.entity.Units;
import com.example.demo.service.UnitsService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * (Units) controller
 *
 * @author qianyongru
 * @since 2023-06-22 20:46:33
 */
//@CrossOrigin(origins = "http://localhost:3000")
@RestController
@RequestMapping("/api/units")
public class UnitsController {
    /**
     * unitsService
     */
    @Resource
    private UnitsService unitsService;

    /**
     * page query
     *
     * @param units condition
     * @param pageRequest pageRequest
     * @return Page<Units>
     */
    @GetMapping
    public ResponseEntity<Page<Units>> queryByPage(Units units, PageRequest pageRequest) {
        return ResponseEntity.ok(this.unitsService.queryByPage(units, pageRequest));
    }

    /**
     * page query
     *
     * @param id condition
     * @return Page<Units>
     */
    @GetMapping("{id}")
    public ResponseEntity<Units> queryById(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(this.unitsService.queryById(id));
    }

    /**
     * add data
     *
     * @param units entity
     * @return add result
     */
    @PostMapping
    public ResponseEntity<Units> add(@RequestBody Units units) {
        return ResponseEntity.ok(this.unitsService.insert(units));
    }

    /**
     * edit data
     *
     * @param units entity
     * @return edit result
     */
    @PutMapping
    public ResponseEntity<Units> edit(Units units) {
        return ResponseEntity.ok(this.unitsService.update(units));
    }

    /**
     * delete data
     *
     * @param id primary key
     * @return delete result
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(Integer id) {
        return ResponseEntity.ok(this.unitsService.deleteById(id));
    }

    /**
     * query by subjectId
     *
     * @param subjectId primary key
     * @return query result
     */
    @GetMapping("subject/{subjectId}")
    public ResponseEntity<List<Units>> queryBySubjectId(@PathVariable("subjectId") Integer subjectId) {
        return ResponseEntity.ok(this.unitsService.queryBySubjectId(subjectId));
    }

}

