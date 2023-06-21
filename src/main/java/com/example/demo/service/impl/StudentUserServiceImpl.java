package com.example.demo.service.impl;

import com.example.demo.entity.StudentUser;
import com.example.demo.dao.StudentUserDao;
import com.example.demo.service.StudentUserService;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;

import javax.annotation.Resource;

/**
 * (StudentUser)表服务实现类
 *
 * @author makejava
 * @since 2023-06-21 06:36:40
 */
@Service("studentUserService")
public class StudentUserServiceImpl implements StudentUserService {
    @Resource
    private StudentUserDao studentUserDao;

    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    @Override
    public StudentUser queryById(Integer id) {
        return this.studentUserDao.queryById(id);
    }

    /**
     * 分页查询
     *
     * @param studentUser 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    @Override
    public Page<StudentUser> queryByPage(StudentUser studentUser, PageRequest pageRequest) {
        long total = this.studentUserDao.count(studentUser);
        return new PageImpl<>(this.studentUserDao.queryAllByLimit(studentUser, pageRequest), pageRequest, total);
    }

    /**
     * 新增数据
     *
     * @param studentUser 实例对象
     * @return 实例对象
     */
    @Override
    public StudentUser insert(StudentUser studentUser) {
        if(studentUserDao.queryByUsername(studentUser.getUsername()) != null) {
            throw new RuntimeException("Username already exists");
        }
        if(studentUserDao.queryByEmail(studentUser.getEmail()) != null) {
            throw new RuntimeException("Email already exists");
        }
        int result = studentUserDao.insert(studentUser);
        if(result == 1) {
            return studentUser;
        } else {
            throw new RuntimeException("Insert failed");
        }
    }

    /**
     * 修改数据
     *
     * @param studentUser 实例对象
     * @return 实例对象
     */
    @Override
    public StudentUser update(StudentUser studentUser) {
        this.studentUserDao.update(studentUser);
        return this.queryById(studentUser.getId());
    }

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 是否成功
     */
    @Override
    public boolean deleteById(Integer id) {
        return this.studentUserDao.deleteById(id) > 0;
    }
}
