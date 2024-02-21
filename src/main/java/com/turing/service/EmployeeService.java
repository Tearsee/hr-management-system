package com.turing.service;

import com.turing.pojo.Employee;

import java.util.List;

public interface EmployeeService {
    /**
     * 查询所有
     * @return
     */
    List<Employee> selectAll();

    /**
     * 添加员工
     * @param emp
     */
    void add(Employee emp);
}
