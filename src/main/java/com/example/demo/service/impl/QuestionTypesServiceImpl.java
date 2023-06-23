package com.example.demo.service.impl;

import com.example.demo.entity.QuestionTypes;
import com.example.demo.dao.QuestionTypesDao;
import com.example.demo.service.QuestionTypesService;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;

import javax.annotation.Resource;

/**
 * (QuestionTypes)表服务实现类
 *
 * @author makejava
 * @since 2023-06-23 08:12:09
 */
@Service("questionTypesService")
public class QuestionTypesServiceImpl implements QuestionTypesService {
    @Resource
    private QuestionTypesDao questionTypesDao;

    /**
     * 通过ID查询单条数据
     *
     * @param questionTypeId 主键
     * @return 实例对象
     */
    @Override
    public QuestionTypes queryById(Integer questionTypeId) {
        return this.questionTypesDao.queryById(questionTypeId);
    }

    /**
     * 分页查询
     *
     * @param questionTypes 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @Override
    public Page<QuestionTypes> queryByPage(QuestionTypes questionTypes, Pageable pageRequest) {
        long total = this.questionTypesDao.count(questionTypes);
        return new PageImpl<>(this.questionTypesDao.queryAllByLimit(questionTypes, pageRequest), pageRequest, total);
    }

    /**
     * 新增数据
     *
     * @param questionTypes 实例对象
     * @return 实例对象
     */
    @Override
    public QuestionTypes insert(QuestionTypes questionTypes) {
        this.questionTypesDao.insert(questionTypes);
        return questionTypes;
    }

    /**
     * 修改数据
     *
     * @param questionTypes 实例对象
     * @return 实例对象
     */
    @Override
    public QuestionTypes update(QuestionTypes questionTypes) {
        this.questionTypesDao.update(questionTypes);
        return this.queryById(questionTypes.getQuestionTypeId());
    }

    /**
     * 通过主键删除数据
     *
     * @param questionTypeId 主键
     * @return 是否成功
     */
    @Override
    public boolean deleteById(Integer questionTypeId) {
        return this.questionTypesDao.deleteById(questionTypeId) > 0;
    }
}
