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

        req.setCharacterEncoding("utf-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        System.out.println(username);

        // 输入用户名
        // 只能为2-9位的英文名字
        String regex1 = "^[a-zA-Z]{2,10}$";

        if (username.matches(regex1)) {
            System.out.println("匹配成功");
        } else {
            System.out.println("匹配失败");

            // 匹配失败逻辑
            req.setAttribute("login_msg", "用户名或密码格式有误");

            //
            req.getRequestDispatcher("/login.jsp").forward(req, resp);


        }

        // 正则表达式判断输入 密码
//        6-10位允许数字字母下划线，其中至少包含数字和字母
        String regex = "^(?=.*[a-zA-Z])(?=.*\\d)[a-zA-Z\\d_]{6,10}$";

        if (password.matches(regex)) {
            System.out.println("匹配成功");
        } else {
            System.out.println("匹配失败");


            // 匹配失败逻辑
            req.setAttribute("login_msg", "用户名或密码格式有误");

            //
            req.getRequestDispatcher("/login.jsp").forward(req, resp);


        }


        User user = userService.select(username, password);

        HttpSession session = req.getSession();

        // 判断
        if (user != null) {

            // 登录成功逻辑
//            if (user.getUsername().equals("admin") && user.getPassword().equals("123456")) {
            if ("admin".equals(user.getUsername()) && "admin123".equals(user.getPassword())) {

                // 登录成功逻辑
//                    HttpSession session = req.getSession();
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getStaffId());

                String contextPath = req.getContextPath();
                resp.sendRedirect(contextPath + "/admin.jsp");

            }

            // 用户登录
            session.setAttribute("user", user);
            String contextPath = req.getContextPath();
            resp.sendRedirect(contextPath + "/employee.jsp");

        } else {
            // 登录失败逻辑

            req.setAttribute("login_msg", "用户名或密码错误");

            //
            req.getRequestDispatcher("/login.jsp").forward(req, resp);

        }

        String jsonString = JSON.toJSONString(user);
        // 响应JSON 对象
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write(jsonString);
    }


}
