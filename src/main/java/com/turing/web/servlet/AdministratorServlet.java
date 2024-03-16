package com.turing.web.servlet;

import com.alibaba.fastjson.JSON;
import com.turing.pojo.Employee;
import com.turing.pojo.Messages;
import com.turing.pojo.PageBean;
import com.turing.pojo.User;
import com.turing.service.impl.AdministratorServiceImpl;
import com.turing.service.impl.EmployeeServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/*")
public class AdministratorServlet extends BaseServlet {
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
        List<Employee> employees = adminService.selectAll();

        // 转换为JSON 对象
        String jsonString = JSON.toJSONString(employees);

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

        // 转为employee 对象
        Employee employee = JSON.parseObject(params, Employee.class);

        // 工号是否重复

        List<Employee> employees = adminService.selectAll();

        for(int i = 0;i < employees.size();i ++ ){

            // 工号重复

            if(employees.get(i).getStaffId().equals(employee.getStaffId())){

                resp.setContentType("text/json;charset=utf-8");
                resp.getWriter().write("repeat_sdfId");
                return;

            }

        }


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
        adminService.add(employee);

        // 响应成功标识
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write("success");
    }

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
        String _currentPage = req.getParameter("currentPage");
        String _pageSize = req.getParameter("pageSize");

        int currentPage = Integer.parseInt(_currentPage);
        int pageSize = Integer.parseInt(_pageSize);

        // 调用service 查询pageBean
        PageBean<Employee> pageBean = adminService.selectByPage(currentPage, pageSize);

        // 转换为JSON 对象
        String jsonString = JSON.toJSONString(pageBean);

        // 响应JSON 对象
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write(jsonString);
    }

    /**
     * 批量删除
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    public void deleteByIds(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. 接收ids数组
        BufferedReader br = req.getReader();
        String params = br.readLine();//[1,6,9]

        // 获取到了ids数组
        int[] ids = JSON.parseObject(params, int[].class);

        // 2. 调用service 批量删除
        adminService.deleteByIds(ids);

        // 3. 响应成功标识
        resp.getWriter().write("success");
    }

    /**
     * 根据条件分页查询
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    public void selectByPageAndCondition(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 调用service 的查询所有方法 返回 employees 集合
//        List<Employee> employees = employeeService.selectAll();
        String _currentPage = req.getParameter("currentPage");
        String _pageSize = req.getParameter("pageSize");
//        String _id = req.getParameter("id");

        int currentPage = Integer.parseInt(_currentPage);
        int pageSize = Integer.parseInt(_pageSize);
//        int id = Integer.parseInt(_id);

        // 获取employee
        BufferedReader br = req.getReader();
        String params = br.readLine();

        Employee employee = JSON.parseObject(params, Employee.class);
//        employee.setId(id);

        // 调用service 查询pageBean
        PageBean<Employee> pageBean = adminService.selectByPageAndCondition(currentPage, pageSize,employee);

        // 转换为JSON 对象
        String jsonString = JSON.toJSONString(pageBean);

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


        // 判断用户名是否重复 && 工号是否重复

        List<Employee> employees = adminService.selectAll();

        for(int i = 0;i < employees.size();i ++ ){

            // 工号重复

            if(employees.get(i).getStaffId().equals(employee.getStaffId())){

                resp.setContentType("text/json;charset=utf-8");
                resp.getWriter().write("repeat_sdfId");
                return;

            }

        }


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
        adminService.updateById(employee);

        // 响应成功标识
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write("success");
    }

    /**
     * 软删除
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    public void softDeleteById(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String _id = req.getParameter("id");
        int id = Integer.parseInt(_id);

        // 调用service 添加员工
        adminService.softDeleteById(id);

        // 响应成功标识
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write("success");
    }


    /**
     * 收件箱
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    public void receive(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 调用service 的查询所有方法 返回 employees 集合
        List<Messages> receive = adminService.receive();

        // 转换为JSON 对象
        String jsonString = JSON.toJSONString(receive);

        // 响应JSON 对象
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write(jsonString);
    }
}
