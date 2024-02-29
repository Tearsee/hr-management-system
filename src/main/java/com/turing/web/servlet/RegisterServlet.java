package com.turing.web.servlet;

import com.alibaba.fastjson.JSON;
import com.turing.pojo.Employee;
import com.turing.pojo.User;
import com.turing.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;

@WebServlet("/register/*")
public class RegisterServlet extends BaseServlet {

    private static UserServiceImpl userService = new UserServiceImpl();// 创建service 对象

    /**
     * 登录
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    public void add(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 从JSON中获取employee数据
        BufferedReader br = req.getReader();
        String params = br.readLine();

        // 转为employee 对象
        User user = JSON.parseObject(params, User.class);

        // 调用service 添加员工
        userService.add(user);

        // 响应成功标识
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write("success");
    }


}
