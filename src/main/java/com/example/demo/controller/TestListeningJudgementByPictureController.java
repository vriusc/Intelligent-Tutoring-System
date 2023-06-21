package com.example.demo.controller;

import com.example.demo.entity.TestListeningJudgementByPicture;
import com.example.demo.service.TestListeningJudgementByPictureService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * (TestListeningJudgementByPicture)表控制层
 *
 * @author makejava
 * @since 2023-06-21 16:13:02
 */
@RestController
@RequestMapping("testListeningJudgementByPicture")
public class TestListeningJudgementByPictureController {
    /**
     * 服务对象
     */
    @Resource
    private TestListeningJudgementByPictureService testListeningJudgementByPictureService;

    /**
     * 分页查询
     *
     * @param testListeningJudgementByPicture 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @GetMapping
    public ResponseEntity<Page<TestListeningJudgementByPicture>> queryByPage(TestListeningJudgementByPicture testListeningJudgementByPicture, PageRequest pageRequest) {
        return ResponseEntity.ok(this.testListeningJudgementByPictureService.queryByPage(testListeningJudgementByPicture, pageRequest));
    }

    /**
     * 通过主键查询单条数据
     *
     * @param id 主键
     * @return 单条数据
     */
    @GetMapping("{id}")
    public ResponseEntity<TestListeningJudgementByPicture> queryById(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(this.testListeningJudgementByPictureService.queryById(id));
    }


    /**
     * 新增数据
     *
     * @param testListeningJudgementByPicture 实体
     * @return 新增结果
     */
    @PostMapping
    public ResponseEntity<TestListeningJudgementByPicture> add(TestListeningJudgementByPicture testListeningJudgementByPicture) {
        return ResponseEntity.ok(this.testListeningJudgementByPictureService.insert(testListeningJudgementByPicture));
    }

    /**
     * 编辑数据
     *
     * @param testListeningJudgementByPicture 实体
     * @return 编辑结果
     */
    @PutMapping
    public ResponseEntity<TestListeningJudgementByPicture> edit(TestListeningJudgementByPicture testListeningJudgementByPicture) {
        return ResponseEntity.ok(this.testListeningJudgementByPictureService.update(testListeningJudgementByPicture));
    }

    /**
     * 删除数据
     *
     * @param id 主键
     * @return 删除是否成功
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(Integer id) {
        return ResponseEntity.ok(this.testListeningJudgementByPictureService.deleteById(id));
    }

}

