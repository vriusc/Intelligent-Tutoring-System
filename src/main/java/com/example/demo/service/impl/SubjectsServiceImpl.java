package com.example.demo.service.impl;

import com.example.demo.entity.Subjects;
import com.example.demo.dao.SubjectsDao;
import com.example.demo.service.SubjectsService;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;

import javax.annotation.Resource;

/**
 * (Subjects)表服务实现类
 *
 * @author qianyongru
 * @since 2023-06-22 06:24:38
 */
@Service("subjectsService")
public class SubjectsServiceImpl implements SubjectsService {
    @Resource
    private SubjectsDao subjectsDao;

    /**
     * 通过ID查询单条数据
     *
     * @param subjectId 主键
     * @return 实例对象
     */
    @Override
    public Subjects queryById(Integer subjectId) {
        return this.subjectsDao.queryById(subjectId);
    }

    /**
     * 分页查询
     *
     * @param subjects 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @Override
    public Page<Subjects> queryByPage(Subjects subjects, Pageable pageRequest) {
        long total = this.subjectsDao.count(subjects);
        return new PageImpl<>(this.subjectsDao.queryAllByLimit(subjects, pageRequest), pageRequest, total);
    }

    /**
     * 新增数据
     *
     * @param subjects 实例对象
     * @return 实例对象
     */
    @Override
    public Subjects insert(Subjects subjects) {
        this.subjectsDao.insert(subjects);
        return subjects;
    }

    /**
     * 修改数据
     *
     * @param subjects 实例对象
     * @return 实例对象
     */
    @Override
    public Subjects update(Subjects subjects) {
        this.subjectsDao.update(subjects);
        return this.queryById(subjects.getSubjectId());
    }

    /**
     * 通过主键删除数据
     *
     * @param subjectId 主键
     * @return 是否成功
     */
    @Override
    public boolean deleteById(Integer subjectId) {
        return this.subjectsDao.deleteById(subjectId) > 0;
    }
}
