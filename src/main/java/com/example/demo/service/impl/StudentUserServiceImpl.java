package com.example.demo.service.impl;

import com.example.demo.entity.StudentUser;
import com.example.demo.dao.StudentUserDao;
import com.example.demo.service.StudentUserService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
     * 用户注册
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
     * 用户登陆
     *
     * @param usernameOrEmail 用户名或邮箱
     * @param password        密码
     * @return 实例对象
     */
    @Override
    public StudentUser login(String usernameOrEmail, String password) {
        StudentUser user = studentUserDao.findByUsername(usernameOrEmail);
        if (user == null) {
            user = studentUserDao.findByEmail(usernameOrEmail);
        }

        if (user != null) {
            BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
            if (passwordEncoder.matches(password, user.getPassword())) {
                return user;
            }
        }

        throw new RuntimeException("Invalid credentials");
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
