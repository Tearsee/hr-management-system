package com.turing.web.servlet;

import com.alibaba.fastjson.JSON;
import com.turing.pojo.User;
import com.turing.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 获取 session
        HttpSession session = req.getSession();
        // 销毁 session
        session.invalidate();

        // 设置响应信息至login界面
        req.setAttribute("msg","退出成功");

        // 跳转至login界面
        req.getRequestDispatcher("/login.jsp").forward(req,resp);

    }
}
