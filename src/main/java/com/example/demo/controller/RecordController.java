package com.example.demo.controller;

import com.example.demo.entity.Record;
import com.example.demo.service.RecordService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * (Record)表控制层
 *
 * @author qianyongru
 * @since 2023-06-23 19:27:35
 */
//@CrossOrigin(origins = "http://localhost:3000")
@RestController
@RequestMapping("/api/record")
public class RecordController {
    /**
     * 服务对象
     */
    @Resource
    private RecordService recordService;

    /**
     * 分页查询
     *
     * @param record 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @GetMapping
    public ResponseEntity<Page<Record>> queryByPage(Record record, Pageable pageRequest) {
        return ResponseEntity.ok(this.recordService.queryByPage(record, pageRequest));
    }

    /**
     * 通过主键查询单条数据
     *
     * @param id 主键
     * @return 单条数据
     */
    @GetMapping("{id}")
    public ResponseEntity<Record> queryById(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(this.recordService.queryById(id));
    }

    /**
     * 新增数据
     *
     * @param record 实体
     * @return 新增结果
     */
    @PostMapping
    public ResponseEntity<Record> add(@RequestBody Record record) {
        System.out.println(record.getStudentId());
        return ResponseEntity.ok(this.recordService.insert(record));
    }

    /**
     * 编辑数据
     *
     * @param record 实体
     * @return 编辑结果
     */
    @PutMapping
    public ResponseEntity<Record> edit(@RequestBody Record record) {
        return ResponseEntity.ok(this.recordService.update(record));
    }

    /**
     * 删除数据
     *
     * @param id 主键
     * @return 删除是否成功
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(Integer id) {
        return ResponseEntity.ok(this.recordService.deleteById(id));
    }

}

