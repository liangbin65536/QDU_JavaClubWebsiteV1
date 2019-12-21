<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: LB
  Date: 2017/10/9
  Time: 20:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<% Object id = session.getAttribute("userID");
    if (id==null)
        response.sendRedirect("index");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Java兴趣社团成员注册登记</title>
    <!-- 引入样式 -->
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/register.css"/>
    <script src="<%=request.getContextPath() %>/static/js/lib/jquery-3.2.1.min.js"></script>
    <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
    <div id="particles-js"></div>
    <div>
        <div id="head-title">
            <span class="glyphicon glyphicon-user"> Java兴趣社团成员注册平台</span>
        </div>

        <%--<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">--%>
            <%--<div class="modal-dialog">--%>
                <%--<div class="modal-content">--%>
                    <%--<div class="modal-header">--%>
                        <%--<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>--%>
                        <%--<span class="modal-title glyphicon glyphicon-warning-sign" id="myModalLabel">  已提交以下成员信息：</span>--%>
                    <%--</div>--%>
                    <%--<div class="modal-body"><h5 id="warning-text"></h5></div>--%>
                <%--</div><!-- /.modal-content -->--%>
            <%--</div><!-- /.modal -->--%>
        <%--</div>--%>
        <div id="admin">
            <%="<span>欢迎你，管理员 "+session.getAttribute("userID")+"</span>"%>
        </div>

        <form:form  action="/signup"  class="form-horizontal" commandName="member" role="form"  id="sign-up">
            <div class="form-group">
                <input type="text" name="name" class="form-control" id="name" placeholder="请输入名字" required/>
            </div>
            <div class="form-group">
                <select class="form-control" name="gender" id="gender">
                    <option value="0">男生 ✧(  ु•⌄• )◞</option>
                    <option value="1">女生 ◟( •⌄• ू )✧</option>
                </select>
            </div>
            <div class="form-group">
                <input type="text" name="major" class="form-control" id="major" placeholder="请输入专业" required/>
            </div>
            <div class="form-group">
                <select class="form-control" name="enrollment" id="enrollment">
                    <option value="2017">2017级</option>
                    <option value="2016">2016级</option>
                    <option value="2015">2015级</option>
                    <option value="2014">2014级</option>
                </select>
            </div>
            <div class="form-group">
                <input type="text" name="mobile" class="form-control" id="mobile" placeholder="请输入手机号" pattern="0?(13|14|15|18|17)[0-9]{9}"  required/>
            </div>
            <div class="form-group">
                <input type="text" name="remark" class="form-control" id="remark" placeholder="请输入备注" />
            </div>
            <div class="form-group">
                <button type="submit" class="btn btn-info" data-toggle="modal" data-target="#myModal" id="subtn">注 册</button>
            </div>

        </form:form>
    </div>

<script src="<%=request.getContextPath() %>/static/js/particles.min.js"></script>
<script src="<%=request.getContextPath() %>/static/js/register.js"></script>
</body>
</html>
