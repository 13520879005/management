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
            var username = $("#username").val();
            var usertype = $("input[name='usertype']:checked").val();
            var userdepartment = $("#userdepartment option:selected").val();
            var usermajor = $("#usermajor option:selected").val();
            $('#mydatagrid').datagrid({
                url:'<%=basePath%>user/queryUserList.xhtml',
                queryParams: {username: username,usertype:usertype,userdepartment:userdepartment,usermajor:usermajor},
                title:'用户信息',
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
                columns:[[
                    {field:'username',title:'用户名称',width:200,halign:'center',align:'center'},
                    {field:'usertype',title:'用户类型',width:100,halign:'center',align:'center'},
                    {field:'userdepartment',title:'所属学院',width:200,halign:'center',align:'center'},
                    {field:'usermajor',title:'所属专业',width:200,halign:'center',align:'center'},
                    {field:'lastdate',title:'注册时间',width:100,halign:'center',align:'center'},
                    {field:'status',title:'审核状态',width:100,halign:'center',align:'center'},
                    {field:'userid',title:'操作',width:100,halign:'center',align:'center',
                        formatter: function (value, rowData, rowIndex) {
                        	if(rowData.status == '未审核'){
                                return "<span  style='color: blue' onclick=\"fn_edit('"+value+"')\" >审核</span>&nbsp;&nbsp;&nbsp;<span style='color: red' onclick=\"fn_delete('"+value+"')\" >删除</span>"
							}else{
                                return "<span  style='color: blue'></span>&nbsp;&nbsp;&nbsp;<span style='color: red' onclick=\"fn_delete('"+value+"')\" >删除</span>"
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
		function clearAll(){
			$("#form1").find("input[type=text],select,textarea").val("");
			var radios=$("input[type=radio]");
			for(var i=0;i<radios.length;i++){
				if(radios[i].checked){
					radios[i].checked=false;
				}
			}
		}

        function fn_choosezy(_value) {
            $.ajax({
                url:'<%=basePath%>login/chooseZy.xhtml?departcode='+_value,
                type:'GET',
                dataType: "json",
                data:$("#form1").serialize(),
                async: false,
                success:function (result) {
                    var zhuanyList = result;
                    var selectObj = $("#usermajor");//抓到select对象
                    //删除下面的option(从第一个开始都删除)
                    $("#usermajor>option").slice(1).remove();

                    for(var i=0;i<zhuanyList.length;i++)
                    {
                        //创建Option对象
                        var option = $("<option value='"+zhuanyList[i].departcode+"'>"+zhuanyList[i].departname+"</option>");
                        //放入select
                        selectObj.append(option);
                    }
                },
                error:function (result) {
                    layer.alert('操作失败，请联系管理员！', {icon: 6});
                }
            });
        }

        function fn_delete(_val){
            layer.confirm('确认要删除？', {
                btn: ['确认', '取消'] //可以无限个按钮
            }, function(index, layero){
                $.ajax({
                    url:'<%=basePath%>user/deleteUser.xhtml?userid='+_val,
                    type:'GET',
                    dataType: "json",
                    async: true,
                    success:function (result) {
                        if(result == 'succeed'){
                            layer.alert('操作成功！', {icon: 6},function(){
                                window.location.href = "<%=basePath%>user/gotoUser.xhtml";
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

        function fn_edit(_val){
            layer.confirm('审核是否通过？', {
                btn: ['通过', '未通过'] //可以无限个按钮
            }, function(index, layero){
                $.ajax({
                    url:'<%=basePath%>user/updateUser.xhtml?userid='+_val+"&status=1",
                    type:'GET',
                    dataType: "json",
                    async: true,
                    success:function (result) {
                        if(result == 'succeed'){
                            layer.alert('操作成功！', {icon: 6},function(){
                                window.location.href = "<%=basePath%>user/gotoUser.xhtml";
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
                $.ajax({
                    url:'<%=basePath%>user/updateUser.xhtml?userid='+_val+"&status=3",
                    type:'GET',
                    dataType: "json",
                    async: true,
                    success:function (result) {
                        if(result == 'succeed'){
                            layer.alert('操作成功！', {icon: 6},function(){
                                window.location.href = "<%=basePath%>user/gotoUser.xhtml";
							});
                        }else{
                            layer.alert('操作失败，请联系管理员！', {icon: 6});
                        }
                    },
                    error:function (result) {
                        layer.alert('操作失败，请联系管理员！', {icon: 6});
                    }
                });
            });
        }
	</script>
 </HEAD>
<BODY>
<div class="content_wrap">

	<div class="right">
		<form id="form1" accept-charset="UTF-8">
			<table class="table-query" >
				<tbody>
				<tr>
					<th style="font-weight:bold;font-size: 12px;">姓名：</th>
					<td>
						<input name="username" id="username"  type="text" maxlength="50"/>
					</td>
					<th style="font-weight:bold;font-size: 12px;">学院：</th>
					<td>
						<select  name="userdepartment" id="userdepartment" onchange="fn_choosezy(this.value);" >
							<option value="">请选择</option>
							<c:forEach items="${xueyList}" var="xuey" varStatus="i">
								<option value="${xuey.departcode}">${xuey.departname}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th style="font-weight:bold;font-size: 12px;">类型：</th>
					<td>
						<input name="usertype" value="2" type="radio" maxlength="50"/>学生
						<input name="usertype" value="1" type="radio" maxlength="50"/>教师
					</td>
					<th style="font-weight:bold;font-size: 12px;">专业：</th>
					<td>
						<select name="usermajor" id="usermajor"  >
							<option value="">请选择</option>
						</select>
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
		</form>
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
