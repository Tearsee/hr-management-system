package com.turing.service;

import com.turing.pojo.Employee;
import com.turing.pojo.PageBean;

import java.util.List;

public interface AdministratorService {
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

    /**
     * 分页查询
     * @param currentPage 当前页码
     * @param pageSize 每页展示条数
     * @return
     */
    PageBean<Employee> selectByPage(int currentPage, int pageSize);

    /**
     * 批量删除
     * @param ids
     */
    void deleteByIds(int[] ids);
}
