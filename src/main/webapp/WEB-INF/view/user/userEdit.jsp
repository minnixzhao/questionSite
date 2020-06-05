<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    String socketPath = request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <title>用户设置</title>
    <!-- Bootstrap -->
    <link href="<%=basePath %>css/bootstrap-3.3.5-dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=basePath %>css/ityks.css" rel="stylesheet">

</head>
<body style="background-color: #fefefe;">
<!--导航条 -->
<jsp:include page="../navigation.jsp"/>

<div class="container">

    <form id="delCheckForm" method="post">
        <table class="table table-bordered table-hover">
            <tr class="danger">
                <th>
                    <h5 >序号:</h5>
                </th>
                <th>
                    <h5 >用户名:</h5>
                </th>
                <th>
                    <h5 >电子邮件:</h5>
                </th>
                <th>
                    <h5 >姓名:</h5>
                </th>
                <th width="256px">
                    <h5 >操作:</h5>
                </th>
            </tr>
            <c:choose>
                <c:when test="${not empty requestScope.newPage.list }">
                    <c:forEach items="${requestScope.newPage.list}" var="item" varStatus="vs">
                        <tr class="success">
                            <td>
                                <span>${vs.index+1}</span>
                            </td>
                            <td>
                                <span>${item.loginName }</span>
                            </td>
                            <td>
                                <span>${item.email }</span>
                            </td>
                            <td>
                                <span>${item.userName }</span>
                            </td>
                            <td class="text-center">
                                <div class="input-group-btn" id="ssdiv">
                                    <input type="hidden" id="temoLoginId" >
                                    <shiro:hasPermission name="/user/delete">
                                        <button class="btn btn-warning" type="button" onclick="delModal('${item.userId}')">删除</button>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/role/distribute">
                                        <button type="button" class="btn btn-success dropdown-toggle" style="width: 70px;" data-toggle="dropdown" id="s_${item.userId }">
                                            <c:choose>
                                                <c:when test="${not empty requestScope.roleList }">
                                                    <c:forEach items="${requestScope.roleList }" var="temp" varStatus="vs">
                                                    <c:forEach items="${item.roleList }" var="temp1" >
                                                    <c:if test="${temp.roleName eq temp1.roleName}">
                                                            ${temp.roleDes}
                                                        </c:if>
                                                    </c:forEach>
                                                    </c:forEach>
                                                </c:when>
                                            </c:choose>
                                        </button>
                                        <button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown" >
                                            <span class="caret"></span>
                                        </button>
                                        <ul class="dropdown-menu">
                                            <c:choose>
                                                <c:when test="${not empty requestScope.roleList }">
                                                    <c:forEach items="${requestScope.roleList }" var="temp" varStatus="vs">
                                                        <c:if test="${temp.roleId ne 0}">
                                                            <li><a href="javascript:void(0)" onclick="setRole('${temp.roleId }','${temp.roleDes }','${item.userId}','${item.loginName}')">${temp.roleDes }</a></li>
                                                            <li class="divider"></li>
                                                        </c:if>
                                                    </c:forEach>
                                                </c:when>
                                            </c:choose>
                                        </ul>
                                    </shiro:hasPermission>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
            </c:choose>


                <!--分页-->
            <tr>
                <td colspan="5" align="center">
                    <label>第${requestScope.newPage.currentPage}/${requestScope.newPage.totalPage}页 共${requestScope.newPage.totalCount}条</label>
                    <c:if test="${requestScope.newPage.currentPage!=1}">
                        <a href="<%=basePath%>user/userEdit?currentPage=1">首页</a>
                        <a href="<%=basePath%>user/userEdit?currentPage=${requestScope.newPage.currentPage-1}">上一页</a>
                    </c:if>
                    <c:if test="${requestScope.newPage.currentPage!=requestScope.newPage.totalPage}">
                        <a href="<%=basePath%>user/userEdit?currentPage=${requestScope.newPage.currentPage+1}">下一页</a>
                    </c:if>
                    <a href="<%=basePath%>user/userEdit?currentPage=${requestScope.newPage.totalPage}">尾页</a> 跳转到:
                    <input type="text" style="width:30px" id="turnPage" />页
                    <input type="button" onclick="startTurn()" value="跳转" />
                </td>
            </tr>
            <!--分页-->

        </table>
    </form>
</div>

<div class="container">
    <div class="modal fade" id="delModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span>
                        <span class="sr-only">Close</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>您确定要删除这个用户吗？</p>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button class="btn btn-primary" onclick="deleteUser()">确定</button>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="container">
    <div class="modal fade" id="alertOK">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span>
                        <span class="sr-only">Close</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p id="alertOKText">权限更改成功</p>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp"/>

<script type="text/javascript">
    var basePath = '<%=basePath%>';
    var socketPath = '<%=socketPath%>';
</script>
<script src="<%=basePath %>css/bootstrap-3.3.5-dist/js/jquery-1.11.3.min.js"></script>
<script src="<%=basePath %>css/bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
<script src="<%=basePath %>js/user.js?v=0.5"></script>
<!--分页-->
<script type="text/javascript">




    function startTurn(){

        var turnPage=document.getElementById("turnPage").value;

        if(turnPage>${requestScope.newPage.totalPage}){

            alert("对不起已超过最大页数");

            return false;

        }

        var shref="<%=basePath%>main/weihu/?currentPage="+turnPage;

        window.location.href=shref;
    }
</script>
</body>
</html>