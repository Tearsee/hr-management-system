package com.turing.web.servlet;

import com.alibaba.fastjson.JSON;
import com.turing.pojo.RewardPunish;
import com.turing.pojo.PageBean;
import com.turing.pojo.RewardPunish;
import com.turing.pojo.RewardPunish;
import com.turing.service.impl.RewardPunishServiceImpl;
import com.turing.service.impl.RewardPunishServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;

@WebServlet("/rewardPunish/*")
public class RewardPunishServlet extends BaseServlet{

    private static RewardPunishServiceImpl rewardPunishService = new RewardPunishServiceImpl();// 创建service 对象
    /**
     * 分页条件查询
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    public void selectByPageAndCondition(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 调用service 的查询所有方法 返回 rewardPunishs 集合
//        List<RewardPunish> rewardPunishs = rewardPunishService.selectAll();
        String _currentPage = req.getParameter("currentPage_rewardPunish");
        String _pageSize = req.getParameter("pageSize_rewardPunish");

        int currentPage = Integer.parseInt(_currentPage);
        int pageSize = Integer.parseInt(_pageSize);

//        System.out.println(currentPage);
//        System.out.println(pageSize);
        // 获取
        BufferedReader br = req.getReader();
        String params = br.readLine();

        RewardPunish rewardPunish = JSON.parseObject(params, RewardPunish.class);

        // 调用service 查询pageBean
        PageBean<RewardPunish> pageBean = rewardPunishService.selectByPageAndCondition(currentPage, pageSize,rewardPunish);

        // 转换为JSON 对象
        String jsonString = JSON.toJSONString(pageBean);

        // 响应JSON 对象
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write(jsonString);
    }


    /**
     * 添加
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    public void add(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 从JSON中获取rewardPunish数据
        BufferedReader br = req.getReader();
        String params = br.readLine();

        // 转为rewardPunish 对象
        RewardPunish rewardPunish = JSON.parseObject(params, RewardPunish.class);

        // 调用service 添加员工
        rewardPunishService.add(rewardPunish);

        // 响应成功标识
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write("success");
    }

}
