<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
  String webapp = request.getContextPath();
  /*String filename = java.net.URLDecoder.decode(request.getParameter("filename"), "UTF-8");
  filename = java.net.URLEncoder.encode(filename,"UTF-8");*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>预览</title>
  <script for="window" event="onload">
      //Checking if Acrobat Reader installed (IE4+)...
      //基本不会起作用。而且在IE之外的浏览器中被忽略执行。不想要，则可以删除。

  </script>
  <style>
    #IfAcrobat{margin-right: auto;margin-left: auto; width:976px;  }
  </style>

</head>
<body style="overflow:hidden;">

<!-- if javascript不可用，则提示： -->
<noscript>
  Cannot determine if you have Acrobat Reader (or the full Acrobat) installed
  <font size="-1">(because JavaScript is unavailable or turned off)</font>.
</noscript>

<!-- if 没有安装adobe reader，则提示： -->
<div id="IfNoAcrobat" style="display:none">
  你需要先安装Adobe Reader才能正常浏览文件，请点击<a href=<%=basePath%>/reader/AcroRdrDC_zh_CN.exe target="_blank">这里</a>下载Adobe Reader.
</div>

<!-- if adobe reader异常??则提示： -->
<object type="application/pdf" width=0 height=0 style="display:none">
  <div id="PDFNotKnown" style="display:none">&nbsp;</div>
</object>

<!-- 显示pdf 开始 -->
<div id=IfAcrobat>
  <!-- object为IE而写。最后一句的embed为chrome和ff而写 -->
  <object classid="clsid:CA8A9780-280D-11CF-A24D-444553540000" width="990" height="550" border="0" top="10" name="pdf">
    <param name="toolbar" value="false">
    <param name="_Version" value="65539">
    <param name="_ExtentX" value="20108">
    <param name="_ExtentY" value="10866">
    <param name="_StockProps" value="0">
    <param name="SRC" value="<%=basePath%>/pdfOfWordServlet?filename=<%=request.getParameter("filename")%>&fileType=<%=request.getParameter("fileType")%>&path=<%=request.getParameter("path")%>&ywzj=<%=request.getParameter("ywzj")%>"><!-- 你的pdf文件地址 for IE -->
    <embed name="plugin" src="<%=basePath%>/pdfOfWordServlet?filename=<%=request.getParameter("filename")%>&fileType=<%=request.getParameter("fileType")%>&path=<%=request.getParameter("path")%>&ywzj=<%=request.getParameter("ywzj")%>" type="application/pdf" width="990" height="700" top="100" border="0" toolbar="true" _version="65539" _extentx="20108" _extenty="10866" _stockprops="0"> <!-- 你的pdf文件地址 for chrome & ff -->

    <!--
    <p>It appears you don't have Adobe Reader or PDF support in this web
    browser. <a href="sample.pdf">Click here to download the PDF</a></p>
    -->
  </object>
</div>
</body>
</html>