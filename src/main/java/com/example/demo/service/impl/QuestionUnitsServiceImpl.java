package com.example.demo.service.impl;

import com.example.demo.entity.QuestionUnits;
import com.example.demo.dao.QuestionUnitsDao;
import com.example.demo.service.QuestionUnitsService;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;


import javax.annotation.Resource;

/**
 * (QuestionUnits)表服务实现类
 *
 * @author makejava
 * @since 2023-06-23 09:31:50
 */
@Service("questionUnitsService")
public class QuestionUnitsServiceImpl implements QuestionUnitsService {
    @Resource
    private QuestionUnitsDao questionUnitsDao;

    /**
     * 通过ID查询单条数据
     *
     * @param questionUnitId 主键
     * @return 实例对象
     */
    @Override
    public QuestionUnits queryById(Integer questionUnitId) {
        return this.questionUnitsDao.queryById(questionUnitId);
    }

    /**
     * 分页查询
     *
     * @param questionUnits 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @Override
    public Page<QuestionUnits> queryByPage(QuestionUnits questionUnits, Pageable pageRequest) {
        long total = this.questionUnitsDao.count(questionUnits);
        return new PageImpl<>(this.questionUnitsDao.queryAllByLimit(questionUnits, pageRequest), pageRequest, total);
    }

    /**
     * 新增数据
     *
     * @param questionUnits 实例对象
     * @return 实例对象
     */
    @Override
    public QuestionUnits insert(QuestionUnits questionUnits) {
        this.questionUnitsDao.insert(questionUnits);
        return questionUnits;
    }

    /**
     * 修改数据
     *
     * @param questionUnits 实例对象
     * @return 实例对象
     */
    @Override
    public QuestionUnits update(QuestionUnits questionUnits) {
        this.questionUnitsDao.update(questionUnits);
        return this.queryById(questionUnits.getQuestionUnitId());
    }

    /**
     * 通过主键删除数据
     *
     * @param questionUnitId 主键
     * @return 是否成功
     */
    @Override
    public boolean deleteById(Integer questionUnitId) {
        return this.questionUnitsDao.deleteById(questionUnitId) > 0;
    }
}
