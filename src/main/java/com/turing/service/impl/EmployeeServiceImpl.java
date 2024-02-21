package com.turing.service.impl;

import com.turing.mapper.EmployeeMapper;
import com.turing.pojo.Employee;
import com.turing.service.EmployeeService;
import com.turing.util.SqlSessionFactoryUtils;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.util.List;

public class EmployeeServiceImpl implements EmployeeService {
    // 创建sqlSession 工厂
    private static SqlSessionFactory factory =  SqlSessionFactoryUtils.getSqlSessionFactory();
    /**
     * 查询所有
     * @return
     */
    @Override
    public List<Employee> selectAll() {
        // 获取SQLSession
        SqlSession sqlSession = factory.openSession();

        // 获取mapper
        EmployeeMapper employeeMapper = sqlSession.getMapper(EmployeeMapper.class);

        // 执行方法
        List<Employee> employees = employeeMapper.selectAll();

        // 释放资源
        sqlSession.close();

        // 返回查询结果
        return employees;
    }
}
