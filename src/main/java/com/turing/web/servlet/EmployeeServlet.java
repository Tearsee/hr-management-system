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
    private static AdministratorServiceImpl administratorService = new AdministratorServiceImpl();// 创建service 对象


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
        req.setCharacterEncoding("utf-8");
        // 从JSON中获取employee数据
        BufferedReader br = req.getReader();
        String params = br.readLine();

        // 转为employee 对象
        Employee employee = JSON.parseObject(params, Employee.class);


        // 判断用户名是否重复 && 工号是否重复
/*

        List<Employee> employees = administratorService.selectAll();

        for(int i = 0;i < employees.size();i ++ ){

            // 工号重复

            if(employees.get(i).getStaffId().equals(employee.getStaffId())){

                resp.setContentType("text/json;charset=utf-8");
                resp.getWriter().write("repeat_sdfId");
                return;

            }

        }
*/


        // 正则判断输入
        // 员工名称
        // 中文2-16位 (中间可以含`)
        String regex_name = "^(?:[\\u4e00-\\u9fa5·]{2,16})$";
        if(!employee.getEmployeeName().matches(regex_name)){
            System.out.println("匹配失败");

            // 匹配失败逻辑
            resp.setContentType("text/json;charset=utf-8");
            resp.getWriter().write("format_empname");
            return;
        }

        // 年龄
        String regex_age = "^\\d{1,3}$";
        // 0-999岁
        String empage = employee.getAge().toString();
        if(!empage.matches(regex_age)){
            System.out.println("匹配失败");

            // 匹配失败逻辑
            resp.setContentType("text/json;charset=utf-8");
            resp.getWriter().write("format_empage");
            return;
        }

        // 邮箱
        String regex_email = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
        // 实例
//        '90203918@qq.com', 'nbilly@126.com'
        if(!employee.getEmail().matches(regex_email)){
            System.out.println("匹配失败");

            // 匹配失败逻辑
            resp.setContentType("text/json;charset=utf-8");
            resp.getWriter().write("format_email");
            return;
        }

        // 手机号
        String regex_tel = "^1[3-9]\\d{9}$";
        // 实例
        if(!employee.getPhone().matches(regex_tel)){
            System.out.println("匹配失败");

            // 匹配失败逻辑
            resp.setContentType("text/json;charset=utf-8");
            resp.getWriter().write("format_tel");
            return;
        }

        // 部门编号(1-9)
        String regex_dept = "^[1-9]$";
        String deptId = employee.getDeptId().toString();
        // 实例
        if(!deptId.matches(regex_dept)){
            System.out.println("匹配失败");

            // 匹配失败逻辑
            resp.setContentType("text/json;charset=utf-8");
            resp.getWriter().write("format_dept");
            return;
        }



        // 调用service 添加员工
        employeeService.updateById(employee);

        // 响应成功标识
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write("success");
    }
}
