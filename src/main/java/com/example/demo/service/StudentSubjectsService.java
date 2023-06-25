package com.example.demo.service;

import com.example.demo.entity.StudentSubjects;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

import java.util.List;

/**
 * (StudentSubjects)表服务接口
 *
 * @author qianyongru
 * @since 2023-06-22 06:25:52
 */
public interface StudentSubjectsService {

    /**
     * 通过ID查询单条数据
     *
     * @param studentSubjectId 主键
     * @return 实例对象
     */
    StudentSubjects queryById(Integer studentSubjectId);

    /**
     * 分页查询
     *
     * @param studentSubjects 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    Page<StudentSubjects> queryByPage(StudentSubjects studentSubjects, PageRequest pageRequest);


    /**
     * 新增数据
     *
     * @param studentSubjects 实例对象
     * @return 实例对象
     */
    StudentSubjects insert(StudentSubjects studentSubjects);

    /**
     * 修改数据
     *
     * @param studentSubjects 实例对象
     * @return 实例对象
     */
    StudentSubjects update(StudentSubjects studentSubjects);

    /**
     * 通过主键删除数据
     *
     * @param studentSubjectId 主键
     * @return 是否成功
     */
    boolean deleteById(Integer studentSubjectId);


    /**
     * 通过学生id查询
     *
     * @param studentId 学生id
     * @return 实例对象
     */

    List<StudentSubjects> queryByStudentId(Integer studentId);


}
