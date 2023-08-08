package com.example.demo.dao;

import com.example.demo.entity.Record;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.data.domain.Pageable;
import java.util.List;

/**
 * (Record) table dao
 *
 * @author qianyongru
 * @since 2023-06-23 19:27:35
 */
@Mapper
public interface RecordDao {

    /**
     * query by id
     *
     * @param recordId primary key
     * @return object
     */
    Record queryById(Integer recordId);

    /**
     * query all by limit
     *
     * @param record condition
     * @param pageable pageable
     * @return List<Record>
     */
    List<Record> queryAllByLimit(@Param("record") Record record, @Param("pageable") Pageable pageable);

    /**
     * query count
     *
     * @param record condition
     * @return long
     */
    long count(Record record);

    /**
     * add data
     *
     * @param record entity
     * @return row
     */
    int insert(Record record);

    /**
     * add batch
     *
     * @param entities List<Record> entities
     * @return row
     */
    int insertBatch(@Param("entities") List<Record> entities);

    /**
     * add or update batch
     *
     * @param entities List<Record> entities
     * @return row
     * @throws org.springframework.jdbc.BadSqlGrammarException if the SQL is malformed
     */
    int insertOrUpdateBatch(@Param("entities") List<Record> entities);

    /**
     * update data
     *
     * @param record entity
     * @return row
     */
    int update(Record record);

    /**
     * delete by id
     *
     * @param recordId primary key
     * @return row
     */
    int deleteById(Integer recordId);

}

