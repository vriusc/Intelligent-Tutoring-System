package com.example.demo.service.impl;

import com.example.demo.entity.StudentUser;
import com.example.demo.dao.StudentUserDao;
import com.example.demo.service.StudentUserService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;


import javax.annotation.Resource;

/**
 * (StudentUser) table services implement class
 *
 * @author qianyongru
 * @since 2023-06-21 06:36:40
 */
@Service("studentUserService")
public class StudentUserServiceImpl implements StudentUserService {
    @Resource
    private StudentUserDao studentUserDao;

    /**
     * query By id
     *
     * @param id primary key
     * @return entity
     */
    @Override
    public StudentUser queryById(Integer id) {
        return this.studentUserDao.queryById(id);
    }


    /**
     * add new data
     *
     * @param studentUser entity
     * @return entity
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
     * user login
     *
     * @param usernameOrEmail username or email
     * @param password password
     * @return entity
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

    public void updatePassword(String username, String email, String currentPassword, String newPassword) {
        StudentUser user = studentUserDao.findByUsername(username);
        if (user != null && user.getEmail().equals(email)) {
            // 使用BCryptPasswordEncoder对当前密码进行验证
            BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
            if (passwordEncoder.matches(currentPassword, user.getPassword())) {
                // 验证成功，使用BCryptPasswordEncoder对新密码进行加密
                String hashedPassword = passwordEncoder.encode(newPassword);

                // 更新用户密码
                user.setPassword(hashedPassword);
                studentUserDao.update(user);
            } else {
                throw new RuntimeException("Invalid current password");
            }
        } else {
            throw new RuntimeException("Invalid username or email");
        }
    }

    /**
     * update data
     *
     * @param studentUser entity
     * @return entity
     */
    @Override
    public StudentUser update(StudentUser studentUser) {
        this.studentUserDao.update(studentUser);
        return this.queryById(studentUser.getId());
    }

    /**
     * delete By id
     *
     * @param id primary key
     * @return boolean
     */
    @Override
    public boolean deleteById(Integer id) {
        return this.studentUserDao.deleteById(id) > 0;
    }
}
