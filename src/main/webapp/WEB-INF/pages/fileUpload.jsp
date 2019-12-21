<%@ page language="java" contentType="text/html; charset=GB18030" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
    <title>易途杯软件设计大赛--项目提交</title>
</head>
<body>

    <div id="head-title" style="margin-left: 100px">
        <span class="glyphicon glyphicon-user"> 易途杯项目上传</span>
    </div>
    <br>
    <form action="fileUpload.html" method="post" enctype="multipart/form-data" onsubmit="alert('正在提交，不要在页面刷新完毕之前关闭窗口')">
            选择文件:<input type="file" name="file">
            <input type="submit" value="提交"/>
    </form>
</body>
</html>