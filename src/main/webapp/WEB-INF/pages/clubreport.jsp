<%--
  Created by IntelliJ IDEA.
  User: lb
  Date: 2017/10/21
  Time: 10:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/clubreport.css"/>
        <!-- 引入 ECharts 文件 -->
        <script src="<%=request.getContextPath() %>/static/js/lib/jquery-3.2.1.min.js"></script>
        <script src="<%=request.getContextPath()%>/static/js/lib/echarts.js"></script>

    </head>

    <body>
        <div id="main" style="width: 800px;height: 500px;"></div>
        <br>
        <p id="major-text">
            <span class="span-text">软件工程： </span>       <span class="span-num" id="rgnum"></span>
            <span class="span-text">   软件工程（服务外包）： </span>      <span class="span-num" id="rwnum"></span>
            <span class="span-text">   计算机科学： </span>       <span class="span-num" id="jknum"></span>
            <span class="span-text">   数字媒体： </span>        <span class="span-num" id="smnum"></span>
            <span class="span-text">   其他： </span>      <span class="span-num" id="qtnum"></span>
        </p>
        <br>
        <div id="gender" style="width: 800px;height: 500px;"></div>
        <br>
        <p id="gender-text">
            <span class="span-text">男生： </span>     <span class="span-num" id="malenum"></span>
            <span class="span-text">   女生： </span>      <span class="span-num" id="femalenum"></span>
        </p>
        <br>
        <div id="dept" style="width: 800px;height: 500px;"></div>
        <br>
        <p id="dept-text">
            <span class="span-text">秘书部： </span>        <span class="span-num" id="msbnum"></span>
            <span class="span-text">   技术部： </span>     <span class="span-num" id="jsbnum"></span>
            <span class="span-text">   宣传部： </span>     <span class="span-num" id="xcbnum"></span>
        </p>



        <script>
            var male;
            var female;
            var rg;
            var rw;
            var jk;
            var sm;
            var all;
            var qt;
            var majorChart = echarts.init(document.getElementById('main'));
            var genderChart = echarts.init(document.getElementById('gender'));
            var deptChart = echarts.init(document.getElementById('dept'));
            $(document).ready(function () {
                $.ajax({
                    url:"getreport",
                    type:"get",
                    contentType:"application/json",
                    data:"",
                    success:function (data) {
                        if (data!=null && data!=""){
                            male = data.male;
                            female = data.female;
                            rg = data.rg;
                            rw = data.rw;
                            jk = data.jk;
                            sm = data.sm;
                            all = male+female;
                            qt = all-(rg+rw+jk+sm);
                            $("#rgnum").text(data.rg);
                            $("#rwnum").text(data.rw);
                            $("#jknum").text(data.jk);
                            $("#smnum").text(data.sm);
                            $("#qtnum").text(data.female+data.male-data.rg-data.rw-data.jk-data.sm);
                            $("#malenum").text(data.male);
                            $("#femalenum").text(data.female);
                            $("#jsbnum").text(data.jsb);
                            $("#msbnum").text(data.msb);
                            $("#xcbnum").text(data.xcb);

                            // 使用刚指定的配置项和数据显示图表。
                            majorChart.setOption({
                                backgroundColor: '#2c343c',
                                visualMap: {
                                    show: false,
                                    min: 80,
                                    max: 600,
                                    inRange: {
                                        colorLightness: [0, 1]
                                    }
                                },
                                series : [
                                    {
                                        name: '访问来源',
                                        type: 'pie',
                                        radius: '55%',
                                        data:[
                                            {value:data.rg*10, name:'软件工程'},
                                            {value:data.rw*10, name:'软件工程（服务外包）'},
                                            {value:data.jk*10, name:'计算机科学'},
                                            {value:data.sm*10, name:'数字媒体'},
                                            {value:(data.female+data.male-data.rg-data.rw-data.jk-data.sm)*10, name:'其他'}
                                        ],
                                        roseType: 'angle',
                                        label: {
                                            normal: {
                                                textStyle: {
                                                    color: 'rgba(255, 255, 255, 1)'
                                                }
                                            }
                                        },
                                        labelLine: {
                                            normal: {
                                                lineStyle: {
                                                    color: 'rgba(255, 255, 255, 0.3)'
                                                }
                                            }
                                        },
                                        itemStyle: {
                                            normal: {
                                                color: '#c23531',
                                                shadowBlur: 200,
                                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                                            }
                                        }
                                    }
                                ]
                            });

                            // 使用刚指定的配置项和数据显示图表。
                            genderChart.setOption({
                                backgroundColor: '#2c343c',
                                visualMap: {
                                    show: false,
                                    min: 80,
                                    max: 600,
                                    inRange: {
                                        colorLightness: [0, 1]
                                    }
                                },
                                series : [
                                    {
                                        name: '访问来源',
                                        type: 'pie',
                                        radius: '55%',
                                        data:[
                                            {value:data.male, name:'男生'},
                                            {value:data.female, name:'女生'},
                                        ],
                                        roseType: 'angle',
                                        label: {
                                            normal: {
                                                textStyle: {
                                                    color: 'rgba(255, 255, 255, 1)'
                                                }
                                            }
                                        },
                                        labelLine: {
                                            normal: {
                                                lineStyle: {
                                                    color: 'rgba(255, 255, 255, 0.3)'
                                                }
                                            }
                                        },
                                        itemStyle: {
                                            normal: {
                                                color: '#c23231',
                                                shadowBlur: 200,
                                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                                            }
                                        }
                                    }
                                ]
                            });



                            // 使用刚指定的配置项和数据显示图表。
                            deptChart.setOption({
                                backgroundColor: '#2c343c',
                                visualMap: {
                                    show: false,
                                    min: 80,
                                    max: 600,
                                    inRange: {
                                        colorLightness: [0, 1]
                                    }
                                },
                                series : [
                                    {
                                        name: '访问来源',
                                        type: 'pie',
                                        radius: '55%',
                                        data:[
                                            {value:data.msb*5, name:'秘书部'},
                                            {value:data.jsb*5, name:'技术部'},
                                            {value:data.xcb*5, name:'宣传部'},
                                        ],
                                        roseType: 'angle',
                                        label: {
                                            normal: {
                                                textStyle: {
                                                    color: 'rgba(255, 255, 255, 1)'
                                                }
                                            }
                                        },
                                        labelLine: {
                                            normal: {
                                                lineStyle: {
                                                    color: 'rgba(255, 255, 255, 0.3)'
                                                }
                                            }
                                        },
                                        itemStyle: {
                                            normal: {
                                                color: '#c23231',
                                                shadowBlur: 200,
                                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                                            }
                                        }
                                    }
                                ]
                            });







//                            $("#male").val(m);
//                            $("#female").val(f);
//                            $("#all").val(all);
//                            $("#rg").val(rg);
//                            $("#rw").val(rw);
//                            $("#jk").val(jk);
//                            $("#sm").val(sm);
//                            $("#qd").val(data.qd);
//                            $("#msb").val(data.msb);
//                            $("#jsb").val(data.jsb);
//                            $("#xcb").val(data.xcb);
//                            $("#qt").val(all-(rg+rw+jk+sm));
                        }
                    }
                })
            })
        </script>


        <%--<script type="text/javascript">--%>
            <%--// 基于准备好的dom，初始化echarts实例--%>
            <%--var myChart = echarts.init(document.getElementById('main'));--%>
            <%--// 指定图表的配置项和数据--%>
