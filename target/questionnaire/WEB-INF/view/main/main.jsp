<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    String socketPath = request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">

    <title>问卷调查</title>
    <!-- Bootstrap -->
    <link href="<%=basePath %>css/bootstrap-3.3.5-dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=basePath %>css/ityks.css" rel="stylesheet">
    <script>
    </script>
</head>
<body style="background-color: #fefefe;">
<!-- 这是导航条 -->
<jsp:include page="../navigation.jsp"/>
<div class="container" style="padding-bottom: 70px;">

    <form id="actionSub" action="<%=basePath %>main/actionSub" method="post">
        <table class="table">
            <tr class="danger">
                <th>
                    <div class="row">
                        <div class="col-xs-6">
                            <h4 style="padding-left: 40px">${requestScope.map.main.mainTitle}</h4>
                        </div>
                        <div class="col-xs-2">
                            <h4><cite title="发布人">${requestScope.map.main.mainCreateUser}</cite></h4>
                        </div>
                        <div class="col-xs-2">
                            <h4><cite title="发布时间"><fmt:formatDate pattern="yyyy-MM-dd" value="${requestScope.map.main.mainCreateTime }"/></cite></h4>
                        </div>
                        <div class="col-xs-2">
                            <h5><cite title="统计">总人数/答题人数/百分比</cite></h5>
                        </div>
                    </div>
                </th>
            </tr>
            <c:choose>
              <c:when test="${not empty requestScope.map.main.questionList }">
                <c:forEach items="${requestScope.map.main.questionList}" var="question" varStatus="vs">
                    <tr class="info">
                        <th >
                            <div class="row">
                                <div class="col-xs-12">
                                    <h4 style="padding-left: 40px"><small class="question">问题 ${vs.index+1 }：${question.quesTitle }[${question.quesType }]</small></h4>
                                </div>
                            </div>
                        </th>
                    </tr>
                       <tr class="success a">
                           <td style="padding-left: 40px">
                               <br />
                        <c:choose>
                            <c:when test="${not empty question.answerList }">
                                    <c:forEach items="${question.answerList}" var="answer" varStatus="vs">
                                        <c:if test="${question.quesType eq 'radio'||question.quesType eq 'score'}"><%//单选 %>
                                                <div class="row">
                                                    <div class="col-xs-5">
                                                        <label>
                                                            <input type="radio" name="${question.quesType}" class="property check" value="${answer.answerId }"><span style="padding-right: 45px">${answer.answerDesType }</span>
                                                        </label>
                                                    </div>
                                                    <div class="col-xs-5">
                                                        <div class="progress">
                                                            <c:if test="${answer.answerValue==0}">
                                                                <c:set var="count" value="${answer.answerValue }"></c:set>
                                                            </c:if>
                                                            <c:if test="${answer.answerValue!=0}">
                                                                <c:set var="count" value="${answer.answerValue*100/requestScope.map.counts[question.quesId] }"></c:set>
                                                            </c:if>
                                                            <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="${answer.answerValue }" aria-valuemin="0" aria-valuemax="100" style="width: <fmt:formatNumber type="number" value="${count }" pattern="0.00" minFractionDigits="0"></fmt:formatNumber>% ">
                                                                <span class="sr-only">${answer.answerValue }</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-2">
                                                        <h5><cite title="">${requestScope.map.main.mainAnswer}人/${answer.answerValue }人/<fmt:formatNumber type="number" value="${count }" pattern="0.00" minFractionDigits="2"></fmt:formatNumber>%</cite></h5>
                                                    </div>
                                                </div>
                                                <br>
                                        </c:if>
                                        <c:if test="${question.quesType eq 'check'}"><%//多选 %>
                                                <div class="row">
                                                    <div class="col-xs-5">
                                                        <label>
                                                            <input type="checkbox" name="${question.quesType}" class="property check" value="${answer.answerId }"><span style="padding-right: 45px">${answer.answerDesType }</span>
                                                        </label>
                                                    </div>
                                                    <div class="col-xs-5">
                                                        <div class="progress">
                                                            <c:if test="${answer.answerValue==0}">
                                                                <c:set var="count" value="${answer.answerValue }"></c:set>
                                                            </c:if>
                                                            <c:if test="${answer.answerValue!=0}">
                                                                <c:set var="count" value="${answer.answerValue*100/requestScope.map.counts[question.quesId] }"></c:set>
                                                            </c:if>
                                                            <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="${answer.answerValue }" aria-valuemin="0" aria-valuemax="100" style="width: <fmt:formatNumber type="number" value="${count }" pattern="0.00" minFractionDigits="0"></fmt:formatNumber>% ">
                                                                <span class="sr-only">${answer.answerValue }</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-2">
                                                        <h5><cite title="">${requestScope.map.main.mainAnswer}人/${answer.answerValue }人/<fmt:formatNumber type="number" value="${count }" pattern="0.00" minFractionDigits="2"></fmt:formatNumber>%</cite></h5>
                                                    </div>
                                                </div>
                                                <br>
                                        </c:if>
                                        <c:if test="${question.quesType eq 'number'}"><%//整数 %>
                                            <div class="row">
                                                <label>
                                                    <input type="number" name="${question.quesType}" class="property check" value="0">
                                                </label>
                                            </div>
                                            <br>
                                        </c:if>
                                        <c:if test="${question.quesType eq 'decimal'}"><%//小数 %>
                                            <div class="row">
                                                <label>
                                                    <input type="number" step="0.01" name="${question.quesType}" class="property check" value="0.00">
                                                </label>
                                            </div>
                                            <br>
                                        </c:if>
                                    </c:forEach>
                                    <br />
                            </c:when>
                            <c:otherwise>
                                <c:if test="${question.quesType eq 'text'}"><%//文本单 %>
                                    <div class="row">
                                        <label>
                                            <input type="text" name="${question.quesType}" class="property check" value="">
                                        </label>
                                    </div>
                                    <br>
                                </c:if>
                                <c:if test="${question.quesType eq 'texts'}"><%//文本多 %>
                                    <div class="row">
                                        <label>
                                            <textarea name="${question.quesType}" class="property check" ></textarea>
                                        </label>
                                    </div>
                                    <br>
                                </c:if>
                            </c:otherwise>
                        </c:choose>
                           </td>
                    </tr>

                </c:forEach>
              </c:when>
                <c:otherwise>
                    <tr class="warning">
                        <td>
                            <span>暂无任何问题</span>
                        </td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </table>
        <div id = "send" class="input-group">
            <input id="message" class="form-control" placeholder="请问您还有什么其他意见?" name="message">
            <input type="hidden" name="mainId" value="${requestScope.map.main.mainId}"/>
            <span class="input-group-btn"><button type="submit" class="btn btn-primary" onclick="return tijiao();" >交卷</button></span>

        </div>
    </form>
