<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<html>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<head>
    <title>问卷首页</title>
    <link href="<%=basePath %>css/bootstrap-3.3.5-dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=basePath %>css/ityks.css" rel="stylesheet">
</head>
<body style="background-color:#f2f5f7">
<!--导航栏-->
<jsp:include page="navigation.jsp"/>
<!--轮播-->
<div class="container">
    <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
        <!-- Indicators -->
        <ol class="carousel-indicators">
            <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
            <li data-target="#carousel-example-generic" data-slide-to="1"></li>
        </ol>

        <div class="carousel-inner" role="listbox">
            <div class="item active">
                <img src="<%=basePath %>image/focus01.jpg" alt="...">
                <div class="carousel-caption">

                </div>
            </div>
            <div class="item">
                <img src="<%=basePath %>image/focus02.jpg" alt="...">
                <div class="carousel-caption">

                </div>
            </div>

        </div>

        <!-- Controls -->
        <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
</div>
<!-- 问卷调查 -->
<div class="container" style="padding-bottom: 70px;">
    <div class="row">
        <div  class="col-lg-12 col-md-12 col-sm-12">
            <table class="table table-bordered table-hover">
                <tr class="danger">
                    <th>
                        <h5 >序号:</h5>
                    </th>
                    <th>
                        <h5 >问卷标题:</h5>
                    </th>
                    <th>
                        <h5 >创建时间:</h5>
                    </th>
                    <th>
                        <h5 >截止时间:</h5>
                    </th>
                    <th width="256px">
                        <h5 >操作:</h5>
                    </th>
                </tr>


                <c:choose>
                    <c:when test="${not empty requestScope.newPage.list}">
                        <c:forEach items="${requestScope.newPage.list}" var="item" varStatus="vs">
                            <tr class="success">
                                <td>
                                    <span>${vs.index }</span>
                                </td>
                                <td>
                                    <span><a href="<%=basePath %>main/see/${item.mainId}" target="_blank">${item.mainTitle}</a></span>
                                </td>
                                <td>
                                    <span><fmt:formatDate pattern="yyyy-MM-dd" value="${item.mainCreateTime}"/></span>
                                </td>
                                <td>
                                    <span><fmt:formatDate pattern="yyyy-MM-dd" value="${item.mainEndTime}"/></span>
                                </td>
                                <td class="text-center">
                                    <div class="input-group-btn" id="ssdiv">
                                        <shiro:hasPermission name="/questionnaire/vote">
                                            <a class="btn btn-info" href="<%=basePath %>main/see/${item.mainId}" target="_blank" >参与投票</a>
                                        </shiro:hasPermission>
                                        <shiro:hasPermission name="/result/see">
                                            <a class="btn btn-success" href="<%=basePath %>main/seeResult/${item.mainId}" target="_blank" >查看结果</a>
                                        </shiro:hasPermission>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                </c:choose>
                <!--分页-->
                <tr>
                    <td colspan="6" align="center">
                <label>第${requestScope.newPage.currentPage}/${requestScope.newPage.totalPage}页 共${requestScope.newPage.totalCount}条</label>
                <c:if test="${requestScope.newPage.currentPage!=1}">
                <a href="<%=basePath %>main/?currentPage=1">首页</a>
                <a href="<%=basePath %>main/?currentPage=${requestScope.newPage.currentPage-1}" onclick="return checkFirst()">上一页</a>
                </c:if>
                <c:if test="${requestScope.newPage.currentPage!=requestScope.newPage.totalPage}">
                <a href="<%=basePath %>main/?currentPage=${requestScope.newPage.currentPage+1}" onclick="return checkNext()">下一页</a>
                </c:if>
                <a href="<%=basePath %>main/?currentPage=${requestScope.newPage.totalPage}">尾页</a> 跳转到:
                <input type="text" style="width:30px" id="turnPage" />页
                <input type="button" onclick="startTurn()" value="跳转" />
                    </td>
                </tr>
                <!--分页-->
            </table>
        </div>

    </div>
</div>
<!--加载尾部-->
<jsp:include page="footer.jsp"/>

<script src="<%=basePath %>css/bootstrap-3.3.5-dist/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="<%=basePath %>css/bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
<!--自定义js-->
<script type="text/javascript" src="<%=basePath %>js/question.js?v=3.1"></script>
<script type="text/javascript" src="<%=basePath %>js/home.js"></script>
</body>
<script type="text/javascript">


    function startTurn(){

        var turnPage=document.getElementById("turnPage").value;

        if(turnPage>${requestScope.newPage.totalPage}){

            alert("对不起已超过最大页数");

            return false;

        }

        var shref="<%=basePath %>main/?currentPage="+turnPage;

        window.location.href=shref;
    }
</script>
</html>
