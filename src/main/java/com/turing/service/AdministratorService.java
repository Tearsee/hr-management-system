package com.turing.service;

import com.turing.pojo.Employee;
import com.turing.pojo.Messages;
import com.turing.pojo.PageBean;
import org.apache.ibatis.annotations.Select;

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

    /**
     * 分页条件查询
     * @param currentPage
     * @param pageSize
     * @param employee
     * @return
     */
    PageBean<Employee> selectByPageAndCondition(int currentPage, int pageSize,Employee employee);

    /**
     * 修改员工信息
     * @param employee
     */
    void updateById(Employee employee);
    /**
     * 软删除
     * @param id
     */
    void softDeleteById(int id);

    // 管理员操作
    /**
     * 查询所有
     * @return
     */
    List<Messages> receive();
}
