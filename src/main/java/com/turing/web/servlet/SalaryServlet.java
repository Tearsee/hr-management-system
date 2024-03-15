package com.turing.web.servlet;

import com.alibaba.fastjson.JSON;
import com.turing.pojo.*;
import com.turing.service.impl.AdministratorServiceImpl;
import com.turing.service.impl.SalaryServiceImpl;
import com.turing.service.impl.VacateServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.Date;
import java.util.List;

@WebServlet("/salary/*")
public class SalaryServlet extends BaseServlet {

    private static SalaryServiceImpl salaryService = new SalaryServiceImpl();// 创建service 对象
    private static AdministratorServiceImpl adminService = new AdministratorServiceImpl();// 创建service 对象
    /**
     * 查询所有
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    public void selectAll(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 调用service 的查询所有方法 返回 employees 集合
        List<Salary> salaries = salaryService.selectAll();

        // 转换为JSON 对象
        String jsonString = JSON.toJSONString(salaries);

        // 响应JSON 对象
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write(jsonString);
    }

    /**
     * 添加员工
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    public void add(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        // 从JSON中获取employee数据
        BufferedReader br = req.getReader();
        String params = br.readLine();

        // 获取 对象
        SalaryQuery salaryQuery = JSON.parseObject(params, SalaryQuery.class);
/*

        Salary salary = new Salary();
        salary.setEid(salaryQuery.getEid());
        salary.setSal(salaryQuery.getSal());
        salary.setBasicSalary(salaryQuery.getBasicSalary());
        salary.setPerformance(salaryQuery.getPerformance());
*/

        List<Employee> employees = adminService.selectAll();
        boolean isExist = false;

        // 正则判断eid是否存在
        for (int i = 0; i < employees.size(); i++) {
            if(employees.get(i).getId().equals(salaryQuery.getEid())){
                // 存在
                isExist = true;
            }
        }

        //
        if(!isExist){
            // 响应JSON 对象
            resp.setContentType("text/json;charset=utf-8");
            resp.getWriter().write("error_eid");
            return;
        }


        // 正则判断底薪是否大于工资
        if(salaryQuery.getBasicSalary() > salaryQuery.getSal()){
            // 不合理
            resp.setContentType("text/json;charset=utf-8");
            resp.getWriter().write("error_sal");
            return;
        }


        // 调用service 添加员工
        salaryService.add(salaryQuery);

        // 响应成功标识
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write("success");
    }

    /**
     * 根据条件分页查询(admin)
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    public void selectByPageAndCondition(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 调用service 的查询所有方法 返回 employees 集合
//        List<Employee> employees = employeeService.selectAll();
        String _currentPage = req.getParameter("currentPage_salary");
        String _pageSize = req.getParameter("pageSize_salary");

/*
        // 更新用户查询功能
        // 可能会影响amdin的查询salary
        String _id = req.getParameter("id");
        int eid = Integer.parseInt(_id);
*/

        int currentPage = Integer.parseInt(_currentPage);
        int pageSize = Integer.parseInt(_pageSize);

        // 获取
        BufferedReader br = req.getReader();
        String params = br.readLine();

        SalaryQuery salaryQuery = JSON.parseObject(params, SalaryQuery.class);

        // 调用service 查询pageBean
        PageBean<SalaryQuery> pageBean = salaryService.selectByPageAndCondition(currentPage, pageSize,salaryQuery);

        // 转换为JSON 对象
        String jsonString = JSON.toJSONString(pageBean);

        // 响应JSON 对象
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write(jsonString);
    }

    /**
     * 根据条件分页查询(employee)
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    public void selectByPageAndCondition2(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        // 调用service 的查询所有方法 返回 employees 集合
//        List<Employee> employees = employeeService.selectAll();
        String _currentPage = req.getParameter("currentPage_salary");
        String _pageSize = req.getParameter("pageSize_salary");

        // 更新用户查询功能
        // 可能会影响amdin的查询salary
        String _employeeName = req.getParameter("employeeName");

        byte[] bytes = _employeeName.getBytes("ISO-8859-1");

        String employeeName = new String(bytes, "utf-8");

        int currentPage = Integer.parseInt(_currentPage);
        int pageSize = Integer.parseInt(_pageSize);

        // 获取
        BufferedReader br = req.getReader();
        String params = br.readLine();

        SalaryQuery salaryQuery = JSON.parseObject(params, SalaryQuery.class);
        salaryQuery.setEmployeeName(employeeName);

        // 调用service 查询pageBean
        PageBean<SalaryQuery> pageBean = salaryService.selectByPageAndCondition(currentPage, pageSize,salaryQuery);

        // 转换为JSON 对象
        String jsonString = JSON.toJSONString(pageBean);

        // 响应JSON 对象
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write(jsonString);
    }

}
