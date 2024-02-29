package com.turing.service;

import com.turing.pojo.PageBean;
import com.turing.pojo.User;
import com.turing.pojo.Vacate;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface UserService {
    /**
     * 根据用户名和密码查询对象
     * @param username
     * @param password
     * @return
     */
    User select(String username,String password);


    /**
     * 根据用户名查询用户对象
     * @param username
     * @return
     */
    User selectByUsername(String username);

    /**
     * 添加员工账号
     * @param user
     */
    void add(User user);
}
