package com.turing.web.servlet;

import com.alibaba.fastjson.JSON;
import com.turing.pojo.PageBean;
import com.turing.pojo.Train;
import com.turing.pojo.Vacate;
import com.turing.service.VacateService;
import com.turing.service.impl.VacateServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.Date;

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

    /**
     * 设置审批状态
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    public void updateById(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String _id = req.getParameter("id");
        int id = Integer.parseInt(_id);

        String _status = req.getParameter("status");
        int status = Integer.parseInt(_status);

        // 调用service 添加员工
        vacateService.updateById(id,status);

        // 响应成功标识
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write("success");
    }

    /**
     * 添加
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    public void addByEmp(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 从JSON中获取employee数据
        BufferedReader br = req.getReader();
        String params = br.readLine();

        // 转为train 对象
        Vacate vacate = JSON.parseObject(params, Vacate.class);

        String _eid = req.getParameter("id");
        int eid = Integer.parseInt(_eid);

        // 将eid设置为具体员工的编号
        vacate.setEid(eid);


        // 对请假日期进行校验
        Date date1 = vacate.getStartDate();
        Date date2 = vacate.getEndDate();
        Date currentDate = new Date();

        // 1. 开始不得晚于现在时间
        int comparisonResult_ = compareDates(date1, currentDate);
        // 根据比较结果输出
        if (comparisonResult_ == -1) {
            // 不合理情况
            System.out.println(date1 + " 在 " + currentDate + " 之前");

            resp.setContentType("text/json;charset=utf-8");
            resp.getWriter().write("date_error1");
            return;
        } else if (comparisonResult_ == 1) {
            //合理
            System.out.println(date1 + " 在 " + currentDate + " 之后");
        } else {
            // 合理
            System.out.println(date1 + " 与 " + currentDate + " 相同");
        }



        // 2. 开始不得晚于结束
        // 调用 compareDates 函数进行比较
        int comparisonResult = compareDates(date1, date2);
        // 根据比较结果输出
        if (comparisonResult == -1) {
            // 合理情况
            System.out.println(date1 + " 在 " + date2 + " 之前");
        } else if (comparisonResult == 1) {
            //不合理
            System.out.println(date1 + " 在 " + date2 + " 之后");

            resp.setContentType("text/json;charset=utf-8");
            resp.getWriter().write("date_error");
            return;
        } else {
            // 合理
            System.out.println(date1 + " 与 " + date2 + " 相同");
        }

        // 调用service 添加员工
        vacateService.addByEmp(vacate);

        // 响应成功标识
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write("success");
    }
}
