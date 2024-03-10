package com.turing.web.filter;

import com.turing.pojo.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/admin.jsp")
public class LoginFilter2 implements Filter {

    /**
     * 防止已经登录的用户 ，在地址栏直接访问admin.jsp
     * @param servletRequest
     * @param servletResponse
     * @param filterChain
     * @throws IOException
     * @throws ServletException
     */
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) servletRequest;

        //1.
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        String admin = "admin";
        if(!admin.equals(user.getUsername())){
            // 已经登录的用户 ，在地址栏直接访问admin.jsp
            // 未登录

            req.setAttribute("error_msg2", "您不是管理员，登录失败!");
            req.getRequestDispatcher("/login.jsp").forward(servletRequest, servletResponse);

        }else{
            // 的确是管理员
            // 放行
            System.out.println("登录成功");
            filterChain.doFilter(servletRequest, servletResponse);
        }

    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void destroy() {

    }
}
