package com.example.demo.controller;

import com.example.demo.entity.Score;
import com.example.demo.service.ScoreService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * (Score)表控制层
 *
 * @author makejava
 * @since 2023-06-23 16:05:58
 */
@RestController
@RequestMapping("score")
public class ScoreController {
    /**
     * 服务对象
     */

    @Resource
    private ScoreService scoreService;

    /**
     * 分页查询
     *
     * @param score 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */

    @GetMapping
    public ResponseEntity<Page<Score>> queryByPage(Score score, PageRequest pageRequest) {
        return ResponseEntity.ok(this.scoreService.queryByPage(score, pageRequest));
    }

    /**
     * 通过主键查询单条数据
     *
     * @param id 主键
     * @return 单条数据
     */
    @GetMapping("{id}")
    public ResponseEntity<Score> queryById(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(this.scoreService.queryById(id));
    }

    /**
     * 新增数据
     *
     * @param score 实体
     * @return 新增结果
     */
    @PostMapping
    public ResponseEntity<Score> add(Score score) {
        return ResponseEntity.ok(this.scoreService.insert(score));
    }

    /**
     * 编辑数据
     *
     * @param score 实体
     * @return 编辑结果
     */
    @PutMapping
    public ResponseEntity<Score> edit(Score score) {
        return ResponseEntity.ok(this.scoreService.update(score));
    }

    /**
     * 删除数据
     *
     * @param id 主键
     * @return 删除是否成功
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(Integer id) {
        return ResponseEntity.ok(this.scoreService.deleteById(id));
    }

}

