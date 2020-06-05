<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <title>角色管理</title>
    <!-- Bootstrap -->
    <link href="<%=basePath %>css/bootstrap-3.3.5-dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=basePath %>css/ityks.css" rel="stylesheet">

    <link rel="stylesheet" href="<%=basePath %>js/ztree/zTree_v3-master/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="<%=basePath %>js/jquery-1.11.3.min.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/ztree/zTree_v3-master/js/jquery.ztree.core.min.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/ztree/zTree_v3-master/js/jquery.ztree.excheck.min.js"></script>
    <script type="text/javascript" src="<%=basePath %>js/ztree/zTree_v3-master/js/jquery.ztree.exedit.min.js"></script>
    <script type="text/javascript">
        var setting = {
            async: {
                enable: true,
                type:"get",
                url:"<%=basePath%>role/getRoles"
            },data: {
                simpleData: {
                    enable:true,
                    idKey: "roleId", //节点数据中保存唯一标识的属性名称 默认值："id"
                    pIdKey: "pId",//节点数据中保存其父节点唯一标识的属性名称.enable = true 时生效，默认值："pId"
                    rootPId: 0, //用于修正根节点父节点数据，即 pIdKey 指定的属性值，enable = true 时生效，默认值：null
                 },
                 key: {
                    name: "roleDes" //zTree 节点数据保存节点名称的属性名称。默认值："name"
                 }
            },
            callback: {
                beforeClick: function(treeId, treeNode) {//用于捕获单击节点之前的事件回调函数，并且根据返回值确定是否允许单击操作默认值：null
                    var zTree = $.fn.zTree.getZTreeObj("tree");
                   $("#testIframe").attr("src","<%=basePath%>role/editView?roleDes="+treeNode.roleDes+"&roleId="+treeNode.roleId+"&roleName="+treeNode.roleName);
                    return true;
                },
                onRightClick: OnRightClick
            }
        };
        //单击右键菜单
        function OnRightClick(event, treeId, treeNode) {//用于捕获 zTree 上鼠标右键点击之后的事件回调函数
            if (!treeNode && event.target.tagName.toLowerCase() != "button" && $(event.target).parents("a").length == 0) {
                zTree.cancelSelectedNode();
                showRMenu("root", event.clientX, event.clientY);
            } else if (treeNode && !treeNode.noR) {
                zTree.selectNode(treeNode);
                showRMenu("node", event.clientX, event.clientY);
            }
        }
        //显示右键菜单
        function showRMenu(type, x, y) {
            $("#rMenu ul").show();
            if (type=="root") {
                $("#m_del").hide();
                $("#m_check").hide();
                $("#m_unCheck").hide();
            } else {
                $("#m_del").show();
                $("#m_check").show();
                $("#m_unCheck").show();
            }
            rMenu.css({"top":y+"px", "left":x+"px", "visibility":"visible"});
            $("body").bind("mousedown", onBodyMouseDown);
        }

        function hideRMenu() {
            if (rMenu) rMenu.css({"visibility": "hidden"});
            $("body").unbind("mousedown", onBodyMouseDown);
        }

        function onBodyMouseDown(event){
            if (!(event.target.id == "rMenu" || $(event.target).parents("#rMenu").length>0)) {
                rMenu.css({"visibility" : "hidden"});
            }
        }

        $(document).ready(function(){
            $.fn.zTree.init($("#tree"), setting);//zTree 初始化方法，创建 zTree
            zTree = $.fn.zTree.getZTreeObj("tree"); //所有回调函数中全都会返回 treeId 属性，使用此方法获取需要进行操作的 zTree对象
            rMenu = $("#rMenu");
        });
        //增加角色树节点
        function addTreeNode(){
            if (zTree.getSelectedNodes()[0]) {
                var node = zTree.getSelectedNodes()[0];  //获取 zTree 当前被选中的节点数据集合
                $("#testIframe").attr("src","<%=basePath%>role/addRoleView");
            } else {
                //zTree.addNodes(null, newNode);
            }
        }
        //修改角色树节点
        function editTreeNode(){
            if (zTree.getSelectedNodes()[0]) {
                var node = zTree.getSelectedNodes()[0];  //获取 zTree 当前被选中的节点数据集合
                $("#testIframe").attr("src","<%=basePath%>role/updateRoleView?roleId="+node.roleId+"&pId="+node.pId+"&roleName="+node.roleName+"&roleDes="+node.roleDes);
            } else {
                //zTree.addNodes(null, newNode);
            }
        }
        //删除角色树节点
        function removeTreeNode(){
            var node = zTree.getSelectedNodes()[0];   //获取 zTree 当前被选中的节点数据集合

            $.ajax({
                url:"<%=basePath%>role/deleteRoleView/"+node.roleId,
                type:'DELETE',
                success:function (data){
                    if (data.success){
                        alert ("删除成功");
                        window.location.reload();
                    }else{
                        alert ('删除失败');
                    }
                }
            });
        }

    </script>

    <style type="text/css">
        div#rMenu {position:absolute; visibility:hidden; top:0; text-align: left;padding: 1px;}
        div#rMenu ul li{
            margin: 1px 0;
            padding: 0 1px;
            cursor: pointer;
            list-style: none outside none;
            background-color: #DFDFDF;
        }
    </style>
</head>
<body>
<!--导航条 -->
<jsp:include page="../navigation.jsp"/>
<!--ztree树-->
<div class="container">
    <table border="0" height="100%" align="left">
        <tr>
            <td width="260px" align="left" valign="top" style="BORDER-RIGHT: #999999 1px dashed">
                <ul id="tree" class="ztree" style="width:260px; overflow:auto;"></ul>
            </td>
            <td width="770px" align="left" valign="top">
                <iframe id="testIframe" name="testIframe" frameborder="0" scrolling="AUTO" width="100%"  height="600px" SRC="<%=basePath%>treeIframe.jsp"></iframe>
            </td>
        </tr>
    </table>

    <div id="rMenu">
        <ul>
            <li id="m_add" onclick="addTreeNode();">增加</li>
            <li id="m_edit" onclick="editTreeNode();">修改</li>
            <li id="m_del" onclick="removeTreeNode();">删除</li>
        </ul>
    </div>
</div>

<jsp:include page="../footer.jsp"/>

<script type="text/javascript">
    var basePath = '<%=basePath%>';
</script>
<script src="<%=basePath %>css/bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
</body>
</html>