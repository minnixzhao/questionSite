<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <title>添加角色</title>
    <!-- Bootstrap -->
    <link href="<%=basePath %>css/bootstrap-3.3.5-dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=basePath %>css/ityks.css" rel="stylesheet">

    <link href="<%=basePath %>css/content.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="<%=basePath %>js/jquery-1.11.3.min.js"></script>
    <c:if test="${success =='OK'}">
        <script type="text/javascript">
            $(function (){
                alert ('${msg}');
            })
            parent.window.location.href="<%=basePath%>role/role";
        </script>
    </c:if>
    <c:if test="${success == 'NO'}">
        <script type="text/javascript">
            $(function (){
                alert ('${msg}');
            })
        </script>
    </c:if>
</head>
<body>

<div class="container">
    <form action="<%=basePath %>role/addRole" class="form-horizontal" method="post">
        <div class="form-group">
            <%--@declare id="permissionname"--%><label for="permissionName" class="contro-label">角色名称:</label>
            <input class="form-control" value="" id="roleName" name="roleName" type="text"/>
        </div>
        <div class="form-group">
            <%--@declare id="permissionmenuname"--%><label for="permissionMenuName" class="contro-label">角色描述:</label>
            <input class="form-control" value="" id="roleDes" name="roleDes" type="text"/>
        </div>

        <p class="text-center"><button type="submit" id="submit" class="btn btn-primary">提交</button></p>

    </form>
</div>
<script src="<%=basePath %>css/bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $("#submit").click(function(){
            if($("#roleName").val()==''||$("#roleName").val()==null){
                alert("角色名称不能为空！")
                return false;
            }
            if($("#roleDes").val()==''||$("#roleDes").val()==null){
                alert("角色描述不能为空！")
                return false;
            }
        });
    });
</script>
</body>
</html>