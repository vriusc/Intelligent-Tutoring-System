package com.example.demo.service.impl;

import com.example.demo.entity.StudentSubjects;
import com.example.demo.dao.StudentSubjectsDao;
import com.example.demo.service.StudentSubjectsService;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;

import javax.annotation.Resource;

/**
 * (StudentSubjects)表服务实现类
 *
 * @author makejava
 * @since 2023-06-22 06:25:52
 */
@Service("studentSubjectsService")
public class StudentSubjectsServiceImpl implements StudentSubjectsService {
    @Resource
    private StudentSubjectsDao studentSubjectsDao;

    /**
     * 通过ID查询单条数据
     *
     * @param studentSubjectId 主键
     * @return 实例对象
     */
    @Override
    public StudentSubjects queryById(Integer studentSubjectId) {
        return this.studentSubjectsDao.queryById(studentSubjectId);
    }

    /**
     * 分页查询
     *
     * @param studentSubjects 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @Override
    public Page<StudentSubjects> queryByPage(StudentSubjects studentSubjects, PageRequest pageRequest) {
        long total = this.studentSubjectsDao.count(studentSubjects);
        return new PageImpl<>(this.studentSubjectsDao.queryAllByLimit(studentSubjects, pageRequest), pageRequest, total);
    }

    /**
     * 新增数据
     *
     * @param studentSubjects 实例对象
     * @return 实例对象
     */
    @Override
    public StudentSubjects insert(StudentSubjects studentSubjects) {
        this.studentSubjectsDao.insert(studentSubjects);
        return studentSubjects;
    }

    /**
     * 修改数据
     *
     * @param studentSubjects 实例对象
     * @return 实例对象
     */
    @Override
    public StudentSubjects update(StudentSubjects studentSubjects) {
        this.studentSubjectsDao.update(studentSubjects);
        return this.queryById(studentSubjects.getStudentSubjectId());
    }

    /**
     * 通过主键删除数据
     *
     * @param studentSubjectId 主键
     * @return 是否成功
     */
    @Override
    public boolean deleteById(Integer studentSubjectId) {
        return this.studentSubjectsDao.deleteById(studentSubjectId) > 0;
    }
}
