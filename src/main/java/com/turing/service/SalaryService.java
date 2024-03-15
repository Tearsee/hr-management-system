package com.turing.service;

import com.turing.pojo.*;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface SalaryService {
    /**
     * 查询所有
     * @return
     */
    List<Salary> selectAll();

    void add(SalaryQuery salaryQuery);

    /**
     * 分页条件查询
     * @param currentPage
     * @param pageSize
     * @param salaryQuery
     * @return
     */
    PageBean<SalaryQuery> selectByPageAndCondition(int currentPage, int pageSize, SalaryQuery salaryQuery);

}
