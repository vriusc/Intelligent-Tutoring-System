package com.example.demo.controller;

import com.example.demo.entity.Record;
import com.example.demo.service.RecordService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * (Record) controller
 *
 * @author qianyongru
 * @since 2023-06-23 19:27:35
 */
//@CrossOrigin(origins = "http://localhost:3000")
@RestController
@RequestMapping("/api/record")
public class RecordController {
    /**
     * recordService
     */
    @Resource
    private RecordService recordService;

    /**
     * page query
     *
     * @param record condition
     * @param pageRequest pageRequest
     * @return Page<Record>
     */
    @GetMapping
    public ResponseEntity<Page<Record>> queryByPage(Record record, Pageable pageRequest) {
        return ResponseEntity.ok(this.recordService.queryByPage(record, pageRequest));
    }

    /**
     * query by id
     *
     * @param id primary key
     * @return Record
     */
    @GetMapping("{id}")
    public ResponseEntity<Record> queryById(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(this.recordService.queryById(id));
    }

    /**
     * add data
     *
     * @param record entity
     * @return Record
     */
    @PostMapping
    public ResponseEntity<Record> add(@RequestBody Record record) {
        System.out.println(record.getStudentId());
        return ResponseEntity.ok(this.recordService.insert(record));
    }

    /**
     * edit data
     *
     * @param record entity
     * @return Record
     */
    @PutMapping
    public ResponseEntity<Record> edit(@RequestBody Record record) {
        return ResponseEntity.ok(this.recordService.update(record));
    }

    /**
     * delete by id
     *
     * @param id primary key
     * @return Boolean
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(Integer id) {
        return ResponseEntity.ok(this.recordService.deleteById(id));
    }

}

