<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/applyIndex.css"/>
    <script src="<%=request.getContextPath() %>/static/js/lib/jquery-3.2.1.min.js"></script>
    <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>
        body{
            margin:0 auto;
            text-align:center;
        }
        table{
            margin:0 auto;
            text-align:center;
        }
    </style>
</head>
<body>
<script>
    var status = ${sessionScope.user.position};
    var enrollment = ${sessionScope.user.enrollment};
    var projectId = ${sessionScope.user.projectId};
    var groupId = ${sessionScope.user.groupId};
    $(document).ready(function () {
        if(status ==0&&groupId==0){
            $("#selectedTeam").val("未加入战队");
            $("#projectd").val("未选择项目");
            $("#teams").show();
            getAllTeams();
        }
        $("#enrollment").val(enrollment);
        $("input").attr("disabled",'');
        $("#enrollment").attr('disabled','');
        getAllMembers();
        getAllProjects();
        // getAllTeams();
        $("#member-body").on('click','.delMember',function(){
            var userId=$(this).attr('vall');
            var captainId = ${sessionScope.user.id };
            var position = ${sessionScope.user.position};
            var groupId = ${sessionScope.user.groupId};
            if(confirm("确定踢出该队员？")){
                if(captainId!=null&&captainId!=""&&position=="1"){
                    delMember(groupId,userId);
                }else{
                    $("#error-text").text("删除失败，请重新尝试!");
                }

            }

        });
        $("#teams-body").on('click','.choseTeam',function(){
            if(confirm("确定加入该团队？")){
                var groupId = $(this).attr('val');
                choseTeam(groupId);
            }

        });
        $("#subtn").click(function () {
            if(confirm("确定更换项目？")){
                var project = parseInt($("#project").val());
                var group = ${sessionScope.user.groupId};
                $.ajax({
                    url: "changeProject",
                    type: "get",
                    contentType: "application/json",
                    data:{"projectId":project,"groupId":group},
                    dataType: "json",
                    success: function (data) {
                        if (data.result){
                            $("#error-text").text("修改项目成功");
                            $("#projectd").val("已选项目："+data.data);
                            //location.reload();
                        }
                    }
                })
            }
        })

    });
    function delMember(groupId,userId){
        $.ajax({
            url:"delMember",
            type:"get",
            contentType:"application/json",
            data:{"groupId":groupId, "userId":userId},
            dataType:"json",
            success: function (data) {
                if (data!=null && data!=""){
                    if (!data.result) {
                        $("#error-text").text("查询错误，请重新刷新页面!");
                    }
                    else{
                        getAllMembers();
                    }
                }
            }
        });
    }
    function getAllMembers(){
        var userId = ${sessionScope.user.id };
        var groupId= ${sessionScope.user.groupId };
        $.ajax({
            url:"getAllMembers",
            type:"get",
            contentType:"application/json",
            data:{"userId":userId, "groupId":groupId},
            dataType:"json",
            success: function (data) {
                if (data!=null && data!=""){
                    if (!data.result) {
                        $("#error-text").text("查询错误，请重新刷新页面!");
                    }
                    else{
                        var list = data.data;
                        var table_member = $("#member-body");
                        table_member.children().remove();
                        for(var i = 0;i<list.length;i++){
                            var tr = $("<tr class='member_r'></tr>");
                            //var username = $("<td class = 'member_d'>"+list[i].username+"</td>");
                            var name = $("<td class = 'member_d'>"+list[i].name+"</td>");
                            var mobile = $("<td class = 'member_d'>"+list[i].mobile+"</td>");
                            //var major = $("<td class = 'member_d'>"+list[i].major+"</td>");
                            if(status=="1") {
                                var operate = $("<td class = 'member_d'><span class='delMember btn btn-link' data-toggle=’modal‘ data-target=’#myModal‘ style='cursor:pointer' vall=" + list[i].id + ">踢出</span></td>");
                            }
                            //tr.append(username);
                            tr.append(name);
                            tr.append(mobile);
                            //tr.append(major);
                            tr.append(operate);
                            table_member.append(tr);
                        }


                    }
                }
            }
        });
    }
    function getAllProjects(){
        $.ajax({
            url:"getAllProjects",
            type:"get",
            contentType:"application/json",
            dataType:"json",
            success: function (data) {
                if (data!=null && data!=""){
                    if (!data.result) {
                        $("#error-text").text("查询错误，请重新刷新页面!");
                    }
                    else{
                        var list = data.data;
                        var project = $("#project");
                        project.children().remove();
                        for(var i = 0;i<list.length;i++){
                            var option = $("<option value="+list[i].id+">"+list[i].name+"</option>");
                            project.append(option);
                        }
                        project.val(projectId);
                    }
                }
            }
        });
    }
    function getAllTeams(){
        $.ajax({
            url:"getAllGroups",
            type:"get",
            contentType:"application/json",
            dataType:"json",
            success: function (data) {
                if (data!=null && data!=""){
                    if (!data.result) {
                        $("#error-text").text("查询错误，请重新刷新页面!");
                    }
                    else{
                        var list = data.data;
                        var table_teams = $("#teams-body");
                        for(var i = 0;i<list.length;i++){
                            var tr = $("<tr class='team_r'></tr>");
                            var username = $("<td class = 'team_d'>"+list[i].groupName+"</td>");
                            var name = $("<td class = 'team_d'>"+list[i].captainName+"</td>");
                            var mobile = $("<td class = 'team_d'>"+list[i].projectName+"</td>");
                            var operate = $("<td class = 'team_d'><span class ='choseTeam btn btn-link'  style='cursor:pointer'tn="+list[i].groupName+" val="+list[i].id+">加入</span></td>");
                            tr.append(username);
                            tr.append(name);
                            tr.append(operate);
                            table_teams.append(tr);
                        }

                    }
                }
            }
        });
    }
    function choseTeam(groupId){
        $.ajax({
            url:"choseTeam",
            type:"get",
            contentType:"application/json",
            data:{"groupId":groupId},
            dataType:"json",
            success: function (data) {
                if (data!=null && data!=""){
                    if (!data.result) {
                        $("#error-text").text("查询错误，请重新刷新页面!");
                    }
                    else{
                        var groupName = data.groupName;
                        $("#selectedTeam").val(groupName);
                        var projectId = data.projectId;
                        $("#project").val(projectId);
                        var grouName = data.groupName;
                        $("#projectd").val("已选项目："+grouName);
                        //location.reload();
                    }
                }
            }
        });
    }
    function getParameter(){
        var member = {};
        member.username  = $("#username").val();
        member.name  = $("#name").val();
        member.mobile  = $("#mobile").val();
        member.enrollment  = $("#enrollment").val();
        member.major  = $("#major").val();
        if(status=="1"){
            member.groupName=$("#teamName").val();
        }
        if(status=="0"){
            member.groupId = $("#groupId").val();
        }
        return member;
    }
    function checkParm(member){
        if(member.username==null||member.username==""){
            alert("学号不能为空");
            return false;
        }
        if(member.name==null||member.name==""){
            alert("姓名不能为空");
            return false;
        }
        if(member.mobile==null||member.mobile==""){
            alert("手机号码不能为空");
            return false;
        }
        if(member.major==null||member.major==""){
            alert("专业不能为空");
            return false;
        }
        if(status=="0"){
            if(member.groupId==null||member.groupId==""){
                alert("请选择您的团队");
                return false;
            }
        }else if(status=="1"){
            if(member.groupName==null||member.groupName==""){
                alert("请为自己的团队起名");
                return false;
            }
        }
        return true;
    }


