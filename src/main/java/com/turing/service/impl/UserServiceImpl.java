package com.turing.service.impl;

import com.turing.mapper.RewardPunishMapper;
import com.turing.mapper.UserMapper;
import com.turing.mapper.VacateMapper;
import com.turing.pojo.PageBean;
import com.turing.pojo.RewardPunish;
import com.turing.pojo.User;
import com.turing.service.RewardPunishService;
import com.turing.service.UserService;
import com.turing.util.SqlSessionFactoryUtils;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.util.List;

public class UserServiceImpl implements UserService {
    
    // 创建sqlSession 工厂
    private static SqlSessionFactory factory = SqlSessionFactoryUtils.getSqlSessionFactory();


    /**
     * 根据用户名和密码查询对象
     * @param username
     * @param password
     * @return
     */
    @Override
    public User select(String username, String password) {
        // 获取SQLSession
        SqlSession sqlSession = factory.openSession();

        // 获取mapper
        UserMapper userMapper = sqlSession.getMapper(UserMapper.class);

        User user = userMapper.select(username, password);

        sqlSession.close();

        return user;

    }

    /**
     * 根据用户名查询用户对象
     * @param username
     * @return
     */
    @Override
    public User selectByUsername(String username) {
        // 获取SQLSession
        SqlSession sqlSession = factory.openSession();

        // 获取mapper
        UserMapper userMapper = sqlSession.getMapper(UserMapper.class);

        User user = userMapper.selectByUsername(username);

        sqlSession.close();

        return user;
    }

    /**
     * 添加员工账号
     * @param user
     */
    @Override
    public void add(User user) {
        // 获取SQLSession
        SqlSession sqlSession = factory.openSession();

        // 获取mapper
        UserMapper userMapper = sqlSession.getMapper(UserMapper.class);

        userMapper.add(user);

        sqlSession.commit();

        sqlSession.close();

    }

    @Override
    public List<User> selectAll() {
        // 获取SQLSession
        SqlSession sqlSession = factory.openSession();

        // 获取mapper
        UserMapper userMapper = sqlSession.getMapper(UserMapper.class);

        List<User> users = userMapper.selectAll();

        sqlSession.close();

        return users;
    }
}
