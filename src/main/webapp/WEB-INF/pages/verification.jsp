<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: lb
  Date: 2017/10/17
  Time: 8:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String id = request.getParameter("id");
    String username = session.getAttribute("username").toString();
    if (!id.equals(username)){
        request.getRequestDispatcher("personal.jsp").forward(request,response);
    }
%>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Java兴趣社团新增成员信息确认</title>
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/verification.css"/>
    <script src="<%=request.getContextPath() %>/static/js/lib/jquery-3.2.1.min.js"></script>
    <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function () {
            $("#updatebtn").click(function () {
                $("#sign-up").show();
            })
            $("#checkbtn").click(function () {
                var id = $("#id").val();
                $.ajax({
                    url: "activitycheck",
                    type: "get",
                    contentType: "application/json",
                    data:{"id":id},
                    dataType: "json",
                    success: function (data) {
                        if (data.result.trim()=="success"){
                            alert("签到成功");
                            $("#checkbtn").attr("disabled",true);
                        }
                    }
                })
            })
            $("#logout").click(function () {
                $.ajax({
                    url: "logout",
                    type: "get",
                    contentType: "application/json",
                    data:"",
                    dataType: "json",
                    success: function (data) {
                        if (data.result.trim()=="success"){
                            window.location.href = 'personal';
                        }
                        else {
                            alert("出错了。。。");
                        }
                    }
                })
            })
        })
    </script>
</head>
<body>

    <table class="table table-hover">
        <caption>2017年纳新成员个人信息表</caption>
        <thead>
        <tr>
            <th>编号</th>
            <th>姓名</th>
            <th>性别</th>
            <th>手机号</th>
            <th>专业</th>
            <th>年级</th>
            <th>部门</th>
            <th>见面会签到</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>${member.id}</td>
            <td>${member.name}</td>
            <td>${member.gender}</td>
            <td>${member.mobile}</td>
            <td>${member.major}</td>
            <td>${member.enrollment}</td>
            <td>${member.deptid}</td>
            <td>${member.activity_check}</td>
            <td>
                <button class="btn btn-warning" id="updatebtn">修改</button>
                <button class="btn btn-success" id="checkbtn">签到</button>
                <button class="btn btn-danger" id="logout">注销</button>
            </td>
        </tr>
        </tbody>
    </table>


    <form:form  action="/update"  class="form-inline" commandName="updatemember" role="form" id="sign-up">
        <div class="form-group">
            <input type="text" name="id" class="form-control" id="id" value="${member.id}" />
        </div>
        <div class="form-group">
            <input type="text" name="name" class="form-control" id="name" value="${member.name}" />
        </div>
        <div class="form-group">
            <select class="form-control" name="gender" id="gender">
                <option value="0">男生 ✧(  ु•⌄• )◞(0)</option>
                <option value="1">女生 ◟( •⌄• ू )✧(1)</option>
            </select>
        </div>
        <div class="form-group">
            <select class="form-control" name="major" id="major">
                <option value="软件工程">软件工程</option>
                <option value="软件工程（服务外包）">软件工程（服务外包）</option>
                <option value="计算机科学">计算机科学</option>
                <option value="数字媒体技术">数字媒体技术</option>
                <option value="其他">其他（请在备注中注明）</option>
            </select>
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
            <select class="form-control" name="deptid" id="deptid">
                <option value="1">1-秘书部</option>
                <option value="2">2-技术部</option>
                <option value="3">3-宣传部</option>
            </select>
        </div>
        <div class="form-group">
            <input type="text" name="mobile" class="form-control" id="mobile" value="${member.mobile}" placeholder="请输入手机号" pattern="0?(13|14|15|18|17)[0-9]{9}" required/>
        </div>
        <div class="form-group">
            <input type="text" name="remark" class="form-control" id="remark" value="${member.remark}" placeholder="请输入备注" />
        </div>
        <div class="form-group">
            <input type="text" name="password" class="form-control" id="password" value="${member.password}" placeholder="请输入新密码" required/>
        </div>
        <div class="form-group">
            <button type="submit" class="btn btn-info"  id="subtn">确认修改</button>
        </div>

    </form:form>



</body>
</html>
