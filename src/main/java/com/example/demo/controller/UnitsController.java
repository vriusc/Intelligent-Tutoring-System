package com.example.demo.controller;

import com.example.demo.entity.Units;
import com.example.demo.service.UnitsService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * (Units)表控制层
 *
 * @author makejava
 * @since 2023-06-22 20:46:33
 */
@CrossOrigin(origins = "http://localhost:3000")
@RestController
@RequestMapping("units")
public class UnitsController {
    /**
     * 服务对象
     */
    @Resource
    private UnitsService unitsService;

    /**
     * 分页查询
     *
     * @param units 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @GetMapping
    public ResponseEntity<Page<Units>> queryByPage(Units units, PageRequest pageRequest) {
        return ResponseEntity.ok(this.unitsService.queryByPage(units, pageRequest));
    }

    /**
     * 通过主键查询单条数据
     *
     * @param id 主键
     * @return 单条数据
     */
    @GetMapping("{id}")
    public ResponseEntity<Units> queryById(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(this.unitsService.queryById(id));
    }

    /**
     * 新增数据
     *
     * @param units 实体
     * @return 新增结果
     */
    @PostMapping
    public ResponseEntity<Units> add(Units units) {
        return ResponseEntity.ok(this.unitsService.insert(units));
    }

    /**
     * 编辑数据
     *
     * @param units 实体
     * @return 编辑结果
     */
    @PutMapping
    public ResponseEntity<Units> edit(Units units) {
        return ResponseEntity.ok(this.unitsService.update(units));
    }

    /**
     * 删除数据
     *
     * @param id 主键
     * @return 删除是否成功
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(Integer id) {
        return ResponseEntity.ok(this.unitsService.deleteById(id));
    }

    /**
     * 通过subjectId查询数据
     *
     * @param subjectId 主键
     * @return 查询结果
     */
    @GetMapping("subject/{subjectId}")
    public ResponseEntity<List<Units>> queryBySubjectId(@PathVariable("subjectId") Integer subjectId) {
        return ResponseEntity.ok(this.unitsService.queryBySubjectId(subjectId));
    }

}

