package com.example.demo.controller;

import com.example.demo.entity.Materials;
import com.example.demo.service.MaterialsService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * (Materials)表控制层
 *
 * @author makejava
 * @since 2023-06-21 14:08:44
 */
@RestController
@RequestMapping("materials")
public class MaterialsController {
    /**
     * 服务对象
     */
    @Resource
    private MaterialsService materialsService;

    /**
     * 分页查询
     *
     * @param materials 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @GetMapping
    public ResponseEntity<Page<Materials>> queryByPage(Materials materials, PageRequest pageRequest) {
        return ResponseEntity.ok(this.materialsService.queryByPage(materials, pageRequest));
    }

    /**
     * 通过主键查询单条数据
     *
     * @param id 主键
     * @return 单条数据
     */
    @GetMapping("{id}")
    public ResponseEntity<Materials> queryById(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(this.materialsService.queryById(id));
    }

    /**
     * 新增数据
     *
     * @param materials 实体
     * @return 新增结果
     */
    @PostMapping
    public ResponseEntity<Materials> add(Materials materials) {
        return ResponseEntity.ok(this.materialsService.insert(materials));
    }

    /**
     * 编辑数据
     *
     * @param materials 实体
     * @return 编辑结果
     */
    @PutMapping
    public ResponseEntity<Materials> edit(Materials materials) {
        return ResponseEntity.ok(this.materialsService.update(materials));
    }

    /**
     * 删除数据
     *
     * @param id 主键
     * @return 删除是否成功
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(Integer id) {
        return ResponseEntity.ok(this.materialsService.deleteById(id));
    }

}

