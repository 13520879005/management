<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    String webapp = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + webapp + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>学术互动平台</title>
    <link rel="stylesheet" href="<%=basePath%>business/css/pintuer.css">
    <link rel="stylesheet" href="<%=basePath%>business/css/admin.css">
    <script src="<%=basePath%>business/js/jquery.js"></script>
</head>
<body style="background-color:#f2f9fd;">
<div class="header bg-main">
  <div class="logo margin-big-left fadein-top">
    <h1><img src="<%=basePath%>business/images/lt.png" class="radius-circle rotate-hover" height="50" alt="" />学术互动平台</h1>
  </div>
  <div class="head-l"><a class="button button-little bg-red" onclick="login_out();"><span class="icon-power-off"></span> 退出登录</a> </div>
</div>
<div class="leftnav">
  <div class="leftnav-title"><strong><span class="icon-list"></span>菜单列表</strong></div>
  <h2><span class="icon-user"></span>互动平台</h2>
  <ul style="display:block">
    <li><a href="<%=basePath%>paste/gotoPaste.xhtml" target="right"><span class="icon-caret-right"></span>问题搜索</a></li>
    <li><a href="<%=basePath%>paste/gotoPasteHis.xhtml" target="right"><span class="icon-caret-right"></span>发帖历史</a></li>
  </ul>
  <h2><span class="icon-wrench"></span>系统管理</h2>
  <ul>
      <c:choose>
          <c:when test="${sessionScope.userInfo.usertype == '0'}">
              <li><a href="<%=basePath%>user/userPass.xhtml" target="right"><span class="icon-caret-right"></span>账号设置</a></li>
              <li><a href="<%=basePath%>user/gotoUser.xhtml" target="right"><span class="icon-caret-right"></span>用户管理</a></li>
              <li><a href="<%=basePath%>depart/gotoDepart.xhtml" target="right"><span class="icon-caret-right"></span>学院管理</a></li>
              <li><a href="<%=basePath%>paste/gotoPasteAll.xhtml" target="right"><span class="icon-caret-right"></span>发帖管理</a></li>
              <li><a href="<%=basePath%>tag/gotoTag.xhtml" target="right"><span class="icon-caret-right"></span>课程管理</a></li>
          </c:when>
          <c:otherwise>
              <li><a href="<%=basePath%>user/userPass.xhtml" target="right"><span class="icon-caret-right"></span>账号设置</a></li>
          </c:otherwise>
      </c:choose>
  </ul>
</div>
<script type="text/javascript">
$(function(){
  $(".leftnav h2").click(function(){
	  $(this).next().slideToggle(200);	
	  $(this).toggleClass("on"); 
  })
  $(".leftnav ul li a").click(function(){
	    $("#a_leader_txt").text($(this).text());
  		$(".leftnav ul li a").removeClass("on");
		$(this).addClass("on");
  })
    $("#sy").click(function(){
        $("#a_leader_txt").text("首页");
    })
});
function login_out(){
    window.location.href ="<%=basePath%>login/logout.xhtml";
}
</script>
<ul class="bread">
  <li><a href="<%=basePath%>home/gotoRight.xhtml" target="right" id="sy" class="icon-home" style="font-weight: bold"> 首页</a></li>
    <span>当前位置：</span>
    <span><a href="##" id="a_leader_txt">首页</a></span>
</ul>
<div class="admin">
  <iframe scrolling="auto" rameborder="0" src="<%=basePath%>home/gotoRight.xhtml" name="right" width="100%" height="100%"></iframe>
</div>
</body>
</html>