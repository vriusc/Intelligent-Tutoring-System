package com.example.demo.controller;

import com.example.demo.entity.Test;
import com.example.demo.service.TestService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * (Test)表控制层
 *
 * @author makejava
 * @since 2023-06-21 15:21:27
 */
@RestController
@RequestMapping("test")
public class TestController {
    /**
     * 服务对象
     */
    @Resource
    private TestService testService;

    /**
     * 分页查询
     *
     * @param test 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @GetMapping
    public ResponseEntity<Page<Test>> queryByPage(Test test, PageRequest pageRequest) {
        return ResponseEntity.ok(this.testService.queryByPage(test, pageRequest));
    }

    /**
     * 通过主键查询单条数据
     *
     * @param id 主键
     * @return 单条数据
     */
    @GetMapping("{id}")
    public ResponseEntity<Test> queryById(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(this.testService.queryById(id));
    }

    /**
     * 新增数据
     *
     * @param test 实体
     * @return 新增结果
     */
    @PostMapping
    public ResponseEntity<Test> add(Test test) {
        return ResponseEntity.ok(this.testService.insert(test));
    }

    /**
     * 编辑数据
     *
     * @param test 实体
     * @return 编辑结果
     */
    @PutMapping
    public ResponseEntity<Test> edit(Test test) {
        return ResponseEntity.ok(this.testService.update(test));
    }

    /**
     * 删除数据
     *
     * @param id 主键
     * @return 删除是否成功
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(Integer id) {
        return ResponseEntity.ok(this.testService.deleteById(id));
    }

}

