package com.turing.service.impl;

import com.turing.mapper.EmployeeMapper;
import com.turing.mapper.TrainMapper;
import com.turing.pojo.Employee;
import com.turing.pojo.PageBean;
import com.turing.pojo.Train;
import com.turing.service.EmployeeService;
import com.turing.service.TrainService;
import com.turing.util.SqlSessionFactoryUtils;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.util.List;

public class TrainServiceImpl implements TrainService {
    // 创建sqlSession 工厂
    private static SqlSessionFactory factory = SqlSessionFactoryUtils.getSqlSessionFactory();

    /**
     * 查询所有
     *
     * @return
     */
    @Override
    public List<Train> selectAll() {

        // 获取SQLSession
        SqlSession sqlSession = factory.openSession();

        // 获取mapper
        TrainMapper trainMapper = sqlSession.getMapper(TrainMapper.class);

        // 执行方法
        List<Train> trains = trainMapper.selectAll();

        // 释放资源
        sqlSession.close();

        // 返回查询结果
        return trains;

    }

    /**
     * 添加培训计划
     * @param train
     */
    @Override
    public void add(Train train) {
        // 获取SQLSession
        SqlSession sqlSession = factory.openSession();

        // 获取mapper
        TrainMapper trainMapper = sqlSession.getMapper(TrainMapper.class);

        // 执行方法
        trainMapper.add(train);

        // 提交事务
        sqlSession.commit();

        // 释放资源
        sqlSession.close();
    }

    /**
     * 批量删除
     * @param ids
     */
    @Override
    public void deleteByIds(int[] ids) {
        // 获取SQLSession
        SqlSession sqlSession = factory.openSession();

        // 获取mapper
        TrainMapper trainMapper = sqlSession.getMapper(TrainMapper.class);

        // 执行方法
        trainMapper.deleteByIds(ids);

        // 提交事务
        sqlSession.commit();

        // 释放资源
        sqlSession.close();
    }

    /**
     * 修改培训信息
     * @param train
     */
    @Override
    public void updateById(Train train) {
        // 获取SQLSession
        SqlSession sqlSession = factory.openSession();

        // 获取mapper
        TrainMapper trainMapper = sqlSession.getMapper(TrainMapper.class);


        // 执行方法
        trainMapper.updateById(train);

        // 提交事务
        sqlSession.commit();

        // 释放资源
        sqlSession.close();
    }

    /**
     * 分页查询
     * @param currentPage 当前页码
     * @param pageSize 每页展示条数
     * @return
     */
    @Override
    public PageBean<Train> selectByPage(int currentPage, int pageSize) {
        // 获取SQLSession
        SqlSession sqlSession = factory.openSession();

        // 获取mapper
        TrainMapper trainMapper = sqlSession.getMapper(TrainMapper.class);

        // 计算开始索引
        int begin = (currentPage - 1) * pageSize;
        // 计算查询条目数
        int size = pageSize;

        // 查询当前页数据
        List<Train> rows = trainMapper.selectByPage(begin, size);

        // 查询总记录数
        int totalCount = trainMapper.selectTotalCount();

        // 封装PageBean 对象
        PageBean<Train> pageBean = new PageBean<>();
        pageBean.setRows(rows);
        pageBean.setTotalCount(totalCount);

        // 释放资源
        sqlSession.close();

        return pageBean;
    }

    /**
     * 分页条件查询
     * @param currentPage
     * @param pageSize
     * @param train
     * @return
     */
    @Override
    public PageBean<Train> selectByPageAndCondition(int currentPage, int pageSize, Train train) {
        // 获取SQLSession
        SqlSession sqlSession = factory.openSession();

        // 获取mapper
        TrainMapper trainMapper = sqlSession.getMapper(TrainMapper.class);

        // 计算开始索引
        int begin = (currentPage - 1) * pageSize;
        // 计算查询条目数
        int size = pageSize;

        // 查询当前页数据
        List<Train> rows = trainMapper.selectByPageAndCondition(begin, size,train);

        // 查询总记录数
        int totalCount = trainMapper.selectTotalCountByCondition(train);

        // 封装PageBean 对象
        PageBean<Train> pageBean = new PageBean<>();
        pageBean.setRows(rows);
        pageBean.setTotalCount(totalCount);

        // 释放资源
        sqlSession.close();

        return pageBean;
        
    }

    /**
     * 个人分页查询
     * @param currentPage
     * @param pageSize
     * @param eid
     * @return
     */
    @Override
    public PageBean<Train> selectMarkByPageAndId(int currentPage, int pageSize, int eid) {
        // 获取SQLSession
        SqlSession sqlSession = factory.openSession();

        // 获取mapper
        TrainMapper trainMapper = sqlSession.getMapper(TrainMapper.class);

        // 计算开始索引
        int begin = (currentPage - 1) * pageSize;
        // 计算查询条目数
        int size = pageSize;

        // 查询当前页数据
//        List<Train> rows = trainMapper.selectByPage(begin, size);
        List<Train> rows = trainMapper.selectMarkByPageAndId(begin, size, eid);

        // 查询总记录数
        int totalCount = trainMapper.selectMarkTotalCount(eid);

        // 封装PageBean 对象
        PageBean<Train> pageBean = new PageBean<>();
        pageBean.setRows(rows);
        pageBean.setTotalCount(totalCount);

        // 释放资源
        sqlSession.close();

        return pageBean;
    }


}
