package com.example.demo.controller;

import com.example.demo.entity.Questions;
import com.example.demo.service.QuestionsService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * (Questions)表控制层
 *
 * @author makejava
 * @since 2023-06-23 08:55:36
 */
@RestController
@RequestMapping("api/questions")
public class QuestionsController {
    /**
     * 服务对象
     */
    @Resource
    private QuestionsService questionsService;

    /**
     * 分页查询
     *
     * @param questions 筛选条件
     * @param pageable      分页对象
     * @return 查询结果
     */
    @GetMapping
    public ResponseEntity<Page<Questions>> queryByPage(Questions questions, Pageable pageable) {
        return ResponseEntity.ok(this.questionsService.queryByPage(questions, pageable));
    }

    /**
     * 通过主键查询单条数据
     *
     * @param id 主键
     * @return 单条数据
     */
    @GetMapping("{id}")
    public ResponseEntity<Questions> queryById(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(this.questionsService.queryById(id));
    }

    /**
     * 新增数据
     *
     * @param questions 实体
     * @return 新增结果
     */
    @PostMapping
    public ResponseEntity<Questions> add(Questions questions) {
        return ResponseEntity.ok(this.questionsService.insert(questions));
    }

    /**
     * 编辑数据
     *
     * @param questions 实体
     * @return 编辑结果
     */
    @PutMapping
    public ResponseEntity<Questions> edit(Questions questions) {
        return ResponseEntity.ok(this.questionsService.update(questions));
    }

    /**
     * 删除数据
     *
     * @param id 主键
     * @return 删除是否成功
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(Integer id) {
        return ResponseEntity.ok(this.questionsService.deleteById(id));
    }

}

