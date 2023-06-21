package com.example.demo.controller;

import com.example.demo.entity.ListeningJudgementByPicture;
import com.example.demo.service.ListeningJudgementByPictureService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * (ListeningJudgementByPicture)表控制层
 *
 * @author makejava
 * @since 2023-06-21 14:08:45
 */
@RestController
@RequestMapping("listeningJudgementByPicture")
public class ListeningJudgementByPictureController {
    /**
     * 服务对象
     */
    @Resource
    private ListeningJudgementByPictureService listeningJudgementByPictureService;

    /**
     * 分页查询
     *
     * @param listeningJudgementByPicture 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @GetMapping
    public ResponseEntity<Page<ListeningJudgementByPicture>> queryByPage(ListeningJudgementByPicture listeningJudgementByPicture, PageRequest pageRequest) {
        return ResponseEntity.ok(this.listeningJudgementByPictureService.queryByPage(listeningJudgementByPicture, pageRequest));
    }

    /**
     * 通过主键查询单条数据
     *
     * @param id 主键
     * @return 单条数据
     */
    @GetMapping("{id}")
    public ResponseEntity<ListeningJudgementByPicture> queryById(@PathVariable("id") Integer id) {
        return ResponseEntity.ok(this.listeningJudgementByPictureService.queryById(id));
    }

    /**
     * 新增数据
     *
     * @param listeningJudgementByPicture 实体
     * @return 新增结果
     */
    @PostMapping
    public ResponseEntity<ListeningJudgementByPicture> add(ListeningJudgementByPicture listeningJudgementByPicture) {
        return ResponseEntity.ok(this.listeningJudgementByPictureService.insert(listeningJudgementByPicture));
    }

    /**
     * 编辑数据
     *
     * @param listeningJudgementByPicture 实体
     * @return 编辑结果
     */
    @PutMapping
    public ResponseEntity<ListeningJudgementByPicture> edit(ListeningJudgementByPicture listeningJudgementByPicture) {
        return ResponseEntity.ok(this.listeningJudgementByPictureService.update(listeningJudgementByPicture));
    }

    /**
     * 删除数据
     *
     * @param id 主键
     * @return 删除是否成功
     */
    @DeleteMapping
    public ResponseEntity<Boolean> deleteById(Integer id) {
        return ResponseEntity.ok(this.listeningJudgementByPictureService.deleteById(id));
    }

}

