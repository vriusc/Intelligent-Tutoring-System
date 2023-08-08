package com.example.demo.dao;

import com.example.demo.entity.Units;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.Pageable;
import java.util.List;

/**
 * (Units) table dao
 *
 * @author   qianyongru
 * @since 2023-06-22 20:46:33
 */
@Mapper
public interface UnitsDao {

    /**
     * query by id
     *
     * @param unitId primary key
     * @return object
     */
    Units queryById(Integer unitId);

    /**
     * query all by limit
     *
     * @param units condition
     * @param pageable pageable
     * @return List<Units>
     */
    List<Units> queryAllByLimit(Units units, @Param("pageable") Pageable pageable);

    /**
     * query count
     *
     * @param units condition
     * @return row
     */
    long count(Units units);

    /**
     * add data
     *
     * @param units entity
     * @return row
     */
    int insert(Units units);


    /**
     * add batch
     *
     * @param units List<Units> entities
     * @return row
     */
    int update(Units units);

    /**
     * add or update batch
     *
     * @param unitId primary key
     * @return row
     */
    int deleteById(Integer unitId);


    /**
     * update data
     *
     * @param subjectId primary key
     * @return row
     */
    List<Units> queryBySubjectId(Integer subjectId);

}

