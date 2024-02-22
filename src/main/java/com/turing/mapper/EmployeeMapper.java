package com.turing.mapper;

import com.turing.pojo.Employee;
import org.apache.ibatis.annotations.*;

import java.util.List;


public interface EmployeeMapper {
    /**
     * 查询所有
     * @return
     */
    @Select("select * from tb_employee")
    @ResultMap("employeeResultMap")
    List<Employee> selectAll();

    /**
     * 添加员工
     * @param employee
     */
    @Insert("insert into tb_employee values (null,#{staffId},#{employeeName},#{age},#{employmentStatus},#{salary},#{basicSalary},#{attendanceCount},#{performance})")
    void add(Employee employee);

    /**
     * 分页查询
     * @param begin
     * @param size
     * @return
     */
    @Select("select * from tb_employee limit #{begin},#{size}")
    @ResultMap("employeeResultMap")
    List<Employee> selectByPage(@Param("begin") int begin, @Param("size") int size);

    /**
     * 查询总条数
     * @return
     */
    @Select("select count(*) from tb_employee")
    int selectTotalCount();

    /**
     * 批量删除
     * @param ids
     */
    void deleteByIds(@Param("ids") int[] ids);

    /**
     * 分页条件查询
     * @param begin
     * @param size
     * @return
     */
       List<Employee> selectByPageAndCondition(@Param("begin") int begin, @Param("size") int size,@Param("employee") Employee employee);

    /**
     * 根据条件查询总记录数
     * @param employee
     * @return
     */
    int selectTotalCountByCondition(Employee employee);

}
