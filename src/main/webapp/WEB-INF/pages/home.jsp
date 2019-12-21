<%--
  Created by IntelliJ IDEA.
  User: lb
  Date: 2017/11/14
  Time: 18:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Java兴趣社团欢迎你</title>
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/home.css"/>
    <script src="<%=request.getContextPath() %>/static/js/lib/jquery-3.2.1.min.js"></script>
    <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
    <div id="particles-js"></div>
    <div>
        <ul class="list-group">
            <li class="list-group-item">
                <div id="head-title">
                    <span class="glyphicon glyphicon-user"> 欢迎加入Java兴趣社团</span>
                </div>
            </li>
            <li class="list-group-item"><a href="/index">Java兴趣社团成员管理平台</a></li>
            <li class="list-group-item"><a href="/personal">Java兴趣社团个人信息平台</a></li>
            <li class="list-group-item"><a href="/error">易途杯软件设计大赛入口</a></li>
        </ul>
    </div>
    <script src="<%=request.getContextPath() %>/static/js/particles.min.js"></script>
    <script src="<%=request.getContextPath() %>/static/js/login.js"></script>
</body>
</html>