</script>

<div id="particles-js"></div>

<div id="head-title">
    <span class="glyphicon glyphicon-user"> 易途杯软件大赛信息管理 </span>
</div>

<div>
    <span class='btn btn-link' id='update'><a href="/uploader">上传项目文件</a></span>
    <span class='btn btn-link' id='team-title'><a href="/hotgroup">为别人点赞</a></span>
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

<form id="person" class="form-horizontal" style="margin: 0 auto">
    <div class="form-group">
        <input class="form-control" type="text" id="username" placeholder="学 号" required value="${sessionScope.user.username}"/>
    </div>
    <div class="form-group">
        <input  class="form-control" type="text" id="name" placeholder="姓 名" required value="${sessionScope.user.name}"/>
    </div>
    <div class="form-group">
        <input class="form-control" type="text" id="mobile" placeholder="手 机" pattern="0?(13|14|15|18|17)[0-9]{9}" required value="${sessionScope.user.mobile}"/>
    </div>
    <div class="form-group">
        <input class="form-control"  type="text" id="major" placeholder="专 业" required value="${sessionScope.user.major}"/>
    </div>
    <div class="form-group">
        <select id="enrollment" class="form-control" >
            <option value="2014">2014级</option>
            <option value="2015">2015级</option>
            <option value="2016">2016级</option>
            <option value="2017">2017级</option>
        </select>
    </div>
    <div id="team-c" style="display:none" class="form-group">
        <input type="text" id="teamName" class="form-control" placeholder="队 名" required/>
    </div>

    <div class="form-group">
        <input type="text"class="form-control" id="selectedTeam" disabled value="${sessionScope.user.groupName}"/><input type="hidden" id="groupId"/></input>
    </div>
    <div class="form-group">
        <input type="text" class="form-control" id="projectd" disabled value="已选项目：${sessionScope.user.projectName}"/>
    </div>
    <div class="form-group">
        <select id="project" class="form-control"></select>
    </div>

    <div class="form-group">
        <button type="button" class="btn btn-info" data-toggle="modal" data-target="#myModal" id="subtn">确认选择</button>
    </div>
    <span class="glyphicon glyphicon-user">团队成员</span>
    <table id="member-table" class="table table-hover">
        <thead>
        <tr>
            <th>队员</th>
            <th>电话</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody id="member-body"></tbody>
    </table>
    <div id="teams" style="display:none">
        <span class="glyphicon glyphicon-user"> 队伍列表</span>
        <table id="teams-table" class="table table-hover" >
            <thead>
            <tr>
                <th>团队</th>
                <th>队长</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="teams-body"></tbody>
        </table>
    </div>
</form>
<script src="<%=request.getContextPath() %>/static/js/particles.min.js"></script>
<script src="<%=request.getContextPath() %>/static/js/register.js"></script>

</body>
</html>
