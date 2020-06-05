
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    String socketPath = request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>问卷提交成功！</title>
    <link href="<%=basePath %>css/bootstrap-3.3.5-dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=basePath %>css/ityks.css" rel="stylesheet">
    <script src="<%=basePath %>css/bootstrap-3.3.5-dist/js/jquery-1.11.3.min.js"></script>
    <script src="<%=basePath %>css/bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
<script>
    <!--加载当前页立即执行,无需调用-->
    $(document).ready(function(){
        var pText = document.getElementById("alertOKText");
        pText.innerText = "非常感谢您的认真回答";
        $("#alertOK").modal();
    })
</script>
</head>
<body>

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
                    <p id="alertOKText">您的意见我们已经收到，非常感谢您。</p>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-default" data-dismiss="modal"  type="button" onclick="closepage();">关闭</button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<!--3秒后自动关闭当前页面-->
<script type="text/javascript">
    setTimeout("closepage()",5000);
    <!--调用关闭-->
    function closepage (){
        window.opener = null;
        window.open("","_self");
        window.close();
    }
</script>
