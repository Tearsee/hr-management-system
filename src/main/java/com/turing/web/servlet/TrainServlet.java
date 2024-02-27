package com.turing.web.servlet;

import com.alibaba.fastjson.JSON;
import com.turing.pojo.Employee;
import com.turing.pojo.PageBean;
import com.turing.pojo.Train;
import com.turing.service.impl.EmployeeServiceImpl;
import com.turing.service.impl.TrainServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;

@WebServlet("/train/*")
public class TrainServlet extends BaseServlet {

    private static TrainServiceImpl trainService = new TrainServiceImpl();// 创建service 对象

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
        List<Train> trains = trainService.selectAll();

        // 转换为JSON 对象
        String jsonString = JSON.toJSONString(trains);

        // 响应JSON 对象
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write(jsonString);
    }

    /**
     * 添加培训计划
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    public void add(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 从JSON中获取employee数据
        BufferedReader br = req.getReader();
        String params = br.readLine();

        // 转为train 对象
        Train train = JSON.parseObject(params, Train.class);

        // 调用service 添加员工
        trainService.add(train);

        // 响应成功标识
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write("success");
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
        trainService.deleteByIds(ids);

        // 3. 响应成功标识
        resp.getWriter().write("success");
    }

    /**
     * 修改培训信息
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
        Train train = JSON.parseObject(params, Train.class);

        // 调用service 添加员工
        trainService.updateById(train);

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
        String _currentPage = req.getParameter("currentPage_train");
        String _pageSize = req.getParameter("pageSize_train");

        int currentPage = Integer.parseInt(_currentPage);
        int pageSize = Integer.parseInt(_pageSize);

        // 调用service 查询pageBean
        PageBean<Train> pageBean = trainService.selectByPage(currentPage, pageSize);

        // 转换为JSON 对象
        String jsonString = JSON.toJSONString(pageBean);

        // 响应JSON 对象
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write(jsonString);
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
        String _currentPage = req.getParameter("currentPage_train");
        String _pageSize = req.getParameter("pageSize_train");

        int currentPage = Integer.parseInt(_currentPage);
        int pageSize = Integer.parseInt(_pageSize);

        // 获取 train
        BufferedReader br = req.getReader();
        String params = br.readLine();

        Train train = JSON.parseObject(params, Train.class);

        // 调用service 查询pageBean
        PageBean<Train> pageBean = trainService.selectByPageAndCondition(currentPage, pageSize,train);

        // 转换为JSON 对象
        String jsonString = JSON.toJSONString(pageBean);

        // 响应JSON 对象
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write(jsonString);
    }
}
