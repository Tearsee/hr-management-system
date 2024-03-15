package com.turing.service.impl;

import com.turing.mapper.EmployeeMapper;
import com.turing.mapper.SalaryMapper;
import com.turing.mapper.VacateMapper;
import com.turing.pojo.*;
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
        SalaryMapper salaryQuery = sqlSession.getMapper(SalaryMapper.class);

        // 执行方法
        List<Salary> salaries = salaryQuery.selectAll();

        // 释放资源
        sqlSession.close();

        // 返回查询结果
        return salaries;
    }

    @Override
    public void add(SalaryQuery salaryQuery) {
        // 获取SQLSession
        SqlSession sqlSession = factory.openSession();

        // 获取mapper
        SalaryMapper salaryMapper = sqlSession.getMapper(SalaryMapper.class);

        // 执行方法
        salaryMapper.add(salaryQuery);

        // 提交事务
        sqlSession.commit();

        // 释放资源
        sqlSession.close();

    }

    @Override
    public PageBean<SalaryQuery> selectByPageAndCondition(int currentPage, int pageSize, SalaryQuery salaryQuery) {
        // 获取SQLSession
        SqlSession sqlSession = factory.openSession();

        // 获取mapper
        SalaryMapper salaryMapper = sqlSession.getMapper(SalaryMapper.class);

        // 计算开始索引
        int begin = (currentPage - 1) * pageSize;
        // 计算查询条目数
        int size = pageSize;

        // 处理employee条件 ，设置模糊表达式

        String employeeName = salaryQuery.getEmployeeName();
        if(employeeName != null && employeeName.length() > 0){
            salaryQuery.setEmployeeName("%" + employeeName + "%");
        }

        // 查询当前页数据
        List<SalaryQuery> rows = salaryMapper.selectByPageAndCondition(begin, size,salaryQuery);

        // 查询总记录数
        int totalCount = salaryMapper.selectTotalCountByCondition(salaryQuery);

        // 封装PageBean 对象
        PageBean<SalaryQuery> pageBean = new PageBean<>();
        pageBean.setRows(rows);
        pageBean.setTotalCount(totalCount);

        /*List<SalaryQuery> rows1 = pageBean.getRows();
        for (int i = 0; i < pageBean.getRows().size(); i++) {
            System.out.println(rows1.get(i).toString());
        }*/
        // 释放资源
        sqlSession.close();

        return pageBean;
    }
}
