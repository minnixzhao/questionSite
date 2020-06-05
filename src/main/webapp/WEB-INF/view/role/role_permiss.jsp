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
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="renderer" content="webkit">
    <title>家政</title>
    <link href="<%=basePath %>css/bootstrap-3.3.5-dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=basePath %>js/ztree/zTree_v3-master/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="<%=basePath %>js/jquery-1.11.3.min.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/ztree/zTree_v3-master/js/jquery.ztree.core.min.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/ztree/zTree_v3-master/js/jquery.ztree.excheck.min.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/ztree/zTree_v3-master/js/jquery.ztree.exedit.min.js"></script>
    <script type="text/javascript">
        var setting = {
            async: {
                enable: true,
                url:"<%=basePath%>role/getTreeCheck.do?roleId=${requestScope.entity.roleId}"
            },data: {
                simpleData: {
                    enable:true,
                    idKey: "id",
                    pIdKey: "pId1",
                    rootPId: 1,
                },

            },check: {
                enable: true
            },
            callback: {
                beforeClick: function(treeId, treeNode) { //单击树节点并，true表示被选中
                    return true;
                }
            }
        };

        $(document).ready(function(){
            $.fn.zTree.init($("#tree"), setting);
        });

        function tijiao(){
            var zTree = $.fn.zTree.getZTreeObj("tree");
            var nodes = zTree.getCheckedNodes(true);     //获取输入框被勾选 或 未勾选的节点集合。[setting.check.enable = true 时有效]
            var parm = "";   //被选中树节点的id
            for (var i = 1;i<nodes.length;i++){
                parm+=nodes[i].id;
                if (nodes.length-i>1){
                    parm+=',';
                }
            }
            $.ajax({
                type: 'POST',
                url: "<%=basePath%>role/updateRolePermiss",
                data: {
                    roleId:${requestScope.entity.roleId},   //角色Id
                    parm:parm,                                   //被选中的权限id组字符串
                    roleName:'${requestScope.entity.roleName}'   //角色名称
                },
                success: function(data){
                    if(data.success){
                        alert ("保存成功！")
                    }else{
                        alert ("保存失败！")
                    }
                },
                dataType: 'json'
            });
        }
    </script>
</head>
<body>
<div class="container">
    <ul id="tree" class="ztree" ></ul>

    <p class="text-center"><a href="javascript:void(0)" class="btn btn-primary" onclick="tijiao()">提交</a></p>
</div>
<script src="<%=basePath %>css/bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
</body>
</html>