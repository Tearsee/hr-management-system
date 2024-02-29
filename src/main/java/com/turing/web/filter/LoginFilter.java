package com.turing.web.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;

//@WebFilter("/*")
public class LoginFilter implements Filter {

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest)servletRequest;
        // 判断访问资源是否与登录相关
        String[] urls = {"/login.jsp","/imgs/","/css/","/login"};

        String url = req.getRequestURL().toString();

        for(String u : urls){
            if(url.contains(u)){
                // 找到了

                // 放行
                filterChain.doFilter(servletRequest, servletResponse);

                return;
            }
        }

        //1.
        HttpSession session = req.getSession();
        Object user = session.getAttribute("user");

        //2. 判断
        if(user != null){
            // 登录了
            // 放行
            System.out.println("登录成功");
            filterChain.doFilter(servletRequest,servletResponse);
        }else{

            // 未登录
            req.setAttribute("login_msg","您尚未登录!");
            req.getRequestDispatcher("/login.jsp").forward(servletRequest,servletResponse);
        }


    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void destroy() {

    }
}
