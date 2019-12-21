<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: lb
  Date: 2017/11/14
  Time: 19:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>项目点赞</title>
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/home.css"/>
    <script src="<%=request.getContextPath() %>/static/js/lib/jquery-3.2.1.min.js"></script>
    <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
    <div id="particles-js"></div>
    <table class="table table-hover">
        <caption style="text-align: center">易途杯项目点赞系统</caption>
        <thead>
        <tr>
            <th>小组编号</th>
            <th>小组名称</th>
            <th>项目名称</th>
            <th>当前赞数</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${group}" var="groupitem">
            <c:if test="${groupitem.id!=sessionScope.user.groupId}">
                <tr>
                    <td id="${groupitem.id}">${groupitem.id}</td>
                    <td>${groupitem.groupName}</td>
                    <td>${groupitem.projectName}</td>
                    <td>${groupitem.praiseCount}</td>
                    <td>
                        <button class="btn btn-warning" id="${groupitem.id}-pbtn" type="button">点赞</button>
                    </td>
                </tr>
            </c:if>
        </c:forEach>

        </tbody>
    </table>
    <script src="<%=request.getContextPath() %>/static/js/particles.min.js"></script>
    <script src="<%=request.getContextPath() %>/static/js/login.js"></script>
    <c:forEach items="${prisegroups}" var="prisegroup">
        <script>
            $("#${prisegroup}-pbtn").attr("disabled",true);
        </script>
    </c:forEach>
    <script>
        $(document).ready(function () {
            $(":button").click(function () {
                var groupid = $(this).parent().prev().prev().prev().prev().attr("id");
                $(this).attr("disabled",true);
                $.ajax({
                    url:"praise",
                    type:"get",
                    contentType:"application/json",
                    data:{"groupid":groupid,"userid":${sessionScope.user.id}},
                    dataType:"json",
                    success:function (data) {
                        if (data.result){
                            window.location.reload();
                        }
                        else {
                            alert("发生了一些错误");
                        }
                    }
                })
            })
        })
    </script>
</body>
</html>
