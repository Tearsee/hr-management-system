package com.turing.service;

import com.turing.pojo.PageBean;
import com.turing.pojo.Salary;
import com.turing.pojo.Vacate;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface SalaryService {
    /**
     * 查询所有
     * @return
     */
    List<Salary> selectAll();

    void add(Salary salary);
}
