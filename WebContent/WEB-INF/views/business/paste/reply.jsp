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
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <meta http-equiv="Pragma" CONTENT="no-cache">
    <meta http-equiv="Cache-Control" CONTENT="no-cache">
    <meta http-equiv="Expires" CONTENT="0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>学术互动平台</title>
    <link rel="stylesheet" href="<%=basePath%>business/css/style.css">
    <script src="<%=basePath%>business/js/jquery-1.11.3.js"></script>
    <script src="<%=basePath%>business/validationEngine/jquery.validate.min.js" type="text/javascript"></script>
    <link href="<%=basePath%>business/validationEngine/validationEngine.jquery.css" rel="stylesheet" type="text/css">
    <script src="<%=basePath%>business/validationEngine/jquery.validationEngine.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=basePath%>business/validationEngine/jquery.validationEngine-zh_CN.js" type="text/javascript" charset="utf-8"></script>
    <script src="<%=basePath%>business/validationEngine/messages_zh.js"></script>
    <link href="<%=basePath%>business/css/labelauty.css" rel="stylesheet" />
    <link href="<%=basePath%>business/css/praise/css/style.css" rel="stylesheet" />
    <script src="<%=basePath%>business/js/labelauty.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){

            $('body').on("click",'.heart',function(){
                var replyid = $(this).attr("replyid");
                var A=$(this).attr("id");
                var B=A.split("like");
                var messageID=B[1];
                var C=parseInt($("#likeCount"+messageID).html());
                $(this).css("background-position","")
                var D=$(this).attr("rel");

                if(D === 'like') {
                    $("#likeCount"+messageID).html(C+1);
                    $(this).addClass("heartAnimation").attr("rel","unlike");
                    $(this).css("background-position","right");

                    $.ajax({
                        url:'<%=basePath%>paste/updateReplys.xhtml?praise=add&replyid='+replyid,
                        type:'POST',
                        dataType: "json",
                        async: true,
                        success:function (result) {
                        },
                        error:function (result) {
                        }
                    });
                }
                else{
                    $("#likeCount"+messageID).html(C-1);
                    $(this).removeClass("heartAnimation").attr("rel","like");
                    $(this).css("background-position","left");
                    $.ajax({
                        url:'<%=basePath%>paste/updateReplys.xhtml?praise=del&replyid='+replyid,
                        type:'POST',
                        dataType: "json",
                        async: true,
                        success:function (result) {
                        },
                        error:function (result) {
                        }
                    });
                }
            });

        });


        function fn_submit(){
            var _flag = $("#form1").validationEngine("validate");
            if (_flag === false) {
                return false;
            }

            $.ajax({
                url:'<%=basePath%>paste/insertReplys.xhtml',
                type:'POST',
                dataType: "json",
                data:$("#form1").serialize(),
                async: false,
                success:function (result) {
                    if(result == 'succeed'){
                        //window.opener.location.reload();
                        window.close();
                    }else{
                        layer.alert('操作失败，请联系管理员！', {icon: 6});
                    }
                },
                error:function (result) {
                    layer.alert('操作失败，请联系管理员！', {icon: 6});
                }
            });
        }

    </script>
</head>
<body>
<div class="page-table" >
    <table width="100%"  border="0" cellspacing="0" cellpadding="14">
        <br>
        <tr>
            <td class="td_s">${paMap.username}</td>
            <td class="td_i">
                <div>
                    <p style="font-weight: bold;">${paMap.pastes}</p>
                </div>
            </td>
        </tr>
        <c:forEach items="${rpList}" var="rp" varStatus="i">
            <tr>
                <td class="td_s">${rp.username}（${rp.replyusertype}）</td>
                <td class="td_i">
                    <div class="feed" id="feed${i.index+1}">
                        <p>${rp.replys}</p>
                        <div class="heart" id="like${i.index+1}" rel="like" replyid ="${rp.replyid}"></div> <div style="margin: 33px 0px;" class="likeCount" id="likeCount${i.index+1}">${rp.praise}</div>
                    </div>
                </td>
            </tr>
        </c:forEach>
    </table>
    <form id="form1">
        <input type="hidden" name="pasteid" value="${paMap.pasteid}">
        <table width="100%"  border="0" cellspacing="0" cellpadding="14">
            <tr>
                <td class="td_i">
                    <textarea class="textareastyle validate[required]" name="replys" style="width:100%;height: 100px;"></textarea>
                </td>
            </tr>
            <tr>
                <td class="td_i">
                    <div style="text-align: center;">
                        <button type="button" style="background-color:#0058af;color:#fff;border:0px;width:100px;height:35px;cursor:pointer;border-radius:5px;" onclick="fn_submit();">提交回复</button>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>