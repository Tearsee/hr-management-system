package com.turing.service;

import com.turing.pojo.Employee;
import com.turing.pojo.PageBean;
import com.turing.pojo.Train;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface TrainService {

    /**
     * 查询所有
     * @return
     */
    List<Train> selectAll();

    /**
     * 添加培训计划
     * @param train
     */
    void add(Train train);

    /**
     * 批量删除
     * @param ids
     */
    void deleteByIds(@Param("ids") int[] ids);

    /**
     * 修改培训信息
     * @param train
     * @return
     */
    void updateById(Train train);

    /**
     * 分页查询
     * @param currentPage 当前页码
     * @param pageSize 每页展示条数
     * @return
     */
    PageBean<Train> selectByPage(int currentPage, int pageSize);

    /**
     * 分页条件查询
     * @param currentPage
     * @param pageSize
     * @param train
     * @return
     */
    PageBean<Train> selectByPageAndCondition(int currentPage, int pageSize,Train train);
}
