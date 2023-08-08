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
 * (Subjects) table services implement class
 *
 * @author qianyongru
 * @since 2023-06-22 06:24:38
 */
@Service("subjectsService")
public class SubjectsServiceImpl implements SubjectsService {
    @Resource
    private SubjectsDao subjectsDao;

    /**
     * query By id
     *
     * @param subjectId primary key
     * @return object
     */
    @Override
    public Subjects queryById(Integer subjectId) {
        return this.subjectsDao.queryById(subjectId);
    }

    /**
     * query By limit
     *
     * @param subjects       query condition
     * @param pageRequest      page request
     * @return object list
     */
    @Override
    public Page<Subjects> queryByPage(Subjects subjects, Pageable pageRequest) {
        long total = this.subjectsDao.count(subjects);
        return new PageImpl<>(this.subjectsDao.queryAllByLimit(subjects, pageRequest), pageRequest, total);
    }

    /**
     * add new data
     *
     * @param subjects object
     * @return object
     */
    @Override
    public Subjects insert(Subjects subjects) {
        this.subjectsDao.insert(subjects);
        return subjects;
    }

    /**
     * update data
     *
     * @param subjects object
     * @return object
     */
    @Override
    public Subjects update(Subjects subjects) {
        this.subjectsDao.update(subjects);
        return this.queryById(subjects.getSubjectId());
    }

    /**
     * delete By id
     *
     * @param subjectId primary key
     * @return boolean
     */
    @Override
    public boolean deleteById(Integer subjectId) {
        return this.subjectsDao.deleteById(subjectId) > 0;
    }
}
