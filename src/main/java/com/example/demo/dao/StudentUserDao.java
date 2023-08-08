package com.example.demo.dao;

import com.example.demo.entity.StudentUser;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.Pageable;
import java.util.List;

/**
 * (StudentUser) table dao
 *
 * @author qianyongru
 * @since 2023-06-21 06:36:40
 */
@Mapper
public interface StudentUserDao {
    /**
     * query by id
     *
     * @param id primary key
     * @return object
     */
    StudentUser queryById(Integer id);

    /**
     * 查询所有数据
     *
     * @param studentUser object
     * @return List<StudentUser>
     */

    int insert(StudentUser studentUser);

    /**
     * insert batch
     *
     * @param studentUser List<StudentUser>
     * @param pageable pageable
     * @return row
     */
    List<StudentUser> queryAllByLimit(StudentUser studentUser, @Param("pageable") Pageable pageable);

    /**
     * query count
     *
     * @param studentUser object
     * @return long
     */
    int update(StudentUser studentUser);

    /**
     * update data
     *
     * @param id primary key
     * @return row
     */
    int deleteById(Integer id);

    /**
     * delete by primary key
     *
     * @param username username
     * @return username
     */
    String queryByUsername(String username);

    /**
     * delete by primary key
     *
     * @param email email
     * @return email
     */
    String queryByEmail(String email);


    /**
     * @param  username username
     * @return 用户对象
     */
    StudentUser findByUsername(String username);

    /**
     * @param email email
     * @return 用户对象
     */

    StudentUser findByEmail(String email);
}

