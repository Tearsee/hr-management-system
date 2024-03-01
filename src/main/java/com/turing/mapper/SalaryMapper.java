package com.turing.mapper;

import com.turing.pojo.Employee;
import com.turing.pojo.Salary;
import com.turing.pojo.Vacate;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface SalaryMapper {
    // 管理员操作
    /**
     * 查询所有
     * @return
     */
    @Select("select * from empsalary")
    List<Salary> selectAll();


    /**
     * 添加员工
     * @param salary
     */
    @Insert("insert into empsalary values (null,#{eid},#{sal},#{basicSalary},#{performance})")
    void add(Salary salary);

}
