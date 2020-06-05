//增加问卷需要写标题
function newQuestion () {
    var a = $("#mainTitle").val();
    if (a == null || a == "") {
        alert('新建一份问卷调查，先填写标题。')
        return false;
    }

}
//删除一份问卷
function deleteMain(){
	var mainId=$("#tempId").val();				//获取Id为tempId的input值
	$.ajax({
		url:basePath+"main/delMain/"+mainId,
		type:'DELETE',
		success:function (data){
			if (data.success){					//删除成功刷新页面
				window.location.reload();
			}
		}
	});
}
//显示一份问卷是否删除提示
function delModal (mainId){
	$("#tempId").val(mainId);		//设置Id为tempId的input值为主表Id
	$("#delModal").modal();			//显示友好提示框
}
//显示批量问卷是否被删除提示
function delCheckModal (){
	$("#delCheckModal").modal();
}

function submitForm(formid,urlparm){
	//var formData = new FormData($(formid)[0]);
	$.ajax({
	url: urlparm,
	type: 'POST',
	data: {username:'username',password:'password'},
	async: false,
	cache: false,
	contentType: 'text/xml',
	processData: false,
	success: function(data){
		if(data.success) {
			window.location.reload();
		}
	},
	error: function(){
		alert ('服务器问题。');
	}
	});
}
//批量删除问卷
function submitFormDel(formid,urlparm){
	
	var names = $("input[name='id']:checked").serialize();  //序列化表单输入框为字符串，形如name1=value1&name2=value2
	
	$.ajax({
	url: urlparm+"?"+names,
	type: 'DELETE',
	async: false,
	cache: false,
	contentType: 'text/xml',
	processData: false,
	success: function(data){
		if(data.success) {
			window.location.reload();
		}
	},
	error: function(){
		alert ('服务器问题。');
	}
	});
}
//显示问题删除提示
function delQuestionModal (QuestionId){
	
	$("#tempQuestionId").val(QuestionId);
	$("#delQuestionModal").modal();
	
}

//删除一个问题
function delWt (questionId){
	
	$.ajax({
		url:basePath+"question/delWt/"+$("#tempQuestionId").val(),
		type:'DELETE',
		success:function (data){
			if (data.success){
				window.location.reload();
			}
		}
	});
	
}
//删除问题
function deleteQuestion (){
	
	var questionId = $("#tempQuestionId").val();
	$.ajax({
		url:basePath+"question/delQuestion/"+questionId,
		type:'DELETE',
		success:function (data){
			if (data.success){
				window.location.reload();
			}
		}
	});
}
//显示停止问卷发布提示
function pauseModel (mainId){
	
	$("#temppauseMainId").val(mainId);
	
	$("#pauseModel").modal();
}
//问卷停止发布
function pause (){
	$.ajax({
		url:basePath+"main/mainPause/"+$("#temppauseMainId").val(),
		type:'PUT',
		success:function (data){
			if (data.success){
				window.location.reload();
			}else{
				var pText = document.getElementById("alertOKText");
				pText.innerText = "暂停失败";
				$("#alertOK").modal();
			}
		}
	});
}

//问卷是否发布提示
function actionModel (mainId){
	$("#tempActionMainId").val(mainId);
	$("#actionModal").modal();
}

