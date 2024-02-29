package com.turing.mapper;

import com.turing.pojo.Employee;
import org.apache.ibatis.annotations.*;

import java.util.List;


public interface EmployeeMapper {
    // 管理员操作
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
    @Insert("insert into tb_employee values (null,#{employeeName},#{age},#{email},#{phone},#{deptId},#{posId},#{employmentStatus},#{staffId})")
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
     * 根据条件查询总条数
     * @param employee
     * @return
     */
    int selectTotalCountByCondition(Employee employee);

    /**
     * 修改员工信息
     * @param employee
     * @return
     */
    @Update("update tb_employee set staff_id=#{staffId},employee_name=#{employeeName},age=#{age},employment_status=#{employmentStatus},email=#{email},phone=#{phone},dept_id=#{deptId},pos_id=#{posId} where id=#{id}")
    void updateById(Employee employee);

    /**
     * 软删除
     * @param id
     */
    @Update("update tb_employee set employment_status=0 where id=#{id}")
    void softDeleteById(int id);

    // 员工操作

    /**
     * 查看个人信息
     * @param staffId
     * @return
     */
    @Select("select * from tb_employee where staff_id=#{staffId}")
    @ResultMap("employeeResultMap")
    Employee selectOneById(String staffId);



}
