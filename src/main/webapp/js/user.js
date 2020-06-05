//修改用户角色
function setRole (roleId,roleDes,userId,loginName){

    $(("#s_"+userId)).html(roleDes);       //单击后修改用户角色显示

    $.ajax({
		url: basePath+'user/updateUserRole?roleId='+roleId+'&userId='+userId+'&loginName='+loginName,
		type: 'POST',

		success: function(data){
			if(data.success) {
				var pText = document.getElementById("alertOKText");
				pText.innerText = "权限更改";
				$("#alertOK").modal();
			}else{
				var pText = document.getElementById("alertOKText");
				pText.innerText = "权限为正常修改，请联系管理员";
				$("#alertOK").modal();
			}
		},
        error: function(){
            alert ('服务器问题。');
        }
		});

}
//显示删除用户提示
function delModal (login_id){
	$("#temoLoginId").val(login_id);  //赋值userId
	$("#delModal").modal();
	
}
//删除用户
function deleteUser (){
	
	var userId = $("#temoLoginId").val();  //获取用户userId
	$.ajax({
		url:basePath+"user/deleteUser/"+userId,
		type:'DELETE',
		success:function (data){
			if (data.success){
				window.location.reload();
			}
		}
	});
}