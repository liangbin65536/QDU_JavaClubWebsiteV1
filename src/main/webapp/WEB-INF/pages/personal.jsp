<%--
  Created by IntelliJ IDEA.
  User: lb
  Date: 2017/10/17
  Time: 9:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Java兴趣社团成员个人管理平台</title>
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/login.css"/>
    <script src="<%=request.getContextPath() %>/static/js/lib/jquery-3.2.1.min.js"></script>
    <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function () {

            $("#loginbtn").click(function () {
                var id = $("#id").val();
                var pw = $("#password").val();
                $.ajax({
                    url:"personallogin",
                    type:"get",
                    contentType:"application/json",
                    data:{"id":id,"password":pw},
                    dataType:"json",
                    success: function (data) {
                        if (data!=null && data!=""){
                            if (data.result.trim()=="failure"){
                                $("#error-text").text("账号不存在或密码错误!");
                            }
                            else if (data.result.trim()=="success"){
                                $("#error-text").text("登陆成功，正在为您跳转到成员详情页面");
                                window.location.href = 'verification?id='+id;
                            }
                        }


                    }
                });

            });

        });


    </script>
</head>
<body>

<div id="particles-js"></div>

<div id="test">

    <div id="head-title">
        <span class="glyphicon glyphicon-user"> Java兴趣社团成员个人管理平台</span>
    </div>

    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <span class="modal-title glyphicon glyphicon-warning-sign" id="myModalLabel">  信息</span>
                </div>
                <div class="modal-body"><h5 id="error-text"></h5></div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>

    <br><br>

    <form role="form-horizontal">
        <div class="form-group">

            <input type="text" class="form-control" id="id" placeholder="请输入账号">

        </div>
        <div class="form-group">

            <input type="password" class="form-control" id="password" placeholder="请输入密码">

        </div>
        <div class="form-group">
            <button type="button" class="btn btn-info" data-toggle="modal" data-target="#myModal" id="loginbtn">登 录</button>
        </div>
    </form>
</div>


<script src="<%=request.getContextPath() %>/static/js/particles.min.js"></script>
<script src="<%=request.getContextPath() %>/static/js/login.js"></script>
</body>
</html>