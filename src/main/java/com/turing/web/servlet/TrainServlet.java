package com.turing.web.servlet;

import com.alibaba.fastjson.JSON;
import com.turing.pojo.Employee;
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

}