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
<script src="<%=basePath%>business/js/pintuer.js"></script>
  <script type="text/javascript">
  </script>
</head>
<body>
<div class="panel admin-panel">
  <div class="panel-head"><strong><span class="icon-key"></span>账号设置</strong></div>
  <div class="body-content">
    <form method="post" class="form-x" action="<%=basePath%>user/updatePass.xhtml" id="form1">
      <input type="hidden" name="userid" value="${user.userid}" size="50" />
      <div class="form-group">
        <div class="label">
          <label for="sitename">用户名称：</label>
        </div>
        <div class="field">
          <label style="line-height:33px;">
            <input type="text" class="input w50" readonly name="username" value="${user.username}" size="50" />
          </label>
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label for="sitename">新密码：</label>
        </div>
        <div class="field">
          <input type="password" class="input w50"  name="passwordshow" size="50" placeholder="请输入新密码" data-validate="required:请输入新密码" />
        </div>
      </div>
      <div class="form-group">
        <div class="label">
          <label for="sitename">确认新密码：</label>
        </div>
        <div class="field">
          <input type="password" class="input w50" name="renewpass" size="50" placeholder="请再次输入新密码" data-validate="required:请再次输入新密码,repeat#passwordshow:两次输入的密码不一致" />
        </div>
      </div>
      
      <div class="form-group">
        <div class="label">
          <label></label>
        </div>
        <div class="field">
          <button class="button bg-main icon-check-square-o" type="submit"> 提交</button>
        </div>
      </div>      
    </form>
  </div>
</div>
</body></html>