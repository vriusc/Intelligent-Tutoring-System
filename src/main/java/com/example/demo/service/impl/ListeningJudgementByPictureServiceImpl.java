package com.example.demo.service.impl;

import com.example.demo.entity.ListeningJudgementByPicture;
import com.example.demo.dao.ListeningJudgementByPictureDao;
import com.example.demo.service.ListeningJudgementByPictureService;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;

import javax.annotation.Resource;

/**
 * (ListeningJudgementByPicture)表服务实现类
 *
 * @author makejava
 * @since 2023-06-21 14:08:45
 */
@Service("listeningJudgementByPictureService")
public class ListeningJudgementByPictureServiceImpl implements ListeningJudgementByPictureService {
    @Resource
    private ListeningJudgementByPictureDao listeningJudgementByPictureDao;

    /**
     * 通过ID查询单条数据
     *
     * @param listeningJudgementByPictureId 主键
     * @return 实例对象
     */
    @Override
    public ListeningJudgementByPicture queryById(Integer listeningJudgementByPictureId) {
        return this.listeningJudgementByPictureDao.queryById(listeningJudgementByPictureId);
    }

    /**
     * 分页查询
     *
     * @param listeningJudgementByPicture 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @Override
    public Page<ListeningJudgementByPicture> queryByPage(ListeningJudgementByPicture listeningJudgementByPicture, PageRequest pageRequest) {
        long total = this.listeningJudgementByPictureDao.count(listeningJudgementByPicture);
        return new PageImpl<>(this.listeningJudgementByPictureDao.queryAllByLimit(listeningJudgementByPicture, pageRequest), pageRequest, total);
    }

    /**
     * 新增数据
     *
     * @param listeningJudgementByPicture 实例对象
     * @return 实例对象
     */
    @Override
    public ListeningJudgementByPicture insert(ListeningJudgementByPicture listeningJudgementByPicture) {
        this.listeningJudgementByPictureDao.insert(listeningJudgementByPicture);
        return listeningJudgementByPicture;
    }

    /**
     * 修改数据
     *
     * @param listeningJudgementByPicture 实例对象
     * @return 实例对象
     */
    @Override
    public ListeningJudgementByPicture update(ListeningJudgementByPicture listeningJudgementByPicture) {
        this.listeningJudgementByPictureDao.update(listeningJudgementByPicture);
        return this.queryById(listeningJudgementByPicture.getListeningJudgementByPictureId());
    }

    /**
     * 通过主键删除数据
     *
     * @param listeningJudgementByPictureId 主键
     * @return 是否成功
     */
    @Override
    public boolean deleteById(Integer listeningJudgementByPictureId) {
        return this.listeningJudgementByPictureDao.deleteById(listeningJudgementByPictureId) > 0;
    }
}