<%--//            var option = {--%>
<%--//                backgroundColor: '#2c343c',--%>
<%--//                visualMap: {--%>
<%--//                    show: false,--%>
<%--//                    min: 80,--%>
<%--//                    max: 600,--%>
<%--//                    inRange: {--%>
<%--//                        colorLightness: [0, 1]--%>
<%--//                    }--%>
<%--//                },--%>
<%--//                series : [--%>
<%--//                    {--%>
<%--//                        name: '访问来源',--%>
<%--//                        type: 'pie',--%>
<%--//                        radius: '55%',--%>
<%--//                        data:[--%>
<%--//                            {value:236, name:'软件工程'},--%>
<%--//                            {value:277, name:'软件工程（服务外包）'},--%>
<%--//                            {value:311, name:'计算机科学'},--%>
<%--//                            {value:444, name:'数字媒体'},--%>
<%--//                            {value:121, name:'其他'}--%>
<%--//                        ],--%>
<%--//                        roseType: 'angle',--%>
<%--//                        label: {--%>
<%--//                            normal: {--%>
<%--//                                textStyle: {--%>
<%--//                                    color: 'rgba(255, 255, 255, 0.3)'--%>
<%--//                                }--%>
<%--//                            }--%>
<%--//                        },--%>
<%--//                        labelLine: {--%>
<%--//                            normal: {--%>
<%--//                                lineStyle: {--%>
<%--//                                    color: 'rgba(255, 255, 255, 0.3)'--%>
<%--//                                }--%>
<%--//                            }--%>
<%--//                        },--%>
<%--//                        itemStyle: {--%>
<%--//                            normal: {--%>
<%--//                                color: '#c23531',--%>
<%--//                                shadowBlur: 200,--%>
<%--//                                shadowColor: 'rgba(0, 0, 0, 0.5)'--%>
<%--//                            }--%>
<%--//                        }--%>
<%--//                    }--%>
<%--//                ]--%>
<%--//            };--%>


        <%--</script>--%>
    </body>
</html>
