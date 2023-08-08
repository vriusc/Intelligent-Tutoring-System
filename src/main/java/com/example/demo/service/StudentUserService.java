package com.example.demo.service;

import com.example.demo.entity.StudentUser;


/**
 * (StudentUser) table services interface
 *
 * @author qianyongru
 * @since 2023-06-21 06:36:40
 */
public interface StudentUserService {

    /**
     * query By id
     *
     * @param id primary key
     * @return entity
     */
    StudentUser queryById(Integer id);

    /**
     * add new data
     *
     * @param studentUser entity
     * @return entity
     */
    StudentUser insert(StudentUser studentUser);

    /**
     * user login
     *
     * @param usernameOrEmail email or username
     * @param password password
     * @return entity
     */

    StudentUser login(String usernameOrEmail, String password);

    /**
     * update data
     *
     * @param studentUser entity
     * @return entity
     */
    StudentUser update(StudentUser studentUser);

    /**
     * change password
     *
     * @param username username
     * @param email email
     * @param currentPassword password
     * @param newPassword new password
     */
    void updatePassword(String username, String email, String currentPassword, String newPassword);
    /**
     * delete By id
     *
     * @param id primary key
     * @return boolean
     */
    boolean deleteById(Integer id);

}
