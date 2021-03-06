<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%
	String webapp = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + webapp + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<HTML>
<HEAD>
	<TITLE>学术互动平台</TITLE>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>business/css/layout-green.css"/>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>business/easyui/themes/default/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>business/easyui/themes/icon.css"/>
    <script type="text/javascript" src="<%=basePath%>business/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>business/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="<%=basePath%>business/easyui/jquery.easyui.min.js"></script>
	<script src="<%=basePath%>business/layer/layer.js"></script>
	<script type="text/javascript">
        $(function(){
            doquery();
        })
		function doquery(){
            $('#mydatagrid').datagrid({
                url:'<%=basePath%>paste/queryPasteHis.xhtml',
                iconCls:'icon-edit',//图标
                title:'发帖历史',
                height: 'auto',
                nowrap: false,
                striped: true,
                border: true,
                collapsible:false,//是否可折叠的
                fitColumns:true,//宽度自适应
                remoteSort:false,
                idField:'fldId',
                singleSelect:true,//是否单选
                pagination:true,//分页控件
                rownumbers:true,//行号
                columns:[[
                    {field:'pastes',title:'发帖内容',width:200,halign:'left',align:'left'},
                    {field:'lastdate',title:'发帖日期',width:200,halign:'left',align:'left'},
                    {field:'hits',title:'点击量',width:200,halign:'left',align:'left'},
                    {field:'replynum',title:'回复量',width:200,halign:'left',align:'left'}
                ]]
            });
            //设置分页控件
            var p = $('#mydatagrid').datagrid('getPager');
            $(p).pagination({
                pageSize: 10,//每页显示的记录条数，默认为10
                pageList: [10],//可以设置每页记录条数的列表
                beforePageText: '第',//页数文本框前显示的汉字
                afterPageText: '页    共 {pages} 页',
                displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',
            });
		}

	</script>
	<style type="text/css">
		.datagrid-row-selected{
			background: #FFFFFF;/*自定义颜色*/
		}
		.datagrid-row-over,
		.datagrid-header td.datagrid-header-over {
			background: #FFFFFF;
		}
	</style>
 </HEAD>
<BODY>
<div class="content_wrap">

	<div class="right">
		<!-- 查询结果列表 begin-->
			<table id="mydatagrid" class="easyui-datagrid">

            </table>
		<!-- 查询结果列表 end -->
	</div>
</div>
</BODY>
</HTML>
