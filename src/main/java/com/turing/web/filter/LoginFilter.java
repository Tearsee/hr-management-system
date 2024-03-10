package com.turing.web.filter;

import com.turing.pojo.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class LoginFilter implements Filter {

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) servletRequest;
        HttpServletResponse resp = (HttpServletResponse) servletResponse;
        // 判断访问资源是否与登录相关
        String[] urls = {"/login.jsp", "/imgs/", "/css/", "/login"};

        String url = req.getRequestURL().toString();

        for (String u : urls) {
            if (url.contains(u)) {
                // 找到了

                // 放行
                filterChain.doFilter(servletRequest, servletResponse);

                return;
            }
        }

        //1.
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

//
//        // 在用户每次请求页面时检查session中是否已存在用户ID
//        if (session.getAttribute("userId") != null) {
//            // 用户已登录
//            // 检查是否是同一浏览器窗口登录
//            if (!session.getAttribute("userId").equals(userId)) {
//                // 不允许在多个浏览器窗口登录
//                response.sendRedirect("login.jsp?error=already_logged_in");
//            }
//        }
        //2. 判断
//        用户无法同时登录多个账号
        if (user != null) {
            // 用户已登录

//            if (!session.getAttribute("user.staffId").equals(user.getStaffId())) {// 不允许在多个浏览器窗口登录
//
//                req.setAttribute("error_msg", "无法同时登录多个账号!");
//                req.getRequestDispatcher("/login.jsp").forward(servletRequest, servletResponse);
//
//            }
//
//            // 不允许在多个浏览器窗口登录
//
//            if(){
//
//            }

            // 放行
            System.out.println("登录成功");
            filterChain.doFilter(servletRequest, servletResponse);
        } else {

            // 未登录
            req.setAttribute("login_msg", "您尚未登录!");
            req.getRequestDispatcher("/login.jsp").forward(servletRequest, servletResponse);
        }


    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void destroy() {

    }
}
