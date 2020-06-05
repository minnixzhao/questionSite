
function subRegister(){
    var date=false;
    var loginName = $("#loginName").val();
	var password = $("#password").val();
	var repassword = $("#repassword").val();
	var userName = $("#userName").val();
	var email = $("#email").val();
	var reg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
    $.ajax({url:basePath+"user/register?loginName="+loginName,
             type: "GET",
             async:false,
		     success:function(result){
    	if(result.success==true) {
            date = result.success;
        }
             }})
    if(date!=false){
        alert(loginName+"该账号已被注册！请重新填写！")
        return;
    }else
   if (loginName==""||loginName.length<5){
		alert("用户名不得为空且不能少于五位英文加数字");
		return;
	}else if (password==null||password.length<5){
		alert("密码不得为空且不能少于五位英文加数字");
		return;
	}else if (password != repassword){
		alert("两次密码不一致");
		return;
	}else if (userName==""||userName.length>20){
		alert("姓名不得为空且不能大于十位中文或英文");
		return;
	}else if (email==""||!reg.test(email)){
		alert("邮箱格式不正确")
		return;
	}else{
		$("#registerform").submit();
	}
	
}