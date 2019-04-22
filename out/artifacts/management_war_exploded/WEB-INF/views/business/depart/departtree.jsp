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
	<link rel="stylesheet" href="<%=basePath%>business/css/tree/demo.css" type="text/css">
	<link rel="stylesheet" href="<%=basePath%>business/css/tree/zTreeStyle/zTreeStyle.css" type="text/css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>business/easyui/themes/default/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>business/easyui/themes/icon.css"/>
    <script type="text/javascript" src="<%=basePath%>business/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>business/js/jquery.ztree.core.js"></script>
    <script type="text/javascript" src="<%=basePath%>business/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="<%=basePath%>business/easyui/jquery.easyui.min.js"></script>
	<script src="<%=basePath%>business/layer/layer.js"></script>
	<script type="text/javascript">
		var curMenu = null, zTree_Menu = null;
		var setting = {
			view: {
				showLine: false,
				selectedMulti: false,
				dblClickExpand: false
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				onNodeCreated: this.onNodeCreated,
				beforeClick: this.beforeClick,
				onClick: this.onClick
			}
		};

		var zNodes =${departList};

		function beforeClick(treeId, node) {
			if (node.isParent) {
				if (node.level === 0) {
					var pNode = curMenu;
					while (pNode && pNode.level !==0) {
						pNode = pNode.getParentNode();
					}
					if (pNode !== node) {
						var a = $("#" + pNode.tId + "_a");
						a.removeClass("cur");
						zTree_Menu.expandNode(pNode, false);
					}
					a = $("#" + node.tId + "_a");
					a.addClass("cur");

					var isOpen = false;
					for (var i=0,l=node.children.length; i<l; i++) {
						if(node.children[i].open) {
							isOpen = true;
							break;
						}
					}
					if (isOpen) {
						zTree_Menu.expandNode(node, true);
						curMenu = node;
					} else {
						zTree_Menu.expandNode(node.children[0].isParent?node.children[0]:node, true);
						curMenu = node.children[0];
					}
				} else {
					zTree_Menu.expandNode(node);
				}
			}
			//!node.isParent
			return true;
		}
		function onClick(e, treeId, node) {
		    if(node.id.length < 5){
				$("#departparentcode").val(node.id);
                $("#departtitle").val(node.name);
                doquery();
                $(".panel-title").html(node.name);
			}
		}

		$(document).ready(function(){
			$.fn.zTree.init($("#treeDemo"), setting, zNodes);
			zTree_Menu = $.fn.zTree.getZTreeObj("treeDemo");
			curMenu = zTree_Menu.getNodes()[0].children[0].children[0];
			zTree_Menu.selectNode(curMenu);
			var a = $("#" + zTree_Menu.getNodes()[0].tId + "_a");
			a.addClass("cur");
		});

        $(function(){
            doquery();
        })
		function doquery(){
             var departname = $("#departname").val();
             var departparentcode = $("#departparentcode").val();
             var ttval = "学院名称";
             if (departparentcode.length > 2){
                 ttval = "专业名称"
			 }
            $('#mydatagrid').datagrid({
                url:'<%=basePath%>depart/queryDepart.xhtml',
                queryParams: {departname: departname,departparentcode:departparentcode},
                title:'学院信息维护',
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
                        adddepart();
                    }
                }],
                columns:[[
                    {field:'departname',title:ttval,width:600,halign:'center',align:'center'},
                    {field:'departcode',title:'操作',width:220,halign:'center',align:'center',
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
            $(".panel-title").html($("#departtitle").val());
		}

		function adddepart(){
            var departparentcode = $("#departparentcode").val();
            layer.open({
                id:112,
                type: 2,
                title: ['添加', 'font-size:14px;font-weight:bold;'],
                shadeClose: false,
                shade: [0.8, '#393D49'],
                maxmin: true, //开启最大化最小化按钮
                area: ['420px', '250px'],
                maxmin:false,
                content:"<%=basePath%>depart/addDepart.xhtml?departparentcode="+departparentcode,
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
                content:"<%=basePath%>depart/editDepart.xhtml?departcode="+_val,
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
                    url:'<%=basePath%>depart/deleteDepart.xhtml?departcode='+_val,
                    type:'GET',
                    dataType: "json",
                    async: true,
                    success:function (result) {
                        if(result == 'succeed'){
                            layer.alert('操作成功！', {icon: 6},function(){
                                window.location.href = "<%=basePath%>depart/gotoDepart.xhtml";
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
            $("#departname").val("");
		}
	</script>
	<style type="text/css">
	.ztree li a.level0 {width:200px;height: 20px; text-align: center; display:block; background-color: #b5cfd9; border:1px #90a3ff solid;}
	.ztree li a.level0.cur {background-color: #0B61A4; }
	.ztree li a.level0 span {display: block; color: white; padding-top:3px; font-size:12px; font-weight: bold;word-spacing: 2px;}
	.ztree li a.level0 span.button {	float:right; margin-left: 10px; visibility: visible;display:none;}
	.ztree li span.button.switch.level0 {display:none;}
	</style>
 </HEAD>
<BODY>
<div class="content_wrap">
	<div class="zTreeDemoBackground left">
		<ul id="treeDemo" class="ztree"></ul>
	</div>
	<div class="right">
		<form id="form1" accept-charset="UTF-8">
			<table class="table-query" >
				<tbody>
				<tr>
					<th style="font-weight:bold;font-size: 12px;">学院/专业名称：</th>
					<td>
						<input name="departtitle" id="departtitle"  type="hidden" value="学院信息维护" maxlength="50"/>
						<input name="departparentcode" id="departparentcode"  type="hidden" value="00" maxlength="50"/>
						<input name="departname" id="departname"  type="text" maxlength="50"/>
					</td>
					<td >
						<input type="button" class="btn btn-info" value="查　询" onclick="doquery()"/>
						<input type="button" class="btn btn-info" value="重　置" onclick="clearAll()"/>
					</td>
				</tr>
				</tbody>
			</table>
		</form>
		<br>
	</div>
	<div class="right">
		<!-- 查询结果列表 begin-->
			<table id="mydatagrid" class="easyui-datagrid" >

            </table>
		<!-- 查询结果列表 end -->
	</div>
</div>
</BODY>
</HTML>
