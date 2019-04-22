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
        /*$(function(){
            doquery();
        })*/
        document.onkeydown = fnKeydown;
        function fnKeydown(){
            if(event.keyCode==13)doquery();
        }
		function doquery(){
            var pastes = $("#pastes").val();
            if($.trim(pastes) == ''){
                return false;
			}
            $('#mydatagrid').datagrid({
                url:'<%=basePath%>paste/queryPaste.xhtml',
                queryParams: {pastes: pastes},
                iconCls:'icon-edit',//图标
				width:650,
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
                rownumbers:false,//行号
                onLoadSuccess: function (data) {
                    if (data.total == 0) {
                        //添加一个新数据行，第一列的值为你需要的提示信息，然后将其他列合并到第一列来，注意修改colspan参数为你columns配置的总列数
                        $(this).datagrid('appendRow', { pastes: '无记录' }).datagrid('mergeCells', { index: 0, field: 'pastes' })
                        //隐藏分页导航条，这个需要熟悉datagrid的html结构，直接用jquery操作DOM对象，easyui datagrid没有提供相关方法隐藏导航条
                        $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
                    }
                    //如果通过调用reload方法重新加载数据有数据时显示出分页导航容器
                    else $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
                },
                columns:[[
                    {field:'pastes',title:'',width:200,halign:'left',align:'left',
                        formatter: function (value, rowData, rowIndex) {
                        if(value=="无记录"){
                            return "<div style='text-align:center;color:red'>没有相关记录！</div>";
						}else{
                            return "<div style='margin: 5px;'><a style='cursor:hand;color: blue;font-size: 16px;font-weight: bold;text-decoration:underline;width:500px;display:block;overflow:hidden;word-break:keep-all;white-space:nowrap;text-overflow:ellipsis;'  onclick=\"fn_edit('"+rowData.pasteid+"')\" >"+value+"</a></div><div style='margin: 2px;'> <textarea cols='60' rows='2' readonly style='border:none;overflow:hidden; resize:none;word-wrap : break-word; '>"+rowData.replys+"</textarea></div>"
						}
                        }
					}
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

        function addprase(){
            layer.open({
                id:112,
                type: 2,
                title: ['发帖', 'font-size:14px;font-weight:bold;'],
                shadeClose: false,
                shade: [0.8, '#393D49'],
                maxmin: true, //开启最大化最小化按钮
                area: ['500px', '500px'],
                maxmin:false,
                content:"<%=basePath%>paste/addPaste.xhtml",
                cancel: function(index, layero){
                    layer.close(index);//需要手动关闭窗口
                },
                end:function(index, layero){
                    layer.close(index);//需要手动关闭窗口
                }
            });
        }

        function fn_edit(_val){
			var url = "<%=basePath%>paste/gotoReply.xhtml?pasteid="+_val;
			window.open(url,"_blank");
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
			<table class="table-query" >
				<tbody>
				<br>
				<tr>
					<td>
						<input style="width: 50%;height: 36px;margin:0 25px" name="pastes" id="pastes"  type="text" maxlength="200"/>
						<span><a onclick="doquery();"><img style="margin: -10px -10px;" src="<%=basePath%>business/images/sous.png" title="查询" ></a></span>
						<span><a onclick="addprase();"><img style="margin: -10px 70px;" src="<%=basePath%>business/images/fatie.png"  title="发帖" ></a></span>
					</td>
				</tr>
				</tbody>
			</table>
		<br>
	</div>
	<div class="right">
		<!-- 查询结果列表 begin-->
			<table id="mydatagrid" class="easyui-datagrid">

            </table>
		<!-- 查询结果列表 end -->
	</div>
</div>
</BODY>
</HTML>
