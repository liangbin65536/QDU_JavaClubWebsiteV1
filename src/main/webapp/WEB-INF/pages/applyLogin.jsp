<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>易途杯软件设计大赛</title>
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/applylogin.css"/>
    <script src="<%=request.getContextPath() %>/static/js/lib/jquery-3.2.1.min.js"></script>
    <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function () {
            $("#captainbtn").click(function(){
                window.location.href = 'applyRegister?status=3';
            });
            $("#memberbtn").click(function(){
                window.location.href = 'applyRegister?status=2';
            });


            $("#loginbtn").click(function () {
                var id = $("#id").val();
                var pw = $("#password").val();
                $.ajax({
                    url:"applyLogin",
                    type:"get",
                    contentType:"application/json",
                    data:{"username":id,"password":pw},
                    dataType:"json",
                    success: function (data) {
                        if (data!=null && data!=""){
                            if (!data.result) {
                                $("#error-text").text("账号不存在或密码错误!");
                            }
                            else{
                                $("#error-text").text("登陆成功，正在跳转。。");
                                window.location.href = 'applyIndex';
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
        <span class="glyphicon glyphicon-user"> 易途杯软件设计大赛</span>
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

            <input type="number" class="form-control" id="id" placeholder="请输入账号" oninput="if(value.length>12)value=value.slice(0,12)">

        </div>
        <div class="form-group">

            <input type="password" class="form-control" id="password" placeholder="请输入密码">

        </div>
        <div class="form-group">
            <button type="button" class="btn btn-info" data-toggle="modal" data-target="#myModal" id="loginbtn">登 录</button>
            <br><br>
            <button type="button" class="btn btn-warning" id="captainbtn" value="1">队长注册</button>
            <button type="button" class="btn btn-warning" id="memberbtn" value="0">队员注册</button>
        </div>
    </form>
</div>


<script src="<%=request.getContextPath() %>/static/js/particles.min.js"></script>
<script src="<%=request.getContextPath() %>/static/js/login.js"></script>
</body>
</html>