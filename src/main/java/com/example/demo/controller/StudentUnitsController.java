package com.example.demo.controller;

import com.example.demo.entity.StudentUnits;
import com.example.demo.service.StudentUnitsService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * (StudentUnits)表控制层
 *
 * @author makejava
 * @since 2023-07-17 11:52:24
 */
//@CrossOrigin(origins = "http://localhost:3000")
@RestController
@RequestMapping("/api/studentUnits")
public class StudentUnitsController {
    /**
     * 服务对象
     */
    @Resource
    private StudentUnitsService studentUnitsService;

    /**
     * 分页查询
     *
     * @param studentUnits 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @GetMapping
    public ResponseEntity<Page<StudentUnits>> queryByPage(StudentUnits studentUnits, Pageable pageRequest) {
        return ResponseEntity.ok(this.studentUnitsService.queryByPage(studentUnits, pageRequest));
    }

    /**
     * 通过主键查询单条数据
     *
     * @param id 主键
     * @return 单条数据
     */
    @GetMapping("{id}")
    public ResponseEntity<StudentUnits> queryById(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(this.studentUnitsService.queryById(id));
    }

    /**
     * 新增数据
     *
     * @param studentUnits 实体
     * @return 新增结果
     */
    @PostMapping
    public ResponseEntity<StudentUnits> add(@RequestBody StudentUnits studentUnits) {
        return ResponseEntity.ok(this.studentUnitsService.insert(studentUnits));
    }

    /**
     * 编辑数据
     *
     * @param studentUnits 实体
     * @return 编辑结果
     */
    @PutMapping
    public ResponseEntity<StudentUnits> edit(@RequestBody StudentUnits studentUnits) {
        return ResponseEntity.ok(this.studentUnitsService.update(studentUnits));
    }

    /**
     * 删除数据
     *
     * @param id 主键
     * @return 删除是否成功
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(Integer id) {
        return ResponseEntity.ok(this.studentUnitsService.deleteById(id));
    }

}

