package com.turing.service.impl;

import com.turing.mapper.VacateMapper;
import com.turing.pojo.Vacate;
import com.turing.pojo.PageBean;
import com.turing.service.VacateService;
import com.turing.util.SqlSessionFactoryUtils;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.util.List;

public class VacateServiceImpl implements VacateService {
    // 创建sqlSession 工厂
    private static SqlSessionFactory factory = SqlSessionFactoryUtils.getSqlSessionFactory();

    /**
     * 分页条件查询
     * @param currentPage
     * @param pageSize
     * @param vacate
     * @return
     */
    @Override
    public PageBean<Vacate> selectByPageAndCondition(int currentPage, int pageSize, Vacate vacate) {
        // 获取SQLSession
        SqlSession sqlSession = factory.openSession();

        // 获取mapper
        VacateMapper vacateMapper = sqlSession.getMapper(VacateMapper.class);

        // 计算开始索引
        int begin = (currentPage - 1) * pageSize;
        // 计算查询条目数
        int size = pageSize;

        // 查询当前页数据
        List<Vacate> rows = vacateMapper.selectByPageAndCondition(begin, size,vacate);

        // 查询总记录数
        int totalCount = vacateMapper.selectTotalCountByCondition(vacate);

        // 封装PageBean 对象
        PageBean<Vacate> pageBean = new PageBean<>();
        pageBean.setRows(rows);
        pageBean.setTotalCount(totalCount);

        // 释放资源
        sqlSession.close();

        return pageBean;
    }

    /**
     * 设置审批状态
     * @param id
     * @param status
     */
    @Override
    public void updateById(int id, int status) {
        // 获取SQLSession
        SqlSession sqlSession = factory.openSession();

        // 获取mapper
        VacateMapper vacateMapper = sqlSession.getMapper(VacateMapper.class);

        // 执行方法
        vacateMapper.updateById(id,status);

        // 提交事务
        sqlSession.commit();

        // 释放资源
        sqlSession.close();
    }
}
