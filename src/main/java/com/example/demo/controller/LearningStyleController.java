package com.example.demo.controller;

import com.example.demo.entity.LearningStyle;
import com.example.demo.service.LearningStyleService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * (LearningStyle)表控制层
 *
 * @author qianyongru
 * @since 2023-07-08 04:19:23
 */
@CrossOrigin(origins = "http://localhost:3000")
@RestController
@RequestMapping("/api/learningStyle")
public class LearningStyleController {
    /**
     * 服务对象
     */
    @Resource
    private LearningStyleService learningStyleService;

    /**
     * 分页查询
     *
     * @param learningStyle 筛选条件
     * @param pageable      分页对象
     * @return 查询结果
     */
    @GetMapping
    public ResponseEntity<Page<LearningStyle>> queryByPage(LearningStyle learningStyle, Pageable pageable) {
        return ResponseEntity.ok(this.learningStyleService.queryByPage(learningStyle, pageable));
    }

    /**
     * 通过主键查询单条数据
     *
     * @param id 主键
     * @return 单条数据
     */
    @GetMapping("{id}")
    public ResponseEntity<LearningStyle> queryById(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(this.learningStyleService.queryById(id));
    }

    /**
     * 新增数据
     *
     * @param learningStyle 实体
     * @return 新增结果
     */
    @PostMapping
    public ResponseEntity<LearningStyle> add(@RequestBody LearningStyle learningStyle) {
        return ResponseEntity.ok(this.learningStyleService.insert(learningStyle));
    }

    /**
     * 编辑数据
     *
     * @param learningStyle 实体
     * @return 编辑结果
     */
    @PutMapping
    public ResponseEntity<LearningStyle> edit(@RequestBody LearningStyle learningStyle) {
        return ResponseEntity.ok(this.learningStyleService.update(learningStyle));
    }

    /**
     * 删除数据
     *
     * @param id 主键
     * @return 删除是否成功
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(Integer id) {
        return ResponseEntity.ok(this.learningStyleService.deleteById(id));
    }

}

