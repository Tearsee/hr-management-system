package com.turing.web.servlet;

import com.alibaba.fastjson.JSON;
import com.turing.pojo.Employee;
import com.turing.pojo.PageBean;
import com.turing.service.impl.AdministratorServiceImpl;
import com.turing.service.impl.EmployeeServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;

@WebServlet("/employee/*")
public class EmployeeServlet extends BaseServlet {

    private static EmployeeServiceImpl employeeService = new EmployeeServiceImpl();// 创建service 对象


    /**
     * 查询员工个人信息
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    public void selectOneById(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 从req中获取参数id
        String staffId = req.getParameter("staffId");
//        int staffId = Integer.parseInt(_staffId);

        // 调用service 的查询所有方法 返回 employees 集合
        Employee employee = employeeService.selectOneById(staffId);

        // 转换为JSON 对象
        String jsonString = JSON.toJSONString(employee);

        // 响应JSON 对象
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write(jsonString);
    }

    /**
     * 修改员工信息
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    public void updateById(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 从JSON中获取employee数据
        BufferedReader br = req.getReader();
        String params = br.readLine();

        // 转为employee 对象
        Employee employee = JSON.parseObject(params, Employee.class);

        // 调用service 添加员工
        employeeService.updateById(employee);

        // 响应成功标识
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write("success");
    }
}
