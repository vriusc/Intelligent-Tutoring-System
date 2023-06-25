package com.example.demo.controller;

import com.example.demo.entity.QuestionTypes;
import com.example.demo.service.QuestionTypesService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * (QuestionTypes)表控制层
 *
 * @author qianyongru
 * @since 2023-06-23 08:12:09
 */
@CrossOrigin(origins = "http://localhost:3000")
@RestController
@RequestMapping("questionTypes")
public class QuestionTypesController {
    /**
     * 服务对象
     */
    @Resource
    private QuestionTypesService questionTypesService;

    /**
     * 分页查询
     *
     * @param questionTypes 筛选条件
     * @param pageable      分页对象
     * @return 查询结果
     */
    @GetMapping
    public ResponseEntity<Page<QuestionTypes>> queryByPage(QuestionTypes questionTypes, Pageable pageable) {
        return ResponseEntity.ok(this.questionTypesService.queryByPage(questionTypes, pageable));
    }

    /**
     * 通过主键查询单条数据
     *
     * @param id 主键
     * @return 单条数据
     */
    @GetMapping("{id}")
    public ResponseEntity<QuestionTypes> queryById(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(this.questionTypesService.queryById(id));
    }

    /**
     * 新增数据
     *
     * @param questionTypes 实体
     * @return 新增结果
     */
    @PostMapping
    public ResponseEntity<QuestionTypes> add(QuestionTypes questionTypes) {
        return ResponseEntity.ok(this.questionTypesService.insert(questionTypes));
    }

    /**
     * 编辑数据
     *
     * @param questionTypes 实体
     * @return 编辑结果
     */
    @PutMapping
    public ResponseEntity<QuestionTypes> edit(QuestionTypes questionTypes) {
        return ResponseEntity.ok(this.questionTypesService.update(questionTypes));
    }

    /**
     * 删除数据
     *
     * @param id 主键
     * @return 删除是否成功
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(Integer id) {
        return ResponseEntity.ok(this.questionTypesService.deleteById(id));
    }

}

