package com.turing.service.impl;

import com.turing.mapper.EmployeeMapper;
import com.turing.mapper.SalaryMapper;
import com.turing.mapper.VacateMapper;
import com.turing.pojo.Employee;
import com.turing.pojo.PageBean;
import com.turing.pojo.Salary;
import com.turing.pojo.Vacate;
import com.turing.service.SalaryService;
import com.turing.service.VacateService;
import com.turing.util.SqlSessionFactoryUtils;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.util.List;

public class SalaryServiceImpl implements SalaryService {
    // 创建sqlSession 工厂
    private static SqlSessionFactory factory = SqlSessionFactoryUtils.getSqlSessionFactory();

    @Override
    public List<Salary> selectAll() {
        // 获取SQLSession
        SqlSession sqlSession = factory.openSession();

        // 获取mapper
        SalaryMapper salaryMapper = sqlSession.getMapper(SalaryMapper.class);

        // 执行方法
        List<Salary> employees = salaryMapper.selectAll();

        // 释放资源
        sqlSession.close();

        // 返回查询结果
        return employees;
    }

    @Override
    public void add(Salary salary) {
        // 获取SQLSession
        SqlSession sqlSession = factory.openSession();

        // 获取mapper
        SalaryMapper salaryMapper = sqlSession.getMapper(SalaryMapper.class);

        // 执行方法
        salaryMapper.add(salary);

        // 提交事务
        sqlSession.commit();

        // 释放资源
        sqlSession.close();

    }
}
