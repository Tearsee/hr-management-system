package com.turing.mapper;

import com.turing.pojo.Employee;
import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;

import java.util.List;


public interface EmployeeMapper {
    /**
     * 查询所有
     * @return
     */
    @Select("select * from tb_employee")
    @ResultMap("EmployeeResultMap")
    List<Employee> selectAll();
}
