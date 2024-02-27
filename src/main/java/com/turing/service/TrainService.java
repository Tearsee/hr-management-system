package com.turing.service;

import com.turing.pojo.Employee;
import com.turing.pojo.Train;
import org.apache.ibatis.annotations.Insert;

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
}
