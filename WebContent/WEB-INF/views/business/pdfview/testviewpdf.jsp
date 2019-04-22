<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
    String webapp = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + webapp + "/";
%>
<html>
<head>
    <title>Title</title>
    <script src="<%=basePath%>iframe/js/jquery-1.9.1.js"></script>
    <script>
        function fnview(fname,tp){
            var fname=encodeURI(encodeURI(fname));
            var urls = "<%=basePath%>webuploader/pdf_nwzs.jsp?filename="+fname+"&fileType="+tp+"&path=wordfile.jsscpath&ywzj=";
            window.open(urls, "_black" ,"height=500,width=800,scrollbars=no,location=no");
        }
    </script>
</head>
<body>
    <table >
        <tr>
            <td>
                <%--fj.url 附件路径如：D:\upload\photoPhoto\images\2019\4\22\201904222536.doc fj.type 附件类型pdf或者word--%>
                <a onclick='fnview("${fn:replace(fj.url,'\\','\\\\')}","${fj.type}")'>测试查看pdf</a>
            </td>
        </tr>
    </table>
</body>
</html>
