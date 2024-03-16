package com.turing.web.servlet;

import com.alibaba.fastjson.JSON;
import com.turing.pojo.*;
import com.turing.service.impl.AdministratorServiceImpl;
import com.turing.service.impl.ImagesServiceImpl;
import com.turing.service.impl.SalaryServiceImpl;
import com.turing.service.impl.TrainServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/uploadServlet")
@MultipartConfig
public class UploadServlet extends HttpServlet {
    private static ImagesServiceImpl imagesService = new ImagesServiceImpl();// 创建service 对象
/*

    public void upload(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Part filePart = req.getPart("image"); // 获取上传的文件
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // MSIE fix.
        InputStream fileContent = filePart.getInputStream();
        // ...处理文件保存到服务器或数据库...

        // 保存路径
        String uploadPath = getServletContext().getRealPath("") + File.separator + "upload";
        File uploadDir = new File(uploadPath);//上传Dir
        if (!uploadDir.exists()) uploadDir.mkdir();

        // 保存文件
        String filePath = uploadPath + File.separator + fileName;
        Files.copy(fileContent, Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);

        // 调用service 添加头像路径至 数据库 中
        imagesService.upload(uploadPath,1);

        // 转换为JSON 对象
        String jsonString = JSON.toJSONString(uploadPath);

        // 响应JSON 对象
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write(jsonString);


    }
*/
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Part filePart = req.getPart("image"); // 获取上传的文件
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // MSIE fix.
        InputStream fileContent = filePart.getInputStream();
        // ...处理文件保存到服务器或数据库...

        /* 保存图片到服务器
        * */
        // 保存路径
        String uploadPath = getServletContext().getRealPath("") + File.separator + "upload";
        File uploadDir = new File(uploadPath);//上传Dir
        if (!uploadDir.exists()) uploadDir.mkdir();

        // 保存文件
        String filePath = uploadPath + File.separator + fileName;
        Files.copy(fileContent, Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);

        /* 存储图片到数据库中
        * */
/*// 假设使用JDBC
        String sql = "INSERT INTO images (name, path) VALUES (?, ?)";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setString(1, fileName);
            statement.setString(2, filePath);
            statement.executeUpdate();
        }
        */

        // 调用service 添加头像路径至 数据库 中
        imagesService.upload(filePath, fileName,1);

        // 转换为JSON 对象
        String jsonString = JSON.toJSONString(uploadPath);

        // 响应JSON 对象
        resp.setContentType("text/json;charset=utf-8");
        resp.getWriter().write(jsonString);
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);

    }
}