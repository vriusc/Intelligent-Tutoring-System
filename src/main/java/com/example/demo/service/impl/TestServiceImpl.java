package com.example.demo.service.impl;

import com.example.demo.entity.Test;
import com.example.demo.dao.TestDao;
import com.example.demo.service.TestService;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;

import javax.annotation.Resource;

/**
 * (Test)表服务实现类
 *
 * @author makejava
 * @since 2023-06-21 15:21:27
 */
@Service("testService")
public class TestServiceImpl implements TestService {
    @Resource
    private TestDao testDao;

    /**
     * 通过ID查询单条数据
     *
     * @param testId 主键
     * @return 实例对象
     */
    @Override
    public Test queryById(Integer testId) {
        return this.testDao.queryById(testId);
    }

    /**
     * 分页查询
     *
     * @param test 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @Override
    public Page<Test> queryByPage(Test test, PageRequest pageRequest) {
        long total = this.testDao.count(test);
        return new PageImpl<>(this.testDao.queryAllByLimit(test, pageRequest), pageRequest, total);
    }

    /**
     * 新增数据
     *
     * @param test 实例对象
     * @return 实例对象
     */
    @Override
    public Test insert(Test test) {
        this.testDao.insert(test);
        return test;
    }

    /**
     * 修改数据
     *
     * @param test 实例对象
     * @return 实例对象
     */
    @Override
    public Test update(Test test) {
        this.testDao.update(test);
        return this.queryById(test.getTestId());
    }

    /**
     * 通过主键删除数据
     *
     * @param testId 主键
     * @return 是否成功
     */
    @Override
    public boolean deleteById(Integer testId) {
        return this.testDao.deleteById(testId) > 0;
    }
}
