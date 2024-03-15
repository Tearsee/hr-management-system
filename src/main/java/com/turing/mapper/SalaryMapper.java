package com.turing.mapper;

import com.turing.pojo.*;
import com.turing.pojo.Salary;
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
     * 添加
     * @param salaryQuery
     */
    @Insert("insert into empsalary values (null,#{eid},#{sal},#{basicSalary},#{performance},#{month})")
    void add(SalaryQuery salaryQuery);


    /**
     * 分页条件查询
     * @param begin
     * @param size
     * @return
     */
    List<SalaryQuery> selectByPageAndCondition(@Param("begin") int begin, @Param("size") int size, @Param("salaryQuery") SalaryQuery salaryQuery);

    /**
     * 根据条件查询总条数
     * @param salaryQuery
     * @return
     */
    int selectTotalCountByCondition(SalaryQuery salaryQuery);
}
