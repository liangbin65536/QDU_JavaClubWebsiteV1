<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/applyregister.css"/>
    <script src="<%=request.getContextPath() %>/static/js/lib/jquery-3.2.1.min.js"></script>
    <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body>

<script>
    var status = ${requestScope.status};
    var tag = false;
    $(document).ready(function () {

        switch(status){
            case "2":
                $("#selectedTeam").css('display','');
                $("#member-r").css('display','');
                $("#selected").css('display','');
                break;
            case "3":
                $("#team-c").css('display','');
                $("#createTeam").css('display','');
                break;
        }
        $("#createTeam").click(function(){
            captainRegister();
        });
        $("#registerMember").click(function(){
            memeberRegister();
        });
        $("#teams-body").on('click','.choseTeam',function(){
            var groupId = $(this).attr('val');
            var groupName=$(this).attr('tn');
            $("#selectedTeam").val(groupName);
            $("#groupId").val(groupId);
        });


        $("#team-title").click(function () {
            tag = !tag;
            if (tag){
                if($("#teams-body tr").length==0){
                    getAllTeams();
               }
                $("#teams-table").show();
            }
            else{
                $("#teams-table").hide();
            }
        })

    });
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
                            if(status=="2") {
                                var operate = $("<td class = 'team_d'><span class ='choseTeam btn btn-link' style='cursor:pointer'tn="+list[i].groupName+" val="+list[i].id+">选择</span></td>");
                            }
                            else {
                                var operate = $("<td class = 'team_d btn btn-link'>暂无</td>");
                            }
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
    function captainRegister(){
        var bean = getParameter();
        if(!checkParm(bean)){return};
        $.ajax({
            url:"captionRegister",
            type:"post",
            contentType:"application/x-www-form-urlencoded",
            data:bean,
            dataType:"json",
            success: function (data) {
                if (data!=null && data!=""){
                    if (!data.result) {
                       var flag = data.data;
                        if(flag=="1"){
                            $("#error-text").text("该学号已注册!请直接登录");
                        }
                        else if(flag=="2"){
                            $("#error-text").text("该队名已被注册!请更换团队名");
                        }else{
                            $("#error-text").text("注册失败，请重新刷新页面!");
                        }
                    }
                    else{
                        $("#error-text").text("注册成功，正在跳转。。");
                        window.location.href = 'competition';
                    }
                }
            }
        });
    }
    function memeberRegister(){
        var bean = getParameter();
        if(!checkParm(bean)){return};
        $.ajax({
            url:"memberRegister",
            type:"post",
            contentType:"application/x-www-form-urlencoded",
            data:bean,
            dataType:"json",
            success: function (data) {
                if (data!=null && data!=""){
                    if (!data.result) {
                        var flag = data.data;
                        if(flag=="1"){
                            $("#error-text").text("该学号已注册!请直接登录");
                        }else {
                            $("#error-text").text("注册失败，请重新尝试!");
                        }
                    }
                    else{
                        $("#error-text").text("注册成功，正在跳转。。");
                        window.location.href = 'competition';
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
        if(status=="3"){
            member.groupName=$("#teamName").val();
        }
        if(status=="2"){
            member.groupId = $("#groupId").val();
        }
        return member;
    }


    function checkParm(member){
        if(member.username==null||member.username==""){
            $("#error-text").text("学号不能为空");
            return false;
        }
        if(member.name==null||member.name==""){
            $("#error-text").text("姓名不能为空");
            return false;
        }
        if(member.mobile==null||member.mobile==""){
            $("#error-text").text("手机号码不能为空");
            return false;
        }
        if(member.major==null||member.major==""){
            $("#error-text").text("专业不能为空");
            return false;
        }
        if(status=="2"){
            if(member.groupId==null||member.groupId==""){
                $("#error-text").text("请选择您的团队");
                return false;
            }
        }else if(status=="3"){
            if(member.groupName==null||member.groupName==""){
                $("#error-text").text("请为自己的团队起名");
                return false;
            }
        }
        return true;
    }


</script>

<div id="particles-js"></div>

<div id="head-title">
    <span class="glyphicon glyphicon-user"> 易途杯软件大赛战队注册 </span>

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




<form id="person" class="form-horizontal">
    <div class="form-group">
        <input class="form-control" type="number" id="username" placeholder="学 号" oninput="if(value.length>12)value=value.slice(0,12)"  />
    </div>
    <div class="form-group">
        <input  class="form-control" type="text" id="name" placeholder="姓 名" maxlength="6"/>
    </div>
    <div class="form-group">
        <input class="form-control" type="number" id="mobile" placeholder="手 机"oninput="if(value.length>11)value=value.slice(0,11)" />
    </div>
    <div class="form-group">
        <input class="form-control"  type="text" id="major" placeholder="专 业" />
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
        <input type="text" id="teamName" class="form-control" placeholder="队 名" />
    </div>

    <div class="form-group">
        <input type="text" style="display: none;" class="form-control" id="selectedTeam" placeholder="已选战队：暂无" disabled/><input type="hidden" id="groupId"/></input>
    </div>

    <div class="form-group" style="display:none" id="createTeam">
        <input class="form-control btn btn-info" type="button"  value="创建团队" data-toggle="modal" data-target="#myModal" />
    </div>
    <div id="member-r" style="display:none" class="form-group">
        <input class="form-control btn btn-info"  type="button" id="registerMember" value="完成注册" data-toggle="modal" data-target="#myModal" />
    </div>
        <span class='btn btn-link' id='team-title'>查看已注册团队列表</span>
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


</form>



<script src="<%=request.getContextPath() %>/static/js/particles.min.js"></script>
<script src="<%=request.getContextPath() %>/static/js/register.js"></script>
</body>
</html>
