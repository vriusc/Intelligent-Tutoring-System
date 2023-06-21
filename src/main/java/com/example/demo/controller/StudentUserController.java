package com.example.demo.controller;

import com.example.demo.entity.StudentUser;
import com.example.demo.service.StudentUserService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * (StudentUser)表控制层
 *
 * @author makejava
 * @since 2023-06-21 06:36:40
 */
@RestController
@RequestMapping("studentUser")
public class StudentUserController {
    /**
     * 服务对象
     */
    @Resource
    private StudentUserService studentUserService;

    /**
     * 分页查询
     *
     * @param studentUser 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @GetMapping
    public ResponseEntity<Page<StudentUser>> queryByPage(StudentUser studentUser, PageRequest pageRequest) {
        return ResponseEntity.ok(this.studentUserService.queryByPage(studentUser, pageRequest));
    }

    /**
     * 通过主键查询单条数据
     *
     * @param id 主键
     * @return 单条数据
     */
    @GetMapping("{id}")
    public ResponseEntity<StudentUser> queryById(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(this.studentUserService.queryById(id));
    }

    /**
     * 新增数据
     *
     * @param studentUser 实体
     * @return 新增结果
     */
    @PostMapping("/register")
    public ResponseEntity<StudentUser> add(@RequestBody StudentUser studentUser) {
        return ResponseEntity.ok(this.studentUserService.insert(studentUser));
    }

    /**
     * 编辑数据
     *
     * @param studentUser 实体
     * @return 编辑结果
     */
    @PutMapping
    public ResponseEntity<StudentUser> edit(StudentUser studentUser) {
        return ResponseEntity.ok(this.studentUserService.update(studentUser));
    }

    /**
     * 删除数据
     *
     * @param id 主键
     * @return 删除是否成功
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(Integer id) {
        return ResponseEntity.ok(this.studentUserService.deleteById(id));
    }

}

