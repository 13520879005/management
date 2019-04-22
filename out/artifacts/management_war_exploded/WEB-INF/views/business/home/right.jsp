<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    String webapp = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + webapp + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title></title>
    
    <link rel="stylesheet" href="<%=basePath%>business/css/common.css">
    <link rel="stylesheet" href="<%=basePath%>business/css/data_text.css">
    <script type="text/javascript" src="<%=basePath%>business/js/jquery.js"></script>
    <script type="text/javascript" src="<%=basePath%>business/js/echarts.min.js"></script>
    <script type="text/javascript">
        $(function(){

            var stux = new Array();
            var stuy = new Array();
            var stuR = JSON.parse('${stuR}');
            $.each(stuR,function(i,item){
                stux.push(item.username);
                stuy.push(item.num);
            });
            var studentChart = echarts.init(document.getElementById("studentph"));
            studentoption = null;
            studentoption = {
                tooltip : {
                    formatter: function (params) { //添加数字,否则为坐标
                        var tel = params.name + "<br>发帖数量：" + params.value;
                        return tel;
                    }
                },
                grid: {
                    bottom:'20%',
                    y:40
                },
                xAxis: {
                    // 分割线设置
                    splitLine:{
                        show:false,  //显示分割线         
                    },
                    axisLine: {
                        lineStyle: {
                            color: '#5ab1ef'
                        }
                    },
                    axisLabel: {
                        show: true,
                        textStyle: {
                            color: '#5ab1ef'
                        },
                        interval: 0,
                        formatter:function(value) {
                            if (value != null && value != '') {
                                var ret = "";//拼接加\n返回的类目项
                                var maxLength = 5;//每项显示文字个数
                                var valLength = value.length;//X轴类目项的文字个数
                                var rowN = Math.ceil(valLength / maxLength); //类目项需要换行的行数
                                if (rowN > 1)//如果类目项的文字大于3,
                                {
                                    for (var i = 0; i < rowN; i++) {
                                        var temp = "";//每次截取的字符串
                                        var start = i * maxLength;//开始截取的位置
                                        var end = start + maxLength;//结束截取的位置
                                        //这里也可以加一个是否是最后一行的判断，但是不加也没有影响，那就不加吧  你给谁看的  自言自语那咋则
                                        temp = value.substring(start, end) + "\n";
                                        ret += temp; //凭借最终的字符串
                                    }
                                    return ret;
                                }
                                else {
                                    return value;
                                }
                            }
                        }

                    },
                    type: 'category',
                    data: stux,
                },
                yAxis: {
                    splitLine:{
                        show:true,  //显示分割线  
                        lineStyle: {
                            color: '#5ab1ef'
                        }
                    },
                    type: 'value',
                    axisLine:false,
                    axisLabel: {
                        show: true,
                        textStyle: {
                            color: '#5ab1ef'

                        }
                    }
                },
                series: [{
                    itemStyle:{
                        normal: {
                            color:function(params) {
                                var colorList = ['#FE6A6A','#FED171','#DCE548','#E2E96B','#92DC5A', '#89D0A9','#7ADDEE','#5AB1EF','#B6A2DE','#A244F9'];
                                return colorList[params.dataIndex]
                            },
                            barBorderRadius:[25, 25, 0, 0]

                        }
                    },
                    barWidth : 20,
                    data: stuy,
                    type: 'bar',

                }]
            };
            studentChart.setOption(studentoption);

            var teax = new Array();
            var teay = new Array();
            var teaR = JSON.parse('${teaR}');
            $.each(teaR,function(i,item){
                teax.push(item.username);
                teay.push(item.num);
            });
            var teacherChart = echarts.init(document.getElementById("teacherph"));
            teacheroption = null;
            teacheroption = {
                tooltip : {
                    formatter: function (params) { //添加数字,否则为坐标
                        var tel = params.name + "<br>发帖数量：" + params.value;
                        return tel;
                    }
                },
                grid: {
                    bottom:'20%',
                    y:40
                },
                xAxis: {
                    // 分割线设置
                    splitLine:{
                        show:false,  //显示分割线         
                    },
                    axisLine: {
                        lineStyle: {
                            color: '#5ab1ef'
                        }
                    },
                    axisLabel: {
                        show: true,
                        textStyle: {
                            color: '#5ab1ef'
                        },
                        interval: 0,
                        formatter:function(value)
                        {
                            if (value != null && value != '') {
                                var ret = "";//拼接加\n返回的类目项
                                var maxLength = 5;//每项显示文字个数
                                var valLength = value.length;//X轴类目项的文字个数
                                var rowN = Math.ceil(valLength / maxLength); //类目项需要换行的行数
                                if (rowN > 1)//如果类目项的文字大于3,
                                {
                                    for (var i = 0; i < rowN; i++) {
                                        var temp = "";//每次截取的字符串
                                        var start = i * maxLength;//开始截取的位置
                                        var end = start + maxLength;//结束截取的位置
                                        //这里也可以加一个是否是最后一行的判断，但是不加也没有影响，那就不加吧  你给谁看的  自言自语那咋则
                                        temp = value.substring(start, end) + "\n";
                                        ret += temp; //凭借最终的字符串
                                    }
                                    return ret;
                                }
                                else {
                                    return value;
                                }
                            }
                        }

                    },
                    type: 'category',
                    data: teax,
                },
                yAxis: {
                    splitLine:{
                        show:true,  //显示分割线  
                        lineStyle: {
                            color: '#5ab1ef'
                        }
                    },
                    type: 'value',
                    axisLine:false,
                    axisLabel: {
                        show: true,
                        textStyle: {
                            color: '#5ab1ef'

                        }
                    }
                },
                series: [{
                    itemStyle:{
                        normal: {
                            color:function(params) {
                                var colorList = ['#FE6A6A','#FED171','#DCE548','#E2E96B','#92DC5A', '#89D0A9','#7ADDEE','#5AB1EF','#B6A2DE','#A244F9'];
                                return colorList[params.dataIndex]
                            },
                            barBorderRadius:[25, 25, 0, 0]

                        }
                    },
                    barWidth : 20,
                    data: teay,
                    type: 'bar',

                }]
            };
            teacherChart.setOption(teacheroption);
            //-----------------------------------学科
            var xktatel = new Array();
            var xuek = JSON.parse('${xuek}');
            $.each(xuek,function(i,item){
                xktatel.push(item.name);
            });
            var xktjChart = echarts.init(document.getElementById("xktj"));
            xktjoption = null;
            xktjoption = {
                tooltip : {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                legend: {
                    orient: 'vertical',
                    right:'10%',
                    top:'5%',
                    data:xktatel,
                    textStyle:{
                        fontSize: 14,//字体大小
                        color: '#00FFCC'//字体颜色
                    },
                },
                series : [
                    {
                        name:'标签',
                        type:'pie',
                        radius : '55%',
                        center: ['35%', '50%'],
                        labelLine: {
                            normal: {
                                show: false   // show设置线是否显示，默认为true，可选值：true ¦ false
                            }
                        },
                        label: {
                            normal: {
                                show : false
                            }
                        },
                        itemStyle: {
                            emphasis: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            },
                            normal:{
                                color:function(params) {
                                    //自定义颜色
                                    var colorList = ['#FE6A6A','#FED171','#E2E96B','#92DC5A','#7ADDEE','#5AB1EF','#B6A2DE','#A244F9','#DCE548','#89D0A9'];
                                    return colorList[params.dataIndex]
                                }
                            }
                        },
                        data:xuek.sort(function (a, b) { return a.value - b.value; }),
                        roseType: 'radius',
                        animationType: 'scale',
                        animationEasing: 'elasticOut',
                        animationDelay: function (idx) {
                            return Math.random() * 200;
                        }
                    },
                    {

                        type:'pie',
                        tooltip: {
                            show : false
                        },
                        labelLine: {
                            normal: {
                                show: false,  // show设置线是否显示，默认为true，可选值：true ¦ false
                            }
                        },
                        itemStyle: {
                            normal: {
                                color:'#1296db'
                            }
                        },
                        clickable:false,
                        hoverAnimation:false,
                        radius: ['61%', '63%'],
                        center: ['35%', '50%'],
                        data:[
                            {value:0}
                        ]
                    }
                ]

            };
            xktjChart.setOption(xktjoption);

            //--------------------回复
            var htltjtatel = new Array();
            var went = JSON.parse('${went}');
            $.each(went,function(i,item){
                htltjtatel.push(item.name);
            });
            var htltjChart = echarts.init(document.getElementById("htltj"));
            htltjoption = null;
            htltjoption = {
                tooltip : {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                legend: {
                    orient: 'vertical',
                    right:'10%',
                    top:'5%',
                    data:htltjtatel,
                    textStyle:{
                        fontSize: 14,//字体大小
                        color: '#00FFCC'//字体颜色
                    },
                },
                series : [
                    {
                        name:'标签',
                        type:'pie',
                        radius : '55%',
                        center: ['35%', '50%'],
                        labelLine: {
                            normal: {
                                show: false   // show设置线是否显示，默认为true，可选值：true ¦ false
                            }
                        },
                        label: {
                            normal: {
                                show : false
                            }
                        },
                        itemStyle: {
                            emphasis: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            },
                            normal:{
                                color:function(params) {
                                    //自定义颜色
                                    var colorList = ['#FE6A6A','#FED171','#E2E96B','#92DC5A','#7ADDEE','#5AB1EF','#B6A2DE','#A244F9','#DCE548','#89D0A9'];
                                    return colorList[params.dataIndex]
                                }
                            }
                        },
                        data:went.sort(function (a, b) { return a.value - b.value; }),
                        roseType: 'radius',
                        animationType: 'scale',
                        animationEasing: 'elasticOut',
                        animationDelay: function (idx) {
                            return Math.random() * 200;
                        }
                    },
                    {

                        type:'pie',
                        tooltip: {
                            show : false
                        },
                        labelLine: {
                            normal: {
                                show: false,  // show设置线是否显示，默认为true，可选值：true ¦ false
                            }
                        },
                        itemStyle: {
                            normal: {
                                color:'#1296db'
                            }
                        },
                        clickable:false,
                        hoverAnimation:false,
                        radius: ['61%', '63%'],
                        center: ['35%', '50%'],
                        data:[
                            {value:0}
                        ]
                    }
                ]

            };
            htltjChart.setOption(htltjoption);
        })
        function fn_gotoReply(_val){
            var url = "<%=basePath%>paste/gotoReply.xhtml?pasteid="+_val;
            window.open(url,"_blank");
        }
    </script>
