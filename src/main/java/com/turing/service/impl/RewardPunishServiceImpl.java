package com.turing.service.impl;

import com.turing.mapper.RewardPunishMapper;
import com.turing.pojo.PageBean;
import com.turing.pojo.RewardPunish;
import com.turing.service.RewardPunishService;
import com.turing.util.SqlSessionFactoryUtils;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.util.List;

public class RewardPunishServiceImpl implements RewardPunishService {
    
    // 创建sqlSession 工厂
    private static SqlSessionFactory factory = SqlSessionFactoryUtils.getSqlSessionFactory();

    /**
     * 分页条件查询
     * @param currentPage
     * @param pageSize
     * @param rewardPunish
     * @return
     */
    @Override
    public PageBean<RewardPunish> selectByPageAndCondition(int currentPage, int pageSize, RewardPunish rewardPunish) {
        // 获取SQLSession
        SqlSession sqlSession = factory.openSession();

        // 获取mapper
        RewardPunishMapper rewardPunishMapper = sqlSession.getMapper(RewardPunishMapper.class);

        // 计算开始索引
        int begin = (currentPage - 1) * pageSize;
        // 计算查询条目数
        int size = pageSize;

        // 查询当前页数据
        List<RewardPunish> rows = rewardPunishMapper.selectByPageAndCondition(begin, size,rewardPunish);

        // 查询总记录数
        int totalCount = rewardPunishMapper.selectTotalCountByCondition(rewardPunish);

        // 封装PageBean 对象
        PageBean<RewardPunish> pageBean = new PageBean<>();
        pageBean.setRows(rows);
        pageBean.setTotalCount(totalCount);

        // 释放资源
        sqlSession.close();

        return pageBean;
    }

    /**
     * 添加
     * @param rewardPunish
     */
    @Override
    public void add(RewardPunish rewardPunish) {
        // 获取SQLSession
        SqlSession sqlSession = factory.openSession();

        // 获取mapper
        RewardPunishMapper rewardPunishMapper = sqlSession.getMapper(RewardPunishMapper.class);

        // 执行方法
        rewardPunishMapper.add(rewardPunish);

        // 提交事务
        sqlSession.commit();

        // 释放资源
        sqlSession.close();
    }

}
