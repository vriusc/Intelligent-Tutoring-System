package com.example.demo.service.impl;

import com.example.demo.entity.TestListeningJudgementByPicture;
import com.example.demo.dao.TestListeningJudgementByPictureDao;
import com.example.demo.service.TestListeningJudgementByPictureService;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;

import javax.annotation.Resource;

/**
 * (TestListeningJudgementByPicture)表服务实现类
 *
 * @author makejava
 * @since 2023-06-21 16:13:02
 */
@Service("testListeningJudgementByPictureService")
public class TestListeningJudgementByPictureServiceImpl implements TestListeningJudgementByPictureService {
    @Resource
    private TestListeningJudgementByPictureDao testListeningJudgementByPictureDao;

    /**
     * 通过ID查询单条数据
     *
     * @param testListeningJudgementByPictureId 主键
     * @return 实例对象
     */
    @Override
    public TestListeningJudgementByPicture queryById(Integer testListeningJudgementByPictureId) {
        return this.testListeningJudgementByPictureDao.queryById(testListeningJudgementByPictureId);
    }

    /**
     * 分页查询
     *
     * @param testListeningJudgementByPicture 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @Override
    public Page<TestListeningJudgementByPicture> queryByPage(TestListeningJudgementByPicture testListeningJudgementByPicture, PageRequest pageRequest) {
        long total = this.testListeningJudgementByPictureDao.count(testListeningJudgementByPicture);
        return new PageImpl<>(this.testListeningJudgementByPictureDao.queryAllByLimit(testListeningJudgementByPicture, pageRequest), pageRequest, total);
    }

    /**
     * 新增数据
     *
     * @param testListeningJudgementByPicture 实例对象
     * @return 实例对象
     */
    @Override
    public TestListeningJudgementByPicture insert(TestListeningJudgementByPicture testListeningJudgementByPicture) {
        this.testListeningJudgementByPictureDao.insert(testListeningJudgementByPicture);
        return testListeningJudgementByPicture;
    }

    /**
     * 修改数据
     *
     * @param testListeningJudgementByPicture 实例对象
     * @return 实例对象
     */
    @Override
    public TestListeningJudgementByPicture update(TestListeningJudgementByPicture testListeningJudgementByPicture) {
        this.testListeningJudgementByPictureDao.update(testListeningJudgementByPicture);
        return this.queryById(testListeningJudgementByPicture.getTestListeningJudgementByPictureId());
    }

    /**
     * 通过主键删除数据
     *
     * @param testListeningJudgementByPictureId 主键
     * @return 是否成功
     */
    @Override
    public boolean deleteById(Integer testListeningJudgementByPictureId) {
        return this.testListeningJudgementByPictureDao.deleteById(testListeningJudgementByPictureId) > 0;
    }
}
