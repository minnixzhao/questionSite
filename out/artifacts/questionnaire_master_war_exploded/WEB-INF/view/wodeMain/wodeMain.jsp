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
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>维护问卷</title>
    <!-- Bootstrap -->
    <link href="<%=basePath %>css/bootstrap-3.3.5-dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=basePath %>css/ityks.css" rel="stylesheet">
    <script src="<%=basePath %>js/jedate/jedate.js"></script>
</head>
<body style="background-color: #fefefe;">

<!-- 导航条 -->

<jsp:include page="../navigation.jsp"/>

<div class="container">
    <div class="row">
        <div class="col-lg-4 col-md-4 col-sm-12 " >
            <shiro:hasPermission name="/questionnaire/create">
                <button class="btn btn-primary"  data-toggle="collapse" data-target="#collapseNewQuestion" aria-expanded="false" aria-controls="collapseNewQuestion">新建</button>
            </shiro:hasPermission>
            <shiro:hasPermission name="/questionnaire/delete">
                <button class="btn btn-success" onclick="delCheckModal()">删除</button>
            </shiro:hasPermission>
            <shiro:hasPermission name="/questionnaire/search">
                <button class="btn btn-primary" data-toggle="collapse" data-target="#collapseFind" aria-expanded="false" aria-controls="collapseFind">搜索</button>
            </shiro:hasPermission>
        </div>
    </div>
    <!--问卷搜索-->
    <shiro:hasPermission name="/questionnaire/search">
        <div class="collapse" id="collapseFind">
            <div class="well" >
                <form action="<%=basePath%>main/searchMain" class="form-inline" method="get">
                    <label for="mainTitleSS">问卷标题：</label>
                    <input name="mainTitle" id="mainTitleSS" type="text" class="form-control" placeholder=""  />
                    <label for="mainCreatSS">创建时间：</label>
                    <input name="mainCreateTime" id="mainCreatSS" type="text" class="form-control" value="2019-01-01"  />
                    <label for="mainEndtimeSS">截止时间：</label>
                    <input name="mainEndTime" id="mainEndtimeSS" type="text" class="form-control" value="2020-01-01"  />
                    <button class="btn btn-primary" type="submit">搜索</button>
                </form>
                <script type="text/javascript">
                    jeDate({
                        dateCell:"#mainCreatSS",
                        format:"YYYY-MM-DD",
                        isinitVal:true,
                        isTime:false, //isClear:false,
                        minDate:"2000-01-01",
                        okfun:function(val){alert(val)}
                    })
                    jeDate({
                        dateCell:"#mainEndtimeSS",
                        format:"YYYY-MM-DD",
                        isinitVal:true,
                        isTime:false, //isClear:false,
                        minDate:"2000-01-01",
                        okfun:function(val){alert(val)}
                    })
                </script>
            </div>
        </div>
    </shiro:hasPermission>
    <!--新建问卷-->
    <shiro:hasPermission name="/questionnaire/create">
        <div class="collapse" id="collapseNewQuestion">
            <div class="well">
                <form  action="<%=basePath %>main/create" class="form-inline" method="post" id="newQuestion">
                    <div class="form-group">
                        <label for="mainTitle">问卷标题:</label>
                        <input type="text" class="form-control" id="mainTitle" name="mainTitle" placeholder="关于某某什么的问卷调查">
                    </div>
                    <div class="form-group date" id="datetimepicker">
                        <label for="mainEndtime">截止日期:</label>
                        <input type="text" class="form-control" id="mainEndTime" name="mainEndTime" readonly="readonly">
                    </div>
                    <script type="text/javascript">
                        jeDate({
                            dateCell:"#mainEndTime",
                            format:"YYYY-MM-DD",
                            isinitVal:true,
                            isTime:false, //isClear:false,
                            minDate:"<%=spdfDate%>",
                            okfun:function(val){alert(val)}
                        })
                    </script>
                    <button type="submit" onclick=" return newQuestion();" class="btn btn-info">保存</button>
                </form>
            </div>
        </div>
    </shiro:hasPermission>
    <form id="delCheckForm" method="post">
        <table class="table table-bordered table-hover">
            <tr class="danger">
                <th>
                    <h5 >序号:</h5>
                </th>
                <th>
                    <h5 >选择:</h5>
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
                <th>
                    <h5 >是否发布:</h5>
                </th>
                <th>
                    <h5 >发布人:</h5>
                </th>
                <th width="256px">
                    <h5 >操作:</h5>
                </th>
            </tr>
            <c:choose>
                <c:when test="${not empty requestScope.newPage.list }">
                    <c:forEach items="${requestScope.newPage.list }" var="item" varStatus="vs">
                        <tr class="success">
                            <td>
                                <span>${vs.index + 1 }</span>
                            </td>
                            <td>
                                <input type="checkbox" name="id" value="${item.mainId }">
                            </td>
                            <td>
                                <span>${item.mainTitle }</span>
                            </td>
                            <td>
                                <span><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${item.mainCreateTime }"/></span>
                            </td>
                            <td>
                                <span><fmt:formatDate pattern="yyyy-MM-dd" value="${item.mainEndTime }"/></span>
                            </td>
                            <td>
								<span>
									<c:if test="${item.mainIsuse eq 'y' }">
                                        已发布
                                    </c:if>
									<c:if test="${item.mainIsuse eq 'n' }">
                                        未发布
                                    </c:if>
								</span>
                            </td>
                            <td>
                                <span>${item.mainCreateUser }</span>
                            </td>
                            <td class="text-center">
                                <div class="input-group-btn" id="ssdiv">
                                    <shiro:hasPermission name="/questionnaire/delete">
                                        <button class="btn btn-primary" type="button" onclick="delModal('${item.mainId }')">删除</button>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/questionnaire/update">
                                        <a href="<%=basePath %>question/getMainQuestion/${item.mainId }" class="btn btn-info">编辑</a>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/questionnaire/add">
                                        <button type="button" class="btn btn-warning" onclick="actionModel('${item.mainId }')">发布</button>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/questionnaire/add">
                                        <button type="button" class="btn btn-warning" onclick="pauseModel('${item.mainId }')">停止</button>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/questionnaire/copy">
                                        <button type="button" class="btn btn-danger" onclick="copyQuestion('${item.mainId }')">复制</button>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="/result/see">
                                        <a class="btn btn-success" href="<%=basePath %>/main/seeResult/${item.mainId}" target="_blank" >查看结果</a>
                                    </shiro:hasPermission>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr class="warning">
                        <td colspan="8">
                            <span>暂无任何数据</span>
                        </td>
                    </tr>
                </c:otherwise>
            </c:choose>
            <!--分页-->
            <tr>
                <td colspan="8" align="center">
                    <label>第${requestScope.newPage.currentPage}/${requestScope.newPage.totalPage}页 共${requestScope.newPage.totalCount}条</label>
                    <c:if test="${requestScope.newPage.currentPage!=1}">
                        <a href="<%=basePath %>main/weihu/?currentPage=1">首页</a>
                        <a href="<%=basePath %>main/weihu/?currentPage=${requestScope.newPage.currentPage-1}">上一页</a>
                    </c:if>
                    <c:if test="${requestScope.newPage.currentPage!=requestScope.newPage.totalPage}">
                        <a href="<%=basePath %>main/weihu/?currentPage=${requestScope.newPage.currentPage+1}">下一页</a>
                    </c:if>
                    <a href="<%=basePath %>main/weihu/?currentPage=${requestScope.newPage.totalPage}">尾页</a> 跳转到:
                    <input type="text" style="width:30px" id="turnPage" />页
                    <input type="button" onclick="startTurn()" value="跳转" />
                </td>
            </tr>
            <!--分页-->
        </table>
    </form>
