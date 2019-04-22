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
<title>添加</title>
<link rel="stylesheet" href="<%=basePath%>business/css/style.css">
<script src="<%=basePath%>business/js/jquery-1.11.3.js"></script>
<script src="<%=basePath%>business/validationEngine/jquery.validate.min.js" type="text/javascript"></script>
<link href="<%=basePath%>business/validationEngine/validationEngine.jquery.css" rel="stylesheet" type="text/css">
<script src="<%=basePath%>business/validationEngine/jquery.validationEngine.min.js" type="text/javascript" charset="utf-8"></script>
<script src="<%=basePath%>business/validationEngine/jquery.validationEngine-zh_CN.js" type="text/javascript" charset="utf-8"></script>
<script src="<%=basePath%>business/validationEngine/messages_zh.js"></script>
<link href="<%=basePath%>business/css/labelauty.css" rel="stylesheet" />
<script src="<%=basePath%>business/js/labelauty.js"></script>
<script src="<%=basePath%>business/layer/layer.js"></script>
<script type="text/javascript">

    function fn_submit(){
        var _flag = $("#form1").validationEngine("validate");
        if (_flag === false) {
            return false;
        }
        $.ajax({
            url:'<%=basePath%>depart/inertDepart.xhtml',
            type:'POST',
            dataType: "json",
            data:$("#form1").serialize(),
            async: false,
            success:function (result) {
                if(result == 'succeed'){
                    layer.alert('操作成功！', {icon: 6},function(){
                        parent.location.reload();
                        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                        parent.layer.close(index);
                    });
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
    <form id="form1">
      <input type="hidden" name="departparentcode"  value="${departMap.departparentcode}">
      <input type="hidden" name="departlevel"  value="${departMap.departlevel}">
    <table width="100%"  border="0" cellspacing="0" cellpadding="14">
      <br>
      <c:choose>
        <c:when test="${departMap.departparentcode == '00'}">
          <tr>
            <td class="td_s"><span style="color:#F00">*</span>学院名称：</td>
            <td class="td_i" colspan="3">
              <div>
                <input class="inputstyle validate[required]" type="text" name="departname"  maxlength="100">
              </div>
            </td>
          </tr>
        </c:when>
        <c:otherwise>
          <tr>
            <td class="td_s"><span style="color:#F00">*</span>专业名称：</td>
            <td class="td_i" colspan="3">
              <div>
                <input class="inputstyle validate[required]" type="text"  name="departname"  maxlength="100">
              </div>
            </td>
          </tr>
        </c:otherwise>
      </c:choose>
      <tr>
        <td class="td_i" colspan="4">
          <div style="text-align: center;">
            <button type="button" style="background-color:#0058af;color:#fff;border:0px;width:100px;height:35px;cursor:pointer;border-radius:5px;" onclick="fn_submit();">保存</button>
          </div>
        </td>
      </tr>
    </table>
    </form>
  </div>
</body>
</html>