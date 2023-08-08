package com.example.demo.service.impl;

import com.example.demo.entity.StudentSubjects;
import com.example.demo.dao.StudentSubjectsDao;
import com.example.demo.service.StudentSubjectsService;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;

import javax.annotation.Resource;
import java.util.List;

/**
 * (StudentSubjects) table services implement class
 *
 * @author qianyongru
 * @since 2023-06-22 06:25:52
 */
@Service("studentSubjectsService")
public class StudentSubjectsServiceImpl implements StudentSubjectsService {
    @Resource
    private StudentSubjectsDao studentSubjectsDao;

    /**
     * query By id
     *
     * @param studentSubjectId primary key
     * @return object
     */
    @Override
    public StudentSubjects queryById(Integer studentSubjectId) {
        return this.studentSubjectsDao.queryById(studentSubjectId);
    }

    /**
     * query By limit
     *
     * @param studentSubjects condition
     * @param pageRequest page request
     * @return object list
     */
    @Override
    public Page<StudentSubjects> queryByPage(StudentSubjects studentSubjects, PageRequest pageRequest) {
        long total = this.studentSubjectsDao.count(studentSubjects);
        return new PageImpl<>(this.studentSubjectsDao.queryAllByLimit(studentSubjects, pageRequest), pageRequest, total);
    }

    /**
     * add new data
     *
     * @param studentSubjects object
     * @return object
     */
    @Override
    public StudentSubjects insert(StudentSubjects studentSubjects) {
        this.studentSubjectsDao.insert(studentSubjects);
        return studentSubjects;
    }

    /**
     * update data
     *
     * @param studentSubjects object
     * @return object
     */
    @Override
    public StudentSubjects update(StudentSubjects studentSubjects) {
        this.studentSubjectsDao.update(studentSubjects);
        return this.queryById(studentSubjects.getStudentSubjectId());
    }

    /**
     * delete By id
     *
     * @param studentSubjectId primary key
     * @return boolean
     */
    @Override
    public boolean deleteById(Integer studentSubjectId) {
        return this.studentSubjectsDao.deleteById(studentSubjectId) > 0;
    }

    /**
     * query By studentId
     *
     * @param studentId primary key
     * @return object list
     */
    @Override
    public List<StudentSubjects> queryByStudentId(Integer studentId) {
        return this.studentSubjectsDao.queryByStudentId(studentId);  // 实现的方法
    }


}