</div>

<script type="text/javascript">
    var basePath = '<%=basePath%>';
    var socketPath = '<%=socketPath%>';
</script>
<script src="<%=basePath %>css/bootstrap-3.3.5-dist/js/jquery-1.11.3.min.js"></script>
<script src="<%=basePath %>css/bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
<script src="<%=basePath %>js/showImg.js?v=6.0"></script>

</body>

<script type="text/javascript">
    //提交问卷
    function submitAnswer(){
        var formData = new FormData($("#actionSub")[0]);
        alert($("#actionSub").find("#message").val())
        $.ajax({
            url: '<%=basePath %>main/actionSub',
            type: 'POST',
            data: formData,
            async: false,
            cache: false,
            processData: false,
            success: function(data){
                if(data.success) {
                    var pText = document.getElementById("alertOKText");
                    pText.innerText = "非常感谢您的认真回答";
                    $("#alertOK").modal();
                }else{
                    window.location.href=basePath+"main/mainIsAnswer";
                }
            },
            error: function(){
                alert ('服务器问题。');
            }
        });
    }


    function tijiao() {
        var k = 0;
        var ss = "";
        var obj = document.getElementsByTagName("input");
        for (var i = 0; i < obj.length; i++) {
            if (obj[i].type == "radio" || obj[i].type == "check" || obj[i].type == "score") {
                if (obj[i].name != ss) {
                    if (k != 0) {
                        alert("请填写完整问卷再提交！");
                        return false;
                    }
                    ss = obj[i].name;
                    k++;
                }
                if(obj[i].checked)k=0;
            }
        }
        if(k!=0){
            alert("请填写完整问卷再提交！");
            return false;
        }
    }
</script>
</html>
