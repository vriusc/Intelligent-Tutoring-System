package com.example.demo.service.impl;

import com.example.demo.entity.Questions;
import com.example.demo.dao.QuestionsDao;
import com.example.demo.service.QuestionsService;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;


import javax.annotation.Resource;

/**
 * (Questions)表服务实现类
 *
 * @author qianyongru
 * @since 2023-06-23 08:55:36
 */
@Service("questionsService")
public class QuestionsServiceImpl implements QuestionsService {
    @Resource
    private QuestionsDao questionsDao;

    /**
     * 通过ID查询单条数据
     *
     * @param questionId 主键
     * @return 实例对象
     */
    @Override
    public Questions queryById(Integer questionId) {
        return this.questionsDao.queryById(questionId);
    }

    /**
     * 分页查询
     *
     * @param questions 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @Override
    public Page<Questions> queryByPage(Questions questions, Pageable pageRequest) {
        long total = this.questionsDao.count(questions);
        return new PageImpl<>(this.questionsDao.queryAllByLimit(questions, pageRequest), pageRequest, total);
    }

    /**
     * 新增数据
     *
     * @param questions 实例对象
     * @return 实例对象
     */
    @Override
    public Questions insert(Questions questions) {
        this.questionsDao.insert(questions);
        return questions;
    }

    /**
     * 修改数据
     *
     * @param questions 实例对象
     * @return 实例对象
     */
    @Override
    public Questions update(Questions questions) {
        this.questionsDao.update(questions);
        return this.queryById(questions.getQuestionId());
    }

    /**
     * 通过主键删除数据
     *
     * @param questionId 主键
     * @return 是否成功
     */
    @Override
    public boolean deleteById(Integer questionId) {
        return this.questionsDao.deleteById(questionId) > 0;
    }
}
