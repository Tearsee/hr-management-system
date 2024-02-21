package com.turing.web.servlet;

import com.alibaba.fastjson.JSON;
import com.turing.pojo.Employee;
import com.turing.service.impl.EmployeeServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/employee/*")
public class EmployeeServlet extends BaseServlet{

    private static EmployeeServiceImpl employeeService =  new EmployeeServiceImpl();// 创建service 对象

    /**
     * 查询所有
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    public void selectAll(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 调用service 的查询所有方法 返回 employees 集合
        List<Employee> employees = employeeService.selectAll();

        // 转换为JSON 对象
        String jsonString = JSON.toJSONString(employees);

        // 响应JSON 对象
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write(jsonString);
    }
}
