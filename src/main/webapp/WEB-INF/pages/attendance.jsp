<%--
  Created by IntelliJ IDEA.
  User: lb
  Date: 2017/10/19
  Time: 14:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%--%>
    <%--String id = session.getAttribute("username").toString();--%>
<%--%>--%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
        <title>签到</title>
        <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/attendance.css"/>
        <script src="<%=request.getContextPath() %>/static/js/lib/jquery-3.2.1.min.js"></script>
        <script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=YqShqbiGEpyNfBORQY4heIPSRwLysfSc"></script>
        <%--<script type="text/javascript" src="http://developer.baidu.com/map/jsdemo/demo/convertor.js"></script>--%>
        <script>
            $(document).ready(function () {
                var id = $("#userid").val();
                $("#check-in").click(function () {
                    $.ajax({
                        url: "activitycheck",
                        type: "get",
                        contentType: "application/json",
                        data:{"id":id},
                        dataType: "json",
                        success: function (data) {
                            if (data.result.trim()=="success"){
                                window.location.href = 'verification?id='+id;;
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
        <div id="allmap"></div>
        <input hidden  value="${username}" id="userid" />
        <p id="location" class="text-success"></p>
        <button type="button" class="btn btn-info btn-block" id="check-in" disabled>我要签到</button>
    </body>
</html>


<script type="text/javascript">
    // 百度地图API功能
    //GPS坐标
    var x = 120.436972;
    var y = 36.081857;
    var ggPoint = new BMap.Point(x,y);

    //地图初始化
    var bm = new BMap.Map("allmap");
    bm.centerAndZoom(ggPoint, 15);
    bm.addControl(new BMap.NavigationControl());

    var geolocation = new BMap.Geolocation();
    geolocation.getCurrentPosition(function (r) {
        if(this.getStatus() == BMAP_STATUS_SUCCESS){
            var gc = new BMap.Geocoder();  //初始化，Geocoder类
            gc.getLocation(r.point, function (rs) {   //getLocation函数用来解析地址信息，分别返回省市区街等
                var province = 0; //获取省份
                var city = 0; //获取城市
                var district = 0; //区
                var street = 0; //街
                var streetNumber = 0; //街
                var business = 0; //建筑
                var addComp = rs.addressComponents;
                province = addComp.province; //获取省份
                city = addComp.city; //获取城市
                district = addComp.district; //区
                street = addComp.street; //街
                streetNumber = addComp.streetNumber; //街
                business = addComp.business; //商业建筑
                $("#location").text("你当前的位置为："+province+" "+city+" "+district+" "+street+" "+streetNumber+" "+business);
                if (district.trim()=="崂山区"&&street.trim()==""){
                    $("#check-in").attr("disabled",false);
                }
            })
//            var convertor = new BMap.Convertor();
//            var pointArr = [];
//            pointArr.push(r.point);
//            convertor.translate(pointArr, 1, 5, translateCallback)
        }
    },enableHighAccuracy = true)

    //坐标转换完之后的回调函数
    translateCallback = function (data){
        if(data.status === 0) {
            var gc = new BMap.Geocoder();  //初始化，Geocoder类
            gc.getLocation(data.points[0], function (rs) {   //getLocation函数用来解析地址信息，分别返回省市区街等
                var province = 0; //获取省份
                var city = 0; //获取城市
                var district = 0; //区
                var street = 0; //街
                var streetNumber = 0; //街
                var business = 0; //建筑
                var addComp = rs.addressComponents;
                province = addComp.province; //获取省份
                city = addComp.city; //获取城市
                district = addComp.district; //区
                street = addComp.street; //街
                streetNumber = addComp.streetNumber; //街
                business = addComp.business; //商业建筑
                $("#location").text("你当前的位置为："+province+city+district+street+streetNumber);
            })
        }
    }


</script>













<%--<script type="text/javascript">--%>
    <%--// 百度地图API功能--%>
    <%--var map = new BMap.Map("allmap");--%>
    <%--var point = new BMap.Point(120.436995,36.081835);--%>
    <%--map.centerAndZoom(point,12);--%>

    <%--var geolocation = new BMap.Geolocation();--%>
    <%--geolocation.getCurrentPosition(function(r){--%>
        <%--if(this.getStatus() == BMAP_STATUS_SUCCESS){--%>
            <%--var mk = new BMap.Marker(r.point);--%>
            <%--map.addOverlay(mk);--%>
            <%--map.panTo(r.point);--%>
            <%--alert('您的位置：'+r.point.lng+','+r.point.lat);--%>
            <%--BMap.Convertor.translate(r.point,1,5,translateCallback);--%>
        <%--}--%>
        <%--else {--%>
            <%--alert('failed'+this.getStatus());--%>
        <%--}--%>
    <%--},{enableHighAccuracy: true})--%>

    <%--translateCallback = function (data) {--%>
        <%--if(data.status === 0) {--%>
            <%--var marker = new BMap.Marker(data.points[0]);--%>
            <%--map.addOverlay(marker);--%>
            <%--map.setCenter(data.points[0]);--%>
            <%--var gc = new BMap.Geocoder();  //初始化，Geocoder类--%>
            <%--gc.getLocation(data.points[0], function (rs) {   //getLocation函数用来解析地址信息，分别返回省市区街等--%>
                <%--var province = 0; //获取省份--%>
                <%--var city = 0; //获取城市--%>
                <%--var district = 0; //区--%>
                <%--var street = 0; //街--%>
                <%--var streetNumber = 0; //街--%>
                <%--var business = 0; //建筑--%>
                <%--var addComp = rs.addressComponents;--%>
                <%--province = addComp.province; //获取省份--%>
                <%--city = addComp.city; //获取城市--%>
                <%--district = addComp.district; //区--%>
                <%--street = addComp.street; //街--%>
                <%--streetNumber = addComp.streetNumber; //街--%>
                <%--business = addComp.business; //商业建筑--%>
                <%--$("#location").text("你当前的位置为："+province+city+district+street+streetNumber);--%>
            <%--})--%>
        <%--}--%>
    <%--}--%>
<%--</script>--%>
