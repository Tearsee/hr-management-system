package com.turing.web.servlet;

import com.alibaba.fastjson.JSON;
import com.turing.pojo.Announcement;
import com.turing.pojo.PageBean;
import com.turing.pojo.Train;
import com.turing.service.impl.AnnouncementServiceImpl;
import com.turing.service.impl.TrainServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;

@WebServlet("/announcement/*")
public class AnnouncementServlet extends BaseServlet {

    private static AnnouncementServiceImpl anServiceImpl = new AnnouncementServiceImpl();// 创建service 对象
    /**
     * 分页查询
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    public void selectByPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 调用service 的查询所有方法 返回 employees 集合
        String _currentPage = req.getParameter("currentPage_announcement");
        String _pageSize = req.getParameter("pageSize_announcement");

        int currentPage = Integer.parseInt(_currentPage);
        int pageSize = Integer.parseInt(_pageSize);

        // 调用service 查询pageBean
        PageBean<Announcement> pageBean = anServiceImpl.selectByPage(currentPage, pageSize);

        // 转换为JSON 对象
        String jsonString = JSON.toJSONString(pageBean);

        // 响应JSON 对象
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write(jsonString);
    }
}
