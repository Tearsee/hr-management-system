package com.turing.service;

import com.turing.pojo.Employee;
import com.turing.pojo.PageBean;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface EmployeeService {

    /**
     * 查看个人信息
     * @param id
     * @return
     */
    @Select("select * from tb_employee where id=#{id}")
    Employee selectOneById(int id);


    /**
     * 修改员工信息
     * @param employee
     */
    void updateById(Employee employee);

}
