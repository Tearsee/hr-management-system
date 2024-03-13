package com.turing.web.servlet;

import com.alibaba.fastjson.JSON;
import com.turing.pojo.Employee;
import com.turing.pojo.User;
import com.turing.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;

@WebServlet("/register/*")
public class RegisterServlet extends BaseServlet {

    private static UserServiceImpl userService = new UserServiceImpl();// 创建service 对象

    /**
     * 注册
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
        User user = JSON.parseObject(params, User.class);


        /*
        * 正则判断用户名和密码格式
        * */
        // 输入用户名
        // 只能为2-9位的英文名字
        String regex1 = "^[a-zA-Z]{2,10}$";

        if (user.getUsername().matches(regex1)) {
            System.out.println("匹配成功");
        } else {
            System.out.println("匹配失败");

            // 匹配失败逻辑
            resp.setContentType("text/json;charset=utf-8");
            resp.getWriter().write("format_username");
            return;

        }

        // 正则表达式判断输入 密码
//        6-10位允许数字字母下划线，其中至少包含数字和字母
        String regex = "^(?=.*[a-zA-Z])(?=.*\\d)[a-zA-Z\\d_]{6,10}$";

        if (user.getPassword().matches(regex)) {
            System.out.println("匹配成功");
        } else {
            System.out.println("匹配失败");


            // 匹配失败逻辑
            resp.setContentType("text/json;charset=utf-8");
            resp.getWriter().write("format_password");
            return;

        }


        // 判断用户名是否重复 && 工号是否重复

        List<User> users = userService.selectAll();

        for(int i = 0;i < users.size();i ++ ){


            // 用户和工号都重复
            if(users.get(i).getUsername().equals(user.getUsername()) && users.get(i).getStaffId().equals(user.getStaffId())){

                resp.setContentType("text/json;charset=utf-8");
                resp.getWriter().write("fail3");
                return;
            }
            // 用户名重复
            if(users.get(i).getUsername().equals(user.getUsername())){
                resp.setContentType("text/json;charset=utf-8");
                resp.getWriter().write("fail1");
                return;
            }

            // 工号重复

            if(users.get(i).getStaffId().equals(user.getStaffId())){

                resp.setContentType("text/json;charset=utf-8");
                resp.getWriter().write("fail2");
                return;

            }

        }

        // 无重复情况
        // 调用service 添加员工
        userService.add(user);

        // 响应成功标识
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write("success");
    }


}
