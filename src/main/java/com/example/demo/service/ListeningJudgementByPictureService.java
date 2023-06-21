package com.example.demo.service;

import com.example.demo.entity.ListeningJudgementByPicture;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

/**
 * (ListeningJudgementByPicture)表服务接口
 *
 * @author makejava
 * @since 2023-06-21 14:08:45
 */
public interface ListeningJudgementByPictureService {

    /**
     * 通过ID查询单条数据
     *
     * @param listeningJudgementByPictureId 主键
     * @return 实例对象
     */
    ListeningJudgementByPicture queryById(Integer listeningJudgementByPictureId);

    /**
     * 分页查询
     *
     * @param listeningJudgementByPicture 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    Page<ListeningJudgementByPicture> queryByPage(ListeningJudgementByPicture listeningJudgementByPicture, PageRequest pageRequest);

    /**
     * 新增数据
     *
     * @param listeningJudgementByPicture 实例对象
     * @return 实例对象
     */
    ListeningJudgementByPicture insert(ListeningJudgementByPicture listeningJudgementByPicture);

    /**
     * 修改数据
     *
     * @param listeningJudgementByPicture 实例对象
     * @return 实例对象
     */
    ListeningJudgementByPicture update(ListeningJudgementByPicture listeningJudgementByPicture);

    /**
     * 通过主键删除数据
     *
     * @param listeningJudgementByPictureId 主键
     * @return 是否成功
     */
    boolean deleteById(Integer listeningJudgementByPictureId);

}