//问卷发布
function actionStart (){
	$.ajax({
		url:basePath+"main/mainIssue/"+$("#tempActionMainId").val(),
		type:'PUT',
		success:function (data){
			if (data.success){
				$("#alertOK").modal();
				window.location.reload();
			}else{
				var pText = document.getElementById("alertOKText");
				pText.innerText = "发布失败";
				$("#alertOK").modal();
			}
		}
	});
}
//提交问卷
function submitAnswer(formid,urlparm){
    var formData = new FormData($(formid)[0]);
	alert("formData"+formData)
	$.ajax({
	url: urlparm,
	type: 'POST',
	data: formData,
	async: false,
	cache: false,
	contentType: false,
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
//表单提交
function submitFormById (formId){
	if($("questionTitle1")==''||answerPro.num==1)
	{alert("问题或答案未输入！")
	return false;}
	$('#'+formId).submit();
}
//复制问卷
function copyQuestion (mainId){
	$.ajax({
		url:basePath+"main/copy/"+mainId,
		type:'GET',
		success:function (data){
			if (data.success){
				var pText = document.getElementById("alertOKText");
				pText.innerText = "拷贝成功，页面于三秒内刷新";
				$("#alertOK").modal();
				setTimeout("window.location.reload()",3000);
			}else{
				var pText = document.getElementById("alertOKText");
				pText.innerText = "拷贝失败";
				$("#alertOK").modal();
				
			}
		}
	});
}
//显示问卷修改
function showEdit(){
	
	$("#editform").show();
	$("#h5maintitle").hide();
	$("#btnxg").hide();
	$("#btnbc").show();
	$("#btnqx").show();
	
}
//取消问卷修改
function cancelEdit(){

	$("#editform").hide();
	$("#h5maintitle").show();
	$("#btnxg").show();
	$("#btnbc").hide();
	$("#btnqx").hide();
}
//保存问卷修改
function editQuestionMainTitle (mainId){
	
	var MainTitle = $("#mainTitleInput").val();
	var MainEndTime = $("#mainEndtimeInput").val();
	
	$.ajax({
		url:basePath+"question/editMain",
		type:'POST',
		data:{mainId:mainId,
			mainTitle:MainTitle,
			mainEndTime:MainEndTime
		},
		success:function (data){
			if (data.success){
				$("#alertOK").modal();
				$("#h5maintitle").html(MainTitle);
				cancelEdit();
			}else{
				var pText = document.getElementById("alertOKText");
				pText.innerText = "保存失败";
				$("#alertOK").modal();
			}
		}
	});
}
//关闭当前网页
function closepage (){
	
	window.opener = null;
	window.open("","_self");
	window.close();

}
//增加问题
function openEditModel (){
	$("#editModal").modal('show');
	$("div[name='div_answers']").remove();
	answerPro.num = 1;
}

var answerPro = {
		"num":1
}
//增加答案
function addAnswer() {
	var guidr = guid();		//生成guid作为
	$("#editAnswer").append("<div class='form-group' name='div_answers' id='div_answer"
			+guidr+"'><label>答案"+answerPro.num+":</label>"
			+"<div class='input-group'>"
			+"<input class='form-control' name='"+guidr+"' type='text' />"
			+"<div class='input-group-btn'>"
			+"<buttion class='btn btn-primary' type='button' onclick=\"delAddAnswer('"
			+guidr+"')\">删除</bution></div></div>"
			+"</div>");
	answerPro.num++;		//答案编号自加1
}

function delAddAnswer(num) {
	//根据传递过来的guid获取div，并将其移除
	$('#'+('div_answer'+num)).remove();
	var i = 1;
	//重新排序
	var elementLabel = $("div[name='div_answers']").find("label").each(function (){
		$(this).html("答案"+i+":");
		i++;
	});
	answerPro.num = i;
}
//修改问题及答案
function openEditModelxg (questionId){
	$("#editModalxg").modal('show');
	$("div[name='div_answersxg']").remove();
	
	$.ajax({
		url:basePath+"question/getQuestion/"+questionId,
		type:'GET',
		success:function (data){
			var answers = data.answers;
			var question = data.question;
			$("#questionIdxg").val(question.quesId);  //填充quesId
			$("#questionTitlexg").val(question.quesTitle);//填充问题描述
			$("#questionTypexg option[value="+question.quesType+"]").attr("selected","selected");  //填充问题类型，单选还是多选
			var i=0;
			for (i;i<answers.length;i++){
				var guidr = guid();
				var tempAnswerDestype = answers[i].answerDesType;
				if (answers[i].answerType == 'y'){
					var lastIF = answers[i].answerDesType.lastIndexOf("(");
					var temp = answers[i].answerDesType.substring(0,lastIF);
					tempAnswerDestype = temp;
				}
				$("#editAnswerxg").append("<div class='form-group' name='div_answersxg' id='div_answerxg"+guidr+"'><label>答案"+(i+1)+":</label>"
						+"<div class='input-group'>"
						+"<input class='form-control' name='"+answers[i].answerId+"' type='text' value='"+tempAnswerDestype+"' />"
						+"<div class='input-group-btn'><buttion class='btn btn-primary' type='button' onclick=\"delAddAnswerxg('"+guidr+"')\">删除</bution></div></div>"
						+"</div>");
			}
			answerPro.num = i+1;
		}
	});
	
}
//增加答案
function addAnswerxg() {
	var guidr = guid();
	$("#editAnswerxg").append("<div class='form-group' name='div_answersxg' id='div_answerxg"+guidr+"'><label>答案"+answerPro.num+":</label>"
			+"<div class='input-group'>"
			+"<input class='form-control' name='"+guidr+"' type='text' />"
			+"<div class='input-group-btn'><buttion class='btn btn-primary' type='button' onclick=\"delAddAnswerxg('"+guidr+"')\">删除</bution></div></div>"
			+"</div>");
	answerPro.num++;
}
//删除添加的答案栏位
function delAddAnswerxg(num) {
	$('#'+('div_answerxg'+num)).remove();
	var i = 1;
	var elementLabel = $("div[name='div_answersxg']").find("label").each(function (){
		$(this).html("答案"+i+":");
		i++;
	});
	answerPro.num = i;
}