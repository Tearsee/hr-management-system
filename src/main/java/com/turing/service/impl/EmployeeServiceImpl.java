package com.turing.service.impl;

import com.turing.mapper.EmployeeMapper;
import com.turing.pojo.Employee;
import com.turing.pojo.PageBean;
import com.turing.service.EmployeeService;
import com.turing.util.SqlSessionFactoryUtils;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.util.List;

public class EmployeeServiceImpl implements EmployeeService{
    // 创建sqlSession 工厂
    private static SqlSessionFactory factory = SqlSessionFactoryUtils.getSqlSessionFactory();
    /**
     * 查看员工个人信息
     * @param id
     * @return
     */
    @Override
    public Employee selectOneById(int id) {
        // 获取SQLSession
        SqlSession sqlSession = factory.openSession();

        // 获取mapper
        EmployeeMapper employeeMapper = sqlSession.getMapper(EmployeeMapper.class);

        // 执行方法
        Employee employee = employeeMapper.selectOneById(id);

        // 释放资源
        sqlSession.close();

        // 返回查询结果
        return employee;
    }


    /**
     * 修改员工信息( 不包括 名字)
     * @param employee
     */
    @Override
    public void updateById(Employee employee) {
        // 获取SQLSession
        SqlSession sqlSession = factory.openSession();

        // 获取mapper
        EmployeeMapper employeeMapper = sqlSession.getMapper(EmployeeMapper.class);

        // 执行方法
        employeeMapper.updateById(employee);

        // 提交事务
        sqlSession.commit();

        // 释放资源
        sqlSession.close();
    }
}
