package com.example.demo.service;

import com.example.demo.entity.TestListeningJudgementByPicture;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

/**
 * (TestListeningJudgementByPicture)表服务接口
 *
 * @author makejava
 * @since 2023-06-21 16:13:02
 */
public interface TestListeningJudgementByPictureService {

    /**
     * 通过ID查询单条数据
     *
     * @param testListeningJudgementByPictureId 主键
     * @return 实例对象
     */
    TestListeningJudgementByPicture queryById(Integer testListeningJudgementByPictureId);

    /**
     * 分页查询
     *
     * @param testListeningJudgementByPicture 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    Page<TestListeningJudgementByPicture> queryByPage(TestListeningJudgementByPicture testListeningJudgementByPicture, PageRequest pageRequest);

    /**
     * 新增数据
     *
     * @param testListeningJudgementByPicture 实例对象
     * @return 实例对象
     */
    TestListeningJudgementByPicture insert(TestListeningJudgementByPicture testListeningJudgementByPicture);

    /**
     * 修改数据
     *
     * @param testListeningJudgementByPicture 实例对象
     * @return 实例对象
     */
    TestListeningJudgementByPicture update(TestListeningJudgementByPicture testListeningJudgementByPicture);

    /**
     * 通过主键删除数据
     *
     * @param testListeningJudgementByPictureId 主键
     * @return 是否成功
     */
    boolean deleteById(Integer testListeningJudgementByPictureId);

}
