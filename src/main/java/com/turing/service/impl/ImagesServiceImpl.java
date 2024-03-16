package com.turing.service.impl;

import com.turing.mapper.ImagesMapper;
import com.turing.mapper.MessagesMapper;
import com.turing.mapper.UserMapper;
import com.turing.pojo.User;
import com.turing.service.ImagesService;
import com.turing.service.UserService;
import com.turing.util.SqlSessionFactoryUtils;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.util.List;

public class ImagesServiceImpl implements ImagesService {
    
    // 创建sqlSession 工厂
    private static SqlSessionFactory factory = SqlSessionFactoryUtils.getSqlSessionFactory();

    /**
     * 上传头像
     * @param path
     * @param name
     * @param eid
     */
    @Override
    public void upload(String path, String name, int eid) {
        // 获取SQLSession
        SqlSession sqlSession = factory.openSession();

        // 获取mapper
        ImagesMapper imagesMapper = sqlSession.getMapper(ImagesMapper.class);

        // 执行方法
        imagesMapper.upload(path, name,eid);

        // 提交事务
        sqlSession.commit();

        // 释放资源
        sqlSession.close();
    }
}