</head>
<body>
<!--content开始-->
<div class="data_content">

    <div class="data_main">
        <div class="main_left fl">
            <div class="left_1">
                <div class="main_title">
                    <img src="<%=basePath%>business/images/home/title_1.png" alt="">
                    推荐・最近更新
                </div>
                <div id="chart_1" class="chart" style="width:100%;height: 280px;">
                    <div class="main_table">
                        <table >
                            <thead>
                            <%--<tr>
                                <th></th>
                                <th></th>
                                <th></th>
                                <th></th>
                                <th><a>更多>>></a></th>
                            </tr>--%>
                            <tr>
                                <th>序号</th>
                                <th>内容</th>
                                <th>发帖人</th>
                                <th>类型</th>
                                <th>发帖时间</th>
                            </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${tjList}" var="tj" varStatus="i">
                                    <tr>
                                        <td>${i.index+1}</td>
                                        <td><a onclick="fn_gotoReply('${tj.pasteid}')">${tj.pastes}</a></td>
                                        <td>${tj.username}</td>
                                        <td>${tj.pasteusertype}</td>
                                        <td>${tj.lastdate}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="left_2">
                <div class="main_title">
                    <img src="<%=basePath%>business/images/home/title_1.png" alt="">
                    热帖・最近更新
                </div>
                <div id="chart_2" class="chart" style="width:100%;height: 280px;">
                    <div class="main_table">
                        <table >
                            <thead>
                            <%--<tr>
                                <th></th>
                                <th></th>
                                <th></th>
                                <th></th>
                                <th><a>更多>>></a></th>
                            </tr>--%>
                            <tr>
                                <th>排行</th>
                                <th>内容</th>
                                <th>发帖人</th>
                                <th>点击量</th>
                                <th>回贴量</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${hotList}" var="hot" varStatus="i">
                                <tr>
                                    <td>${i.index+1}</td>
                                    <td><a onclick="fn_gotoReply('${hot.pasteid}')">${hot.pastes}</a></td>
                                    <td>${hot.username}</td>
                                    <td>${hot.hits}</td>
                                    <td>${hot.replynum}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="left_3">
                <div class="main_title">
                    <img src="<%=basePath%>business/images/home/title_2.png" alt="">
                    课程发帖量统计
                </div>
                <div id="xktj" class="chart" style="width:100%;height: 100%;"></div>
            </div>
        </div>
        <div class="main_center fl">
            <div class="center_text">
                <div class="main_title">
                    <img src="<%=basePath%>business/images/home/title_3.png" alt="">
                    学生回帖量・TOP5
                </div>
                <div id="studentph" style="width:100%;height:100%;"></div>
            </div>
            <div class="center_text">
                <div class="main_title">
                    <img src="<%=basePath%>business/images/home/title_3.png" alt="">
                    教师回帖量・TOP5
                </div>
                <div id="teacherph" style="width:100%;height:100%;"></div>
            </div>
            <div class="center_text">
                <div class="main_title">
                    <img src="<%=basePath%>business/images/home/title_3.png" alt="">
                    课程回帖量统计
                </div>
                <div id="htltj" style="width:100%;height:100%;"></div>
            </div>
        </div>
    </div>
</div>
</div>
</body>
</html>