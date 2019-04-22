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
<title>注册</title>
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
    $(document).ready(function () {
        //参数{input类名，选择类型(单选or多选)}
        $(".rdolist").labelauty("rdolist", "rdo","<%=webapp%>");
        $(".chklist").labelauty("chklist", "check","<%=webapp%>");
        $("#bqxz").hide();
        $("#tsym").hide();
    });

    function fn_bqxs(_tag){
        $("#bqxz").show();
        if(_tag == '1'){
            $("#xsnr").html("课程：");
        }else{
            $("#xsnr").html("标签：");
        }
    }
    function fn_submit(){
        var _flag = $("#form1").validationEngine("validate");
        if (_flag === false) {
            return false;
        }
        if($("input[name='usertype']:checked").size() == 0){
            layer.alert('请选择类型！', {icon: 6});
            return false;
        }
        if($("input[name='usertag']:checked").size() == 0){
            layer.alert('请选择标签！', {icon: 6});
            return false;
        }
        $.ajax({
            url:'<%=basePath%>login/gotoReg.xhtml',
            type:'POST',
            dataType: "json",
            data:$("#form1").serialize(),
            async: false,
            success:function (result) {
                if(result == 'succeed'){
                    $("#zcym").hide();
                    $("#tsym").show();
                    var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                    window.setTimeout(close, 5000);
                    function close(){
                        parent.layer.close(index);
                    }
                }else{
                    alert("操作失败，请联系管理员！");
                }
            },
            error:function (result) {
                alert("操作失败，请联系管理员！");
            }
        });
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
                alert("操作失败，请联系管理员！");
            }
        });
    }
</script>
</head>
<body>
  <div class="page-table" id="zcym">
    <form id="form1">
    <table width="100%"  border="0" cellspacing="0" cellpadding="14">
      <br>
      <tr>
        <td class="td_s"><span style="color:#F00">*</span>账号：</td>
        <td class="td_i" colspan="3">
          <div>
            <input class="inputstyle validate[required]" type="text" id="useraccount" name="useraccount"  maxlength="100">
          </div>
        </td>
      </tr>

      <tr>
        <td class="td_s"><span style="color:#F00">*</span>密码：</td>
        <td class="td_i" colspan="3">
          <div>
            <input class="inputstyle validate[required] custom[onlyLetterNumber]" type="text" id="passwordshow" name="passwordshow"  maxlength="20">
          </div>
        </td>
      </tr>

      <tr>
        <td class="td_s"><span style="color:#F00">*</span>姓名：</td>
        <td class="td_i" colspan="3">
          <div>
            <input class="inputstyle validate[required]" type="text" id="username" name="username"  maxlength="100">
          </div>
        </td>
      </tr>

      <tr>
        <td class="td_s"><span style="color:#F00">*</span>类型：</td>
        <td class="td_i" colspan="3">
          <div>
            <input class="rdolist validate[required]" id="isstudent" type="radio" name="usertype" value="2" >
            <label class="rdobox" onclick="fn_bqxs('2');">
              <span class="check-image"></span>
              <span class="radiobox-content">学生</span>
            </label>
            <input class="rdolist validate[required]" id="isteacher" type="radio" name="usertype" value="1" >
            <label class="rdobox" onclick="fn_bqxs('1');">
              <span class="check-image"></span>
              <span class="radiobox-content">教师</span>
            </label>
          </div>
        </td>
      </tr>
      <tr id="bqxz">
        <td class="td_s" style="width: 26%;"><span style="color:#F00">*</span><span id="xsnr">标签：</span></td>
        <td class="td_i" colspan="3">
          <div class="fuxuan">
            <c:forEach items="${tagList}" var="tag" varStatus="i">
              <input type="checkbox" name="usertag" class="chklist validate[required]" value="${tag.code}"/>
              <label class="chkbox">
                <span class="check-image"></span>
                <span class="radiobox-content">${tag.name}</span>
              </label>
              <c:if test="${(i.index+1)%3 == 0}">
                  <br>
              </c:if>
            </c:forEach>
          </div>
        </td>
      </tr>
      <tr>
        <td class="td_s"><span style="color:#F00">*</span>所属院系：</td>
        <td class="td_i" colspan="3">
          <div>
            <select class="inputstyle validate[required]" style="width: 50%;"  name="userdepartment" id="userdepartment" onchange="fn_choosezy(this.value);" >
              <option value="">请选择</option>
              <c:forEach items="${xueyList}" var="xuey" varStatus="i">
                <option value="${xuey.departcode}">${xuey.departname}</option>
              </c:forEach>
            </select>
            <br>
            <br>
            <select class="inputstyle validate[]" style="width: 50%;" name="usermajor" id="usermajor"  >
              <option value="">请选择</option>
            </select>
          </div>
        </td>
      </tr>

      <tr>
        <td class="td_i" colspan="4">
          <div style="text-align: center;">
            <button type="button" style="background-color:#0058af;color:#fff;border:0px;width:100px;height:35px;cursor:pointer;border-radius:5px;" onclick="fn_submit();">立即注册</button>
          </div>
        </td>
      </tr>
    </table>
    </form>
  </div>
  <div class="page-table" id="tsym">
      <div style="margin: 0px 24%;">
        <img src="<%=basePath%>business/images/ddsh.png">
      </div>
      <div style="margin: 0px 32%;">
        <span style="color: #0058af;">注册成功，等待管理员审核！</span>
      </div>
  </div>
</body>
</html>