package com.turing.mapper;

import com.turing.pojo.Employee;
import com.turing.pojo.User;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

public interface UserMapper {

    /**
     * 根据用户名和密码查询对象
     * @param username
     * @param password
     * @return
     */
    @Select("select * from user where username=#{username} and password=#{password}")
    User select(@Param("username") String username,@Param("password") String password);

    /**
     * 根据用户名查询用户对象
     * @param username
     * @return
     */
    @Select("select * from user where username = #{username}")
    User selectByUsername(String username);


    /**
     * 添加员工账号
     * @param user
     */
    @Insert("insert into user values (null,#{username},#{password},1)")
    void add(User user);

}
