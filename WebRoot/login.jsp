<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>index</title>
    <link href="css/style.css" rel="stylesheet" type="text/css" media="all"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body>

<div class="login">
    <h2>悟空返利后台运营管理系统</h2>
    <div class="login-top">
        <h1>LOGIN FORM</h1>
        <form>
            <input id="userName" type="text" value="User Name" onfocus="if (this.value == 'User Name'){this.value = '';}" onblur="if (this.value == '') {this.value = 'User Name';}">
            <a href="#" class="tooltip-test btn-lg" data-toggle="tooltip" title="请输入你的姓名">
                <span class="glyphicon glyphicon-question-sign"></span>
            </a>
            <input id="password" type="password" value="password" onfocus="if (this.value == 'password'){this.value = '';}" onblur="if (this.value == '') {this.value = 'password';}">
        </form>
        <div class="forgot">
            <a href="#">forgot Password</a>
            <input id="login" type="submit" value="Login">
        </div>
    </div>
    <div class="login-bottom">
        <!--<h3>New User &nbsp;<a href="#">Register</a>&nbsp Here</h3>-->
    </div>
</div>


<div id="loginInfo" class="container" style="display:none">
    <div class="row clearfix">
        <div class="col-md-3 column">
        </div>
        <div class="col-md-6 column">
            <div class="alert alert-danger">
                <span class="alert-danger"><strong>错误！</strong><span class="alert-danger" id="alertMsg">密码错误。</span></span><span style="float:right"><a id="alertClose" href="#" class="alert-danger">关闭</a></span>
            </div>
        </div>
        <div class="col-md-3 column">
        </div>
    </div>
</div>


</body>
<script>
    $(function () { $("[data-toggle='tooltip']").tooltip(); });
</script>
<script>
    $(document).ready(function(){
        //登录
        $("#login").click(function(){
            //alert("用户名:" + $("#userName").val() + "密码:" + $("#password").val());
            if(!$("#loginInfo").is(":hidden")){
                $("#loginInfo").slideUp();
            }
            if ($("#userName").val() == 'User Name'|| $("#password").val() == 'password'){
                $("#alertMsg").text("请输入用户名和密码。");
                $("#loginInfo").slideDown();
            }
             else{
            //alert("not null");
            	$.ajax({
            			type:"post",
            			url:"/WKBackstageSys/user_login",
            			data:{
            				userName:$("#userName").val(),
            				password:$("#password").val()
            			},
            			success : function(d) {
                        	window.location.href = "/WKBackstageSys/index.jsp";
                    	},
                    	error : function(d) {
                        	console.info(d);
                    	}
            	});
            } 
        });
        //关闭信息提示框
        $("#alertClose").click(function () {
            $("#loginInfo").slideUp();
        })
    });
</script>

</html>
