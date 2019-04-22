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
            var tagname = $("#tagname").val();
            $('#mydatagrid').datagrid({
                url:'<%=basePath%>tag/queryTag.xhtml',
                queryParams: {tagname: tagname},
                iconCls:'icon-edit',//图标
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
                toolbar: [{
                    text: '添加',
                    iconCls: 'icon-add',
                    handler: function() {
                        addTags();
                    }
                }],
                columns:[[
                    {field:'tagname',title:'课程名称',width:200,halign:'center',align:'center'},
                    {field:'tagid',title:'操作',width:220,halign:'center',align:'center',
                        formatter: function (value, rowData, rowIndex) {
                            return "<span  style='color: blue' onclick=\"fn_edit('"+value+"')\" >编辑</span>&nbsp;&nbsp;&nbsp;<span style='color: red' onclick=\"fn_delete('"+value+"')\" >删除</span>"
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

        function addTags(){
            layer.open({
                id:112,
                type: 2,
                title: ['添加', 'font-size:14px;font-weight:bold;'],
                shadeClose: false,
                shade: [0.8, '#393D49'],
                maxmin: true, //开启最大化最小化按钮
                area: ['350px', '300px'],
                maxmin:false,
                content:"<%=basePath%>tag/addTag.xhtml",
                cancel: function(index, layero){
                    layer.close(index);//需要手动关闭窗口
                },
                end:function(index, layero){
                    layer.close(index);//需要手动关闭窗口
                }
            });
        }

        function fn_edit(_val){
            layer.open({
                id:112,
                type: 2,
                title: ['编辑', 'font-size:14px;font-weight:bold;'],
                shadeClose: false,
                shade: [0.8, '#393D49'],
                maxmin: true, //开启最大化最小化按钮
                area: ['420px', '250px'],
                maxmin:false,
                content:"<%=basePath%>tag/editTag.xhtml?tagid="+_val,
                cancel: function(index, layero){
                    layer.close(index);//需要手动关闭窗口
                },
                end:function(index, layero){
                    layer.close(index);//需要手动关闭窗口
                }
            });
        }
        function fn_delete(_val){
            layer.confirm('确认要删除？', {
                btn: ['确认', '取消'] //可以无限个按钮
            }, function(index, layero){
                $.ajax({
                    url:'<%=basePath%>tag/deleteTag.xhtml?tagid='+_val,
                    type:'GET',
                    dataType: "json",
                    async: true,
                    success:function (result) {
                        if(result == 'succeed'){
                            layer.alert('操作成功！', {icon: 6},function(){
                                window.location.href = "<%=basePath%>tag/gotoTag.xhtml";
							});
                        }else{
                            layer.alert('操作失败，请联系管理员！', {icon: 6});
                        }
                    },
                    error:function (result) {
                        layer.alert('操作失败，请联系管理员！', {icon: 6});
                    }
                });
            }, function(index){
            });
        }
        function clearAll(){
            $("#form1").find("input[type=text],select,textarea").val("");
            var radios=$("input[type=radio]");
            for(var i=0;i<radios.length;i++){
                if(radios[i].checked){
                    radios[i].checked=false;
                }
            }
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
				<tr>
					<th style="font-weight:bold;font-size: 12px;">标签名称：</th>
					<td>
						<input name="tagname" id="tagname"  type="text" maxlength="50"/>
					</td>
				</tr>
				</tbody>
				<tfoot>
				<tr>
					<td colspan="6">
						<input type="button" class="btn btn-info" value="查　询" onclick="doquery()"/>
						<input type="button" class="btn btn-info" value="重　置" onclick="clearAll()"/>
					</td>
				</tr>
				</tfoot>
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
