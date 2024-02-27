package com.turing.service.impl;

import com.turing.mapper.EmployeeMapper;
import com.turing.mapper.TrainMapper;
import com.turing.pojo.Employee;
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
}
