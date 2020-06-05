<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    String socketPath = request.getServerName()+":"+request.getServerPort()+path+"/";
    java.util.Date nowDate = new java.util.Date();
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
    String spdfDate = sdf.format(nowDate);
%>
<!DOCTYPE html>
<html>
<head>

    <title>没有权限</title>
    <!-- Bootstrap -->
    <link href="<%=basePath %>css/bootstrap-3.3.5-dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=basePath %>css/ityks.css" rel="stylesheet">
    <script src="<%=basePath %>js/jedate/jedate.js"></script>

</head>
<body style="background-color: #fefefe;">
<!-- 这是导航条 -->
<jsp:include page="../navigation.jsp"/>

<div class="container">
    你好！你没有该<strong><font size="5">操作权限</font> </strong>！页面将于3秒关闭，如未自动关闭请手动点击<a href="javascript:void(0)" onclick="closepage()">这里</a>>.
</div>
<!--加载尾部-->

<jsp:include page="../footer.jsp"/>
<script type="text/javascript">
    var basePath = '<%=basePath%>';
    var socketPath = '<%=socketPath%>';
</script>
<script src="<%=basePath %>css/bootstrap-3.3.5-dist/js/jquery-1.11.3.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="<%=basePath %>css/bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
<script src="<%=basePath %>js/question.js?v=3.1"></script>
<script type="text/javascript">
    setTimeout("closepage()",5000);
</script>
</body>
</html>