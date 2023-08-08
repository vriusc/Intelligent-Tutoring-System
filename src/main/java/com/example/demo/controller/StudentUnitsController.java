package com.example.demo.controller;

import com.example.demo.entity.StudentUnits;
import com.example.demo.service.StudentUnitsService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * (StudentUnits) controller
 *
 * @author qianyongru
 * @since 2023-07-17 11:52:24
 */
//@CrossOrigin(origins = "http://localhost:3000")
@RestController
@RequestMapping("/api/studentUnits")
public class StudentUnitsController {
    /**
     * studentUnits service
     */
    @Resource
    private StudentUnitsService studentUnitsService;

    /**
     * page query
     *
     * @param studentUnits condition
     * @param pageRequest      pageRequest
     * @return Page<StudentUnits>
     */
    @GetMapping
    public ResponseEntity<Page<StudentUnits>> queryByPage(StudentUnits studentUnits, Pageable pageRequest) {
        return ResponseEntity.ok(this.studentUnitsService.queryByPage(studentUnits, pageRequest));
    }

    /**
     * query by id
     *
     * @param id primary key
     * @return query result
     */
    @GetMapping("{id}")
    public ResponseEntity<StudentUnits> queryById(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(this.studentUnitsService.queryById(id));
    }

    /**
     * add data
     *
     * @param studentUnits entity
     * @return add result
     */
    @PostMapping
    public ResponseEntity<StudentUnits> add(@RequestBody StudentUnits studentUnits) {
        return ResponseEntity.ok(this.studentUnitsService.insert(studentUnits));
    }

    /**
     * edit data
     *
     * @param studentUnits entity
     * @return edit result
     */
    @PutMapping
    public ResponseEntity<StudentUnits> edit(@RequestBody StudentUnits studentUnits) {
        return ResponseEntity.ok(this.studentUnitsService.update(studentUnits));
    }

    /**
     * delete by id
     *
     * @param id primary key
     * @return delete result
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(Integer id) {
        return ResponseEntity.ok(this.studentUnitsService.deleteById(id));
    }

}

