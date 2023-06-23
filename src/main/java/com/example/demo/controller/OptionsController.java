package com.example.demo.controller;

import com.example.demo.entity.Options;
import com.example.demo.service.OptionsService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * (Options)表控制层
 *
 * @author makejava
 * @since 2023-06-23 10:58:28
 */
@CrossOrigin(origins = "http://localhost:3000")
@RestController
@RequestMapping("options")
public class OptionsController {
    /**
     * 服务对象
     */
    @Resource
    private OptionsService optionsService;

    /**
     * 分页查询
     *
     * @param options 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @GetMapping
    public ResponseEntity<Page<Options>> queryByPage(Options options, Pageable pageRequest) {
        return ResponseEntity.ok(this.optionsService.queryByPage(options, pageRequest));
    }

    /**
     * 通过主键查询单条数据
     *
     * @param id 主键
     * @return 单条数据
     */
    @GetMapping("{id}")
    public ResponseEntity<Options> queryById(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(this.optionsService.queryById(id));
    }

    /**
     * 新增数据
     *
     * @param options 实体
     * @return 新增结果
     */
    @PostMapping
    public ResponseEntity<Options> add(Options options) {
        return ResponseEntity.ok(this.optionsService.insert(options));
    }

    /**
     * 编辑数据
     *
     * @param options 实体
     * @return 编辑结果
     */
    @PutMapping
    public ResponseEntity<Options> edit(Options options) {
        return ResponseEntity.ok(this.optionsService.update(options));
    }

    /**
     * 删除数据
     *
     * @param id 主键
     * @return 删除是否成功
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(Integer id) {
        return ResponseEntity.ok(this.optionsService.deleteById(id));
    }

}

