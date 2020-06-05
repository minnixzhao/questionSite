<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
java.util.Date nowDate = new java.util.Date();
java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
String spdfDate = sdf.format(nowDate);


%>
<!DOCTYPE html>
<html>
  <head>

    <title>编辑问卷</title>
    <!-- Bootstrap -->
    <link href="<%=basePath %>css/bootstrap-3.3.5-dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=basePath %>css/ityks.css" rel="stylesheet">
    <script src="<%=basePath %>js/jedate/jedate.js"></script>
  </head>
<body style="background-color: #fefefe;">
<!--导航栏-->
<jsp:include page="../navigation.jsp"/>
	<div class="container">
		<a class="btn btn-primary" href="javascript:void(0)" onclick="openEditModel()" >增加问题</a>
		<a class="btn btn-success" href="<%=basePath %>main/weihu" target="_self" >返回</a>
		<table class="table">
			<tr class="danger">
				<th>
					<div class="row">
						<div class="col-xs-6">
							<h5 style="padding-left: 40px" id="h5maintitle">${requestScope.map.main.mainTitle}</h5>
							<form class="form-inline" id="editform" style="display: none">
							<div class="form-group">
								<label for="mainTitleInput">问卷标题:</label>
								<input class="form-control" id="mainTitleInput" name="mainTitleInput" type="text" value="${requestScope.map.main.mainTitle}"  />
							</div>
							<div class="form-group">
								<label for="mainEndtimeInput">截止时间:</label>
								<input class="form-control" id="mainEndtimeInput" name="mainEndTime" type="text" readonly="readonly" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${requestScope.map.main.mainEndTime }"/>' />
							</div>
							</form>
							<script type="text/javascript">
								jeDate({
									dateCell:"#mainEndtimeInput",
									format:"YYYY-MM-DD",
									isinitVal:true,
									isTime:false, //isClear:false,
									minDate:"<%=spdfDate%>",
									okfun:function(val){alert(val)}
								})
							</script>
						</div>
						<div class="col-xs-6">
							<p class="text-right">
							<a href="javascript:void(0)" class="btn btn-info" onclick="showEdit()" id="btnxg" >修改</a>
							<a href="javascript:void(0)" class="btn btn-success" style="display:none; " id="btnqx" onclick="cancelEdit()">取消</a>
							<a href="javascript:void(0)" class="btn btn-warning" style="display:none; " id="btnbc" onclick="editQuestionMainTitle('${requestScope.map.main.mainId}')">保存</a>
							</p>
						</div>
					</div>
				</th>
			</tr>
			<c:choose>
				<c:when test="${not empty requestScope.map.main.questionList }">
					<c:forEach items="${requestScope.map.main.questionList }" var="question" varStatus="vs">
						<tr class="info">
							<th >
								<div class="row">
									<div class="col-xs-6">
										<h4 style="padding-left: 40px"><small>Question ${vs.index+1 }：${question.quesTitle }</small></h4>
									</div>
									<div class="col-xs-6 text-right">

										<a href="javascript:void(0)" class="btn btn-warning" onclick="openEditModelxg('${question.quesId}')">修改</a>

										<button type="button" class="btn btn-info" onclick="delQuestionModal('${question.quesId }')">删除</button>
									</div>
								</div>
							</th>
						</tr>
						<tr class="success">
							<c:choose>
								<c:when test="${not empty question.answerList }">
									<td style="padding-left: 40px"><%//答案 %>
									<br />
									<c:forEach items="${question.answerList}" var="answer" varStatus="vs">
											<c:if test="${question.quesType eq 'radio'}"><%//这里是单选 %>
													<label>
														<input type="radio" name="${question.quesId }" value="${answer.answerId }"><span style="padding-right: 40px">${answer.answerDesType }</span>
													</label>
											</c:if>
											<c:if test="${question.quesType eq 'check'}"><%//这里是多选 %>
													<label>
														<input type="checkbox" name="${question.quesId }" value="${answer.answerId }"><span style="padding-right: 40px">${answer.answerDesType }</span>
													</label>
										    </c:if>
									</c:forEach>
										<br />
									</td>
								</c:when>
								<c:otherwise>
									<td style="padding-left: 40px">
										<span>暂无任何数据</span>
									</td>
								</c:otherwise>
							</c:choose>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr class="warning">
						<td>
							<span>暂无任何数据</span>
						</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</table>
	</div>
	<!--删除问卷模态框-->
	<div class="container">
		<div class="modal fade" id="delQuestionModal">
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
						<button class="btn btn-primary" onclick="deleteQuestion()">确定</button>
					</div>
				</div>
			</div>
		</div>
		<input type="hidden" id="tempQuestionId" value="">
	</div>
	<!--问卷标题修改成功提示-->
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

<!--增加问题答案模态框-->
<div class="container">
	<div class="modal fade" id="editModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button class="btn btn-success" type="button" onclick="addAnswer()" >增加选项</button>
					<button class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span>
						<span class="sr-only">Close</span>
					</button>
				</div>
				<div class="modal-body" id="editModalBody">
					<form id="editAnswer" action="<%=basePath %>question/addQuestionAndAnswer" method="post"  >
						<input type="hidden" id="mainIId" name="mainId" value="${requestScope.map.main.mainId}">
						<div class="form-group">
							<label>问题:</label>
							<input type="text" class="form-control" name="questionTitle" />
						</div>
						<div class="form-group">
							<label for="questionType">问题类型：</label>
							<select class="form-control" name="questionType" id="questionType">
								<option selected="selected" value="radio">单选</option>
								<option value="check">多选</option>
							</select>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button class="btn btn-default" data-dismiss="modal">关闭</button>
					<button class="btn btn-primary" type="button" onclick="submitFormById('editAnswer')">确定</button>
				</div>
			</div>
		</div>
	</div>
</div>

<!--修改问题答案模态框-->
<div class="container">
	<div class="modal fade" id="editModalxg">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button class="btn btn-success" type="button" onclick="addAnswerxg()" >增加答案</button>
					<button class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span>
						<span class="sr-only">Close</span>
					</button>
				</div>
				<div class="modal-body" id="editModalBodyxg">
					<form id="editAnswerxg" action="<%=basePath %>question/editQuestion" method="post"  >
						<input type="hidden" id="mainId" name="mainId" value="${requestScope.map.main.mainId}">
						<input type="hidden" id="questionIdxg" name="questionId" value="">
						<div class="form-group">
							<label>问题:</label>
							<input type="text" class="form-control" id="questionTitlexg" name="questionTitle" />
						</div>
						<div class="form-group">
							<label for="questionType">问题类型：</label>
							<select class="form-control" name="questionType" id="questionTypexg">
								<option value="radio">单选</option>
								<option value="check">多选</option>
							</select>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button class="btn btn-default" data-dismiss="modal">关闭</button>
					<button class="btn btn-primary" type="button" onclick="submitFormById('editAnswerxg')">确定</button>
				</div>
			</div>
		</div>
	</div>
</div>

<!--加载尾部-->
	<jsp:include page="../footer.jsp"/>
    <script type="text/javascript">
		var basePath = '<%=basePath%>';
	</script>
    <script src="<%=basePath %>css/bootstrap-3.3.5-dist/js/jquery-1.11.3.min.js"></script>
    <script src="<%=basePath %>css/bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
    <script src="<%=basePath %>js/guid.js"></script>
    <script src="<%=basePath %>js/question.js?v=3.0"></script>
</body>
</html>