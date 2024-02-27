package com.turing.service;

import com.turing.pojo.Employee;
import com.turing.pojo.Train;

import java.util.List;

public interface TrainService {

    /**
     * 查询所有
     * @return
     */
    List<Train> selectAll();
}
