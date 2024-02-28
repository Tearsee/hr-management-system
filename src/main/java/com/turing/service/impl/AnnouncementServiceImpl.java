package com.turing.service.impl;

import com.turing.mapper.AnnouncementMapper;
import com.turing.mapper.EmployeeMapper;
import com.turing.mapper.TrainMapper;
import com.turing.pojo.Announcement;
import com.turing.pojo.PageBean;
import com.turing.pojo.Train;
import com.turing.service.AnnouncementService;
import com.turing.service.TrainService;
import com.turing.util.SqlSessionFactoryUtils;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.util.List;

public class AnnouncementServiceImpl implements AnnouncementService {
    // 创建sqlSession 工厂
    private static SqlSessionFactory factory = SqlSessionFactoryUtils.getSqlSessionFactory();
    /**
     * 分页查询
     * @param currentPage 当前页码
     * @param pageSize 每页展示条数
     * @return
     */
    @Override
    public PageBean<Announcement> selectByPage(int currentPage, int pageSize) {
        // 获取SQLSession
        SqlSession sqlSession = factory.openSession();

        // 获取mapper
        AnnouncementMapper anMapper = sqlSession.getMapper(AnnouncementMapper.class);

        // 计算开始索引
        int begin = (currentPage - 1) * pageSize;
        // 计算查询条目数
        int size = pageSize;

        // 查询当前页数据
        List<Announcement> rows = anMapper.selectByPage(begin, size);

        // 查询总记录数
        int totalCount = anMapper.selectTotalCount();

        // 封装PageBean 对象
        PageBean<Announcement> pageBean = new PageBean<>();
        pageBean.setRows(rows);
        pageBean.setTotalCount(totalCount);

        // 释放资源
        sqlSession.close();

        return pageBean;
    }

    @Override
    public void add(Announcement announcement) {
        // 获取SQLSession
        SqlSession sqlSession = factory.openSession();

        // 获取mapper
        AnnouncementMapper anMapper = sqlSession.getMapper(AnnouncementMapper.class);

        // 执行方法
        anMapper.add(announcement);

        // 提交事务
        sqlSession.commit();

        // 释放资源
        sqlSession.close();
    }
}
