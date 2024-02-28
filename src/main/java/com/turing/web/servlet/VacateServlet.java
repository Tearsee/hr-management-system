package com.turing.web.servlet;

import com.alibaba.fastjson.JSON;
import com.turing.pojo.PageBean;
import com.turing.pojo.Vacate;
import com.turing.service.impl.VacateServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;

@WebServlet("/vacate/*")
public class VacateServlet extends BaseServlet {

    private static VacateServiceImpl vacateService = new VacateServiceImpl();// 创建service 对象
    /**
     * 分页条件查询
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    public void selectByPageAndCondition(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 调用service 的查询所有方法 返回 employees 集合
//        List<Vacate> employees = employeeService.selectAll();
        String _currentPage = req.getParameter("currentPage_vacate");
        String _pageSize = req.getParameter("pageSize_vacate");

        int currentPage = Integer.parseInt(_currentPage);
        int pageSize = Integer.parseInt(_pageSize);

//        System.out.println(currentPage);
//        System.out.println(pageSize);

        // 获取
        BufferedReader br = req.getReader();
        String params = br.readLine();

        Vacate vacate = JSON.parseObject(params, Vacate.class);

        // 调用service 查询pageBean
        PageBean<Vacate> pageBean = vacateService.selectByPageAndCondition(currentPage, pageSize,vacate);

        // 转换为JSON 对象
        String jsonString = JSON.toJSONString(pageBean);

        // 响应JSON 对象
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write(jsonString);
    }
}
