package com.turing.web.servlet;

import com.alibaba.fastjson.JSON;
import com.turing.pojo.Messages;
import com.turing.pojo.PageBean;
import com.turing.pojo.Vacate;
import com.turing.service.impl.MessagesServiceImpl;
import com.turing.service.impl.VacateServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;

@WebServlet("/messages/*")
public class MessagesServlet extends BaseServlet {

    private static MessagesServiceImpl messagesService = new MessagesServiceImpl();// 创建service 对象
    /**
     * 添加
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    public void send(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 从JSON中获取employee数据
        BufferedReader br = req.getReader();
        String params = br.readLine();

        // 转为train 对象
        Messages messages = JSON.parseObject(params, Messages.class);

        // 调用service 添加员工
        messagesService.send(messages);

        // 响应成功标识
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write("success");
    }
}
