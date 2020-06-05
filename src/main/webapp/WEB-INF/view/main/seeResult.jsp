<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
  <head>

    <title>查看问卷结果</title>
    <link href="<%=basePath %>css/bootstrap-3.3.5-dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=basePath %>css/ityks.css" rel="stylesheet">

  </head>
<body style="background-color: #fefefe;">
	<!--导航栏-->
	<jsp:include page="../navigation.jsp"/>

	<div class="container">
		<table class="table">
			<tr class="danger">
				<th>
					<h5 style="padding-left: 40px">${requestScope.map.main.mainTitle}</h5>
				</th>
			</tr>
			<c:choose>
				<c:when test="${not empty requestScope.map.main.questionList }">
					<c:forEach items="${requestScope.map.main.questionList }" var="question" varStatus="vs">
						<tr class="info">
							<th >
								<h4 style="padding-left: 40px"><small>Question ${vs.index+1 }：${question.quesTitle }</small></h4>
							</th>
						</tr>
						<tr class="success">
							<c:choose>
								<c:when test="${not empty question.answerList }">
									<td ><%//答案开始咯 %>
									<br />
									<c:forEach items="${question.answerList}" var="answer" varStatus="vs">
											<c:if test="${answer.answerType eq 'n'}"><%//这里是文字类答案 %>
												<blockquote>
													<p style="padding-left: 40px">总共<b>${answer.answerValue }</b>个人选择</p>
													<footer style="padding-left: 40px"><b>${answer.answerDesType }</b></footer>
												</blockquote>
											</c:if>
											
											<c:if test="${answer.answerType eq 'y'}"><%//这里是图片类答案 %>
												<blockquote>
													<p style="padding-left: 40px">总共<b>${answer.answerValue }</b>个人选择</p>
													<footer style="padding-left: 40px"><a src="<%=basePath %>${answer.answerText }" >${answer.answerDesType }</a></footer>
												</blockquote>
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
	
	<div class="container">
		<table class="table">
			<c:choose>
				<c:when test="${not empty requestScope.messageList }">
					<c:forEach items="${requestScope.messageList}" var="item" varStatus="vs">
						<c:if test="${vs.index/2 != 0  }">
							<tr class="success">
								<td>
									<dl>
										<dt>${item.messageCreater }</dt>
										<dd>${item.messageText }</dd>
									</dl>
								</td>
							</tr>
						</c:if>
						
						<c:if test="${vs.index/2 == 0  }">
							<tr class="info">
								<td>
									<dl>
										<dt>${item.messageCreater }</dt>
										<dd>${item.messageText }</dd>
									</dl>
								</td>
							</tr>
						</c:if>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr class="danger">
						<td>
							<dl>
								<dt>信息：</dt>
								<dd>暂无任何数据</dd>
							</dl>
						</td>
					</tr>
				</c:otherwise>
			</c:choose>

		</table>
	</div>

	<!--加载尾部-->
	<jsp:include page="../footer.jsp"/>

	<script type="text/javascript">
		var basePath = '<%=basePath%>';
	</script>
    <script src="<%=basePath %>css/bootstrap-3.3.5-dist/js/jquery-1.11.3.min.js"></script>
    <script src="<%=basePath %>css/bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
</body>
</html>