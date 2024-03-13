package com.turing.web.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Date;

public class BaseServlet extends HttpServlet {

    /**
     * 根据请求的最后一段路径进行方法分发
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //1. 获取请求路径
        String uri = req.getRequestURI();
        System.out.println(uri); // /hr-management-system/selectAll

        //2. 获取请求的最后一段
        String[] split = uri.split("/");

        String methodName = split[split.length - 1];
        System.out.println(methodName);

        //3. 通过反射获取方法对象，执行方法
        //3.1 获取 BrandServlet 字节码对象
        Class<? extends BaseServlet> cls = this.getClass();// this 是BrandServlet的对象

        //3.2 获取方法Method 对象
        //根据请求的最后一段路径进行方法分发
        try {
            Method method = cls.getMethod(methodName, HttpServletRequest.class, HttpServletResponse.class);
            //3.3 执行方法
            method.invoke(this,req,resp);
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }

    }

    /**
     * 用于比较两个 Date 对象的函数
     * @param date1
     * @param date2
     * @return
     */
    public static int compareDates(Date date1, Date date2) {
        if (date1.before(date2)) {
            return -1;
        } else if (date1.after(date2)) {
            return 1;
        } else {
            return 0;
        }
    }
}
