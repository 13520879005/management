<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    String webapp = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + webapp + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>登录</title>
    <link rel="stylesheet" href="<%=basePath%>business/login/css/login.css">
    <script src="<%=basePath%>business/js/jquery.js"></script>
    <script src="<%=basePath%>business/layer/layer.js"></script>
    <script src="<%=basePath%>business/validationEngine/jquery.validate.min.js" type="text/javascript"></script>
    <link href="<%=basePath%>business/validationEngine/validationEngine.jquery.css" rel="stylesheet" type="text/css">
    <script src="<%=basePath%>business/validationEngine/jquery.validationEngine.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=basePath%>business/validationEngine/jquery.validationEngine-zh_CN.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=basePath%>business/validationEngine/messages_zh.js"></script>
    <script src="<%=basePath%>business/layer/layer.js"></script>
    <script type="text/javascript">
        if (window != top){
            top.location.href = "<%=basePath%>";
        }
        function fn_reg(){
            layer.open({
                id:112,
                type: 2,
                title: ['注册', 'font-size:14px;font-weight:bold;'],
                shadeClose: false,
                shade: [0.8, '#393D49'],
                maxmin: true, //开启最大化最小化按钮
                area: ['600px', '550px'],
                maxmin:false,
                content:"<%=basePath%>login/regUser.xhtml",
                cancel: function(index, layero){
                    layer.close(index);//需要手动关闭窗口
                },
                end:function(index, layero){
                    layer.close(index);//需要手动关闭窗口
                }
            });
        }

        function fn_login(){
            var _flag = $("#form1").validationEngine("validate");
            if (_flag === false) {
                return false;
            }
            $.ajax({
                url:'<%=basePath%>login/gotoLogin.xhtml',
                type:'POST',
                dataType: "json",
                data:$("#form1").serialize(),
                async: false,
                success:function (result) {
                    if(result == 'nouser'){
                        layer.alert('用户名或密码错误！', {icon: 6});
                    }else if(result == 'waituser'){
                        layer.alert('管理员审核中，请耐心等待！', {icon: 6});
                    }else if(result == 'wxuser'){
                        layer.alert('用户无效！', {icon: 6});
                    }else if(result == 'wtguser'){
                        layer.alert('未通过管理员审核！', {icon: 6});
                    }else if(result == 'succeed'){
                        window.location.href = "<%=basePath%>home/gotoHome.xhtml";
                    }else{
                        layer.alert('操作失败，请联系管理员！', {icon: 6});
                    }
                },
                error:function (result) {
                    layer.alert('操作失败，请联系管理员！', {icon: 6});
                }
            });
        }
        document.onkeydown = fnKeydown;
        function fnKeydown(){
            if(event.keyCode==13)fn_login();
        }
    </script>
    <style type="text/css">
        .formError{
            left: 70px  !important;
        }
    </style>
</head>
<body>
<div class="login">
    <div class="login_title">
        <p>学术互动平台</p>
    </div>
    <div class="login_main">
        <div class="main_left"></div>
        <div class="main_right">
            <div class="right_title">用户登录</div>
            <form id="form1">
                <div class="username">
                    <img src="<%=basePath%>business/login/images/username.png" alt="">
                    <input class="validate[required]" name="useraccount" type="text" placeholder="请输入用户名">
                </div>
                <div class="password">
                    <img src="<%=basePath%>business/login/images/password.png" alt="">
                    <input class="validate[required]" name="userpassword" type="password" placeholder="请输入密码">
                </div>
                <%--<div class="code">
                    <img src="<%=basePath%>business/login/images/code.png" alt="">
                    <input type="text" placeholder="请输入验证码">
                    <div class="code_img">
                        <img src="<%=basePath%>business/login/images/code_img.png" alt="">
                    </div>
                </div>--%>
                <div class="yes_login" style="margin:10px 0px 0px 0px;"><a href="javascript:void(0);" onclick="fn_login();">登&nbsp;&nbsp;&nbsp;&nbsp;录</a></div>
            </form>
            <br>
            <div class="code" style="margin:20px 0px 0px 249px;">
                <a class="zc" href="javascript:void(0);" onclick="fn_reg();">立即注册</a>
            </div>
        </div>
    </div>
    <div class="login_footer">
       <%-- <p>建议浏览器：IE9以上、Firefox v22</p>--%>
    </div>
</div>

</body>
</html>