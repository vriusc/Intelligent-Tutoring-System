package com.example.demo.controller;

import com.example.demo.entity.QuestionUnits;
import com.example.demo.service.QuestionUnitsService;
import org.springframework.data.domain.Page;

import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * (QuestionUnits)表控制层
 *
 * @author makejava
 * @since 2023-06-23 09:31:50
 */
@CrossOrigin(origins = "http://localhost:3000")
@RestController
@RequestMapping("questionUnits")
public class QuestionUnitsController {
    /**
     * 服务对象
     */
    @Resource
    private QuestionUnitsService questionUnitsService;

    /**
     * 分页查询
     *
     * @param questionUnits 筛选条件
     * @param pageable      分页对象
     * @return 查询结果
     */
    @GetMapping
    public ResponseEntity<Page<QuestionUnits>> queryByPage(QuestionUnits questionUnits, Pageable pageable) {
        return ResponseEntity.ok(this.questionUnitsService.queryByPage(questionUnits, pageable));
    }

    /**
     * 通过主键查询单条数据
     *
     * @param id 主键
     * @return 单条数据
     */
    @GetMapping("{id}")
    public ResponseEntity<QuestionUnits> queryById(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(this.questionUnitsService.queryById(id));
    }

    /**
     * 新增数据
     *
     * @param questionUnits 实体
     * @return 新增结果
     */
    @PostMapping
    public ResponseEntity<QuestionUnits> add(QuestionUnits questionUnits) {
        return ResponseEntity.ok(this.questionUnitsService.insert(questionUnits));
    }

    /**
     * 编辑数据
     *
     * @param questionUnits 实体
     * @return 编辑结果
     */
    @PutMapping
    public ResponseEntity<QuestionUnits> edit(QuestionUnits questionUnits) {
        return ResponseEntity.ok(this.questionUnitsService.update(questionUnits));
    }

    /**
     * 删除数据
     *
     * @param id 主键
     * @return 删除是否成功
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(Integer id) {
        return ResponseEntity.ok(this.questionUnitsService.deleteById(id));
    }

}

