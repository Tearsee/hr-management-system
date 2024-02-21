package com.turing.mapper;

import com.turing.pojo.Employee;
import org.apache.ibatis.annotations.Insert;
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

    /**
     * 添加员工
     * @param employee
     */
    @Insert("insert into tb_employee values (null,#{staffId},#{employeeName},#{age},#{employmentStatus},#{salary},#{basicSalary},#{attendanceCount},#{performance})")
    void add(Employee employee);
}
