package com.example.demo.service;

import com.example.demo.entity.QuestionTypes;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * (QuestionTypes)表服务接口
 *
 * @author qianyongru
 * @since 2023-06-23 08:12:09
 */
public interface QuestionTypesService {

    /**
     * 通过ID查询单条数据
     *
     * @param questionTypeId 主键
     * @return 实例对象
     */
    QuestionTypes queryById(Integer questionTypeId);

    /**
     * 分页查询
     *
     * @param questionTypes 筛选条件
     * @param pageRequest      分页对象
     * @return 查询结果
     */
    Page<QuestionTypes> queryByPage(QuestionTypes questionTypes, Pageable pageRequest);

    /**
     * 新增数据
     *
     * @param questionTypes 实例对象
     * @return 实例对象
     */
    QuestionTypes insert(QuestionTypes questionTypes);

    /**
     * 修改数据
     *
     * @param questionTypes 实例对象
     * @return 实例对象
     */
    QuestionTypes update(QuestionTypes questionTypes);

    /**
     * 通过主键删除数据
     *
     * @param questionTypeId 主键
     * @return 是否成功
     */
    boolean deleteById(Integer questionTypeId);

}
