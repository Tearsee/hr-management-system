package com.turing.service.impl;

import com.turing.mapper.MessagesMapper;
import com.turing.mapper.VacateMapper;
import com.turing.pojo.Messages;
import com.turing.pojo.PageBean;
import com.turing.pojo.Vacate;
import com.turing.service.MessagesService;
import com.turing.service.VacateService;
import com.turing.util.SqlSessionFactoryUtils;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.util.List;

public class MessagesServiceImpl implements MessagesService {
    // 创建sqlSession 工厂
    private static SqlSessionFactory factory = SqlSessionFactoryUtils.getSqlSessionFactory();

    @Override
    public void send(Messages messages) {
        // 获取SQLSession
        SqlSession sqlSession = factory.openSession();

        // 获取mapper
        MessagesMapper messagesMapper = sqlSession.getMapper(MessagesMapper.class);


        // 执行方法
        messagesMapper.send(messages);

        // 提交事务
        sqlSession.commit();

        // 释放资源
        sqlSession.close();
    }
}