</div>
<!--删除一份问卷-->
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
                    <p>您确定要删除该条数据吗？</p>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button class="btn btn-primary" onclick="deleteMain()">确定</button>
                </div>
            </div>
        </div>
    </div>
    <input type="hidden" id="tempId" value="">
</div>
<!--批量删除-->
<div class="container">
    <div class="modal fade" id="delCheckModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span>
                        <span class="sr-only">Close</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>您确定要删除这些数据吗？</p>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button class="btn btn-primary" onclick="submitFormDel('#delCheckForm','<%=basePath%>main/delBatch')">确定</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!--发布问卷-->
<div class="container">
    <div class="modal fade" id="actionModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span>
                        <span class="sr-only">Close</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p id="actionModalText">确定要把这份问卷发布给小伙伴吗?</p>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button class="btn btn-primary" onclick="actionStart()">确定</button>
                </div>
            </div>
        </div>
    </div>
    <input type="hidden" id="tempActionMainId" />
</div>
<!--停止问卷-->
<div class="container">
    <div class="modal fade" id="pauseModel">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span>
                        <span class="sr-only">Close</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p id="pauseModelText">确定要停止发布问卷吗?</p>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button class="btn btn-primary" onclick="pause()">确定</button>
                </div>
            </div>
        </div>
    </div>
    <input type="hidden" id="temppauseMainId" />
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
                    <p id="alertOKText">成功</p>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!--尾部-->
<jsp:include page="../footer.jsp"/>
<script type="text/javascript">
    var basePath = '<%=basePath%>';
    var socketPath = '<%=socketPath%>';
</script>
<script src="<%=basePath %>css/bootstrap-3.3.5-dist/js/jquery-1.11.3.min.js"></script>
<script src="<%=basePath %>css/bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
<script src="<%=basePath %>js/question.js?v=5.1"></script>
<!--分页-->
<script type="text/javascript">




    function startTurn(){

        var turnPage=document.getElementById("turnPage").value;

        if(turnPage>${requestScope.newPage.totalPage}){

            alert("对不起已超过最大页数");

            return false;

        }

        var shref="<%=basePath %>main/weihu/?currentPage="+turnPage;

        window.location.href=shref;
    }
</script>
</body>
</html>