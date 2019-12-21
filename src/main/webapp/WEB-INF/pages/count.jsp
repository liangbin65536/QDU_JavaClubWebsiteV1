<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: lb
  Date: 2017/10/14
  Time: 20:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Java兴趣社团新增成员一览</title>
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <script src="<%=request.getContextPath() %>/static/js/lib/jquery-3.2.1.min.js"></script>
    <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
    <table class="table table-hover">
        <caption>2017年纳新成员表</caption>
        <thead>
            <tr>
                <th>编号</th>
                <th>姓名</th>
                <th>性别</th>
                <th>专业</th>
                <th>年级</th>
                <th>加入时间</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach items="${members}" var="member">
            <tr>
                <td>${member.id}</td>
                <td>${member.name}</td>
                <td>${member.gender}</td>
                <td>${member.major}</td>
                <td>${member.enrollment}</td>
                <td>${member.entrytime}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</body>
</html>
