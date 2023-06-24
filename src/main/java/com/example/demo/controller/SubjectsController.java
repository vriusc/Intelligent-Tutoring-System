package com.example.demo.controller;

import com.example.demo.entity.Subjects;
import com.example.demo.service.SubjectsService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;


/**
 * (Subjects)表控制层
 *
 * @author makejava
 * @since 2023-06-22 06:24:38
 */
@RestController
@RequestMapping("api/subjects")
public class SubjectsController {
    /**
     * 服务对象
     */
    @Resource
    private SubjectsService subjectsService;


    /**
     * 分页查询所有可科目
     *
     * @param subjects 筛选条件
     * @param page      页码
     * @param size      每页条数
     * @return 查询结果
     */
    @GetMapping("/queryAllSubjects")
    public Page<Subjects> getAllSubjects(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            Subjects subjects) {
        PageRequest pageRequest = PageRequest.of(page, size);
        return this.subjectsService.queryByPage(subjects, pageRequest);
    }

    /**
     * 分页查询
     *
     * @param subjects 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @GetMapping
    public ResponseEntity<Page<Subjects>> queryByPage(Subjects subjects, Pageable pageRequest) {
        return ResponseEntity.ok(this.subjectsService.queryByPage(subjects, pageRequest));
    }



    /**
     * 通过主键查询单条数据
     *
     * @param id 主键
     * @return 单条数据
     */
    @GetMapping("{id}")
    public ResponseEntity<Subjects> queryById(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(this.subjectsService.queryById(id));
    }

    /**
     * 新增数据
     *
     * @param subjects 实体
     * @return 新增结果
     */
    @PostMapping
    public ResponseEntity<Subjects> add(Subjects subjects) {
        return ResponseEntity.ok(this.subjectsService.insert(subjects));
    }

    /**
     * 编辑数据
     *
     * @param subjects 实体
     * @return 编辑结果
     */
    @PutMapping
    public ResponseEntity<Subjects> edit(Subjects subjects) {
        return ResponseEntity.ok(this.subjectsService.update(subjects));
    }

    /**
     * 删除数据
     *
     * @param id 主键
     * @return 删除是否成功
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(Integer id) {
        return ResponseEntity.ok(this.subjectsService.deleteById(id));
    }

}

