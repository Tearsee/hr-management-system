package com.turing.web.servlet;

import com.alibaba.fastjson.JSON;
import com.turing.pojo.User;
import com.turing.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login/*")
public class LoginServlet extends BaseServlet {

    private static UserServiceImpl userService = new UserServiceImpl();// 创建service 对象

    /**
     * 登录
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    public void select(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        User user = userService.select(username, password);


        // 判断
        if (user != null) {
            // 用户存在逻辑   // 登录成功逻辑
            if (user.getUsername().equals("admin") && user.getPassword().equals("123456")) {

                // 登录成功逻辑
                HttpSession session = req.getSession();
                session.setAttribute("user", user);

                String contextPath = req.getContextPath();
                resp.sendRedirect(contextPath + "/admin.jsp");
            }

            // 登录
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            String contextPath = req.getContextPath();
            resp.sendRedirect(contextPath + "/employee.jsp");

        } else {
            // 登录失败逻辑

            req.setAttribute("login_msg","用户名或密码错误");

            //
            req.getRequestDispatcher("/login.jsp").forward(req,resp);

        }

        String jsonString = JSON.toJSONString(user);
        // 响应JSON 对象
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write(jsonString);
    }

    /**
     * 根据用户名查询用户对象
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
   /* public void selectByUsername(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String username = req.getParameter("username");

        boolean flag = true;

        // 判断
        if(username){

        }else{

        }



        resp.getWriter().write("" + flag);

    }*/


}
