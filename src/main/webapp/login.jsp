<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2024/2/29
  Time: 17:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>login</title>
<%--    <link href="css/login.css" rel="stylesheet">--%>
    <link href="http://localhost:8080/hr-management-system/css/login.css" rel="stylesheet">
<%--    <link href="http://localhost:8080/hr_management_system_war_exploded/css/login.css" rel="stylesheet">--%>
<%--    http://localhost/hr_management_system_war_exploded/--%>

    <style>

        #username {
            width: 420px;
        }
        #password {
            width: 430px;
        }
    </style>

</head>

<body>
<div id="loginDiv" style="height: 350px">
    <form action="/hr-management-system/login/select" id="form" method="post">
        <h1 id="loginMsg">LOGIN IN</h1>
        <div id="errorMsg">${login_msg}</div>
<%--        <h1 id="logoutMsg">LOGOUT</h1>--%>
        <div id="errorMsg">${msg}</div>
        <div id="errorMsg">${error_msg}</div>
        <div id="errorMsg">${error_msg2}</div>
        <p>Username:<input id="username" name="username" type="text" placeholder="请输入2-9位英文字母">

           <br>
            <span id="username_err" class="err_msg" style="display: none">用户名不存在</span>
        </p>

        <%--<p>
            请输入2-9位的英文
        </p>--%>

        <p>Password:<input id="password" name="password" type="password" placeholder="请输入6-10位的密码只能包含数字字母下划线，其中至少包含数字和字母"></p>

       <%-- <p>
            请输入6-10位的密码只能包含数字字母下划线，其中至少包含数字和字母
        </p>--%>
<%--        <p>Remember:<input id="remember" name="remember" type="checkbox"></p>--%>
        <div id="subDiv">
            <input type="submit" class="button" value="login up">
<%--            <input type="reset" class="button" value="reset">&nbsp;&nbsp;&nbsp;--%>
<%--            <a href="register.html">没有账号？</a>--%>
        </div>
    </form>
</div>


</body>
</html>