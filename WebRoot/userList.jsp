<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script
	src="https://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
<script
	src="https://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script>
	$(document).ready(function() {
		var num1= 1;
		getPageData(num1);
		
	});
	
	function getPageData(num){
		$.ajax({
			type : "post",
			url : "/WKBackstageSys/get_users",
			data : {
				"pageNum":num
			},
			dataType : "json",
			success : function(d) {
				var userDatas = d.userDatas;
				obj = eval("(" + userDatas + ")");
				var curPage = obj.page;
				var totalCount = obj.totalCount;
				var totalPage = obj.totalPage;
				var limit = obj.limit;
				var list = obj.list;
							
				var table = $("<table></table>");
				table.addClass("table table-striped table-bordered table-hover");
				var trHead = $("<tr><td>用户ID</td><td>昵称</td><td>性别</td><td>账号类型</td><td>账号</td><td>注册时间</td><td>最后登录时间</td><td>最后登录设备型号</td><td>最后登录设备ID</td><td>最后登录IP</td><td>余额(¥)</td><td>临时余额(¥)</td><td>积分</td><td>邀请码</td></tr>");
				table.append(trHead);
				
				for ( var i = 0; i < list.length; i++) {
					var trContent = $("<tr></tr>");
							
					var tdId = $("<td></td>");
					tdId.text(list[i].id);
											
					var tdNick_name = $("<td></td>");
					tdNick_name.text(list[i].nick_name);
					
					var tdSex = $("<td></td>");
					tdSex.text(list[i].sex);
											
					var tdIdentity_type = $("<td></td>");
					tdIdentity_type.text(list[i].identity_type);
											
					var tdIdentifier = $("<td></td>");
					tdIdentifier.text(list[i].identifier);
											
					var tdRegist_time = $("<td></td>");
					tdRegist_time.text(list[i].regist_time);
											
					var tdLast_login_time = $("<td></td>");
					tdLast_login_time.text(list[i].last_login_time);
											
					var tdLast_login_device_model = $("<td></td>");
					tdLast_login_device_model.text(list[i].last_login_device_model);
					
					var tdLast_login_device_id = $("<td></td>");
					tdLast_login_device_id.text(list[i].last_login_device_id);
											
					var tdLast_login_ip = $("<td></td>");
					tdLast_login_ip.text(list[i].last_login_ip);
					
					var tdBalance = $("<td></td>");
					tdBalance.text(list[i].balance);
					
					var tdTmp_balance = $("<td></td>");
					tdTmp_balance.text(list[i].tmp_balance);
					
					var tdIntegral = $("<td></td>");
					tdIntegral.text(list[i].integral);
					
					var tdInvite_code = $("<td></td>");
					tdInvite_code.text(list[i].invite_code);
					
					table.append(trContent);

					trContent.append(tdId);
					trContent.append(tdNick_name);
					trContent.append(tdSex);
					trContent.append(tdIdentity_type);
					trContent.append(tdIdentifier);
					trContent.append(tdRegist_time);
					trContent.append(tdLast_login_time);
					trContent.append(tdLast_login_device_model);
					trContent.append(tdLast_login_device_id);
					trContent.append(tdLast_login_ip);
					trContent.append(tdBalance);
					trContent.append(tdTmp_balance);
					trContent.append(tdIntegral);
					trContent.append(tdInvite_code);
				} 
				$("#content").empty();
				$("#content").append($("<h2>用户列表</h2>"));
				$("#content").append(table);

				var ul = $("<ul></ul>");
				ul.addClass("pagination");

				var liPrevious = $("<li><a href=\"#\">&laquo;</a></li>");
				liPrevious.bind("click", function() {
					if (obj.page > 1) {
						getPageData(--obj.page);
					}
				});
				ul.append(liPrevious);

				for ( var i = 1; i <= totalPage; i++) {
					var liPage = $("<li></li>");
					if (i == obj.page) {
						liPage.addClass("active");
					}
					var a = $("<a></a>");
					a.text(i);
					a.attr("href", "#");
					a.bind("click", function() {
						console.info("page num: " + $(this).text());
						var pageClick = parseInt($(this).text());
						if (obj.page != pageClick) {
							getPageData(pageClick);
						}
					});
					liPage.append(a);

					ul.append(liPage);
				}

				var liNext = $("<li><a href=\"#\">&raquo;</a></li>");
				liNext.bind("click", function() {
					if (obj.page < obj.totalPage) {
						getPageData(++obj.page);
					}
				});
				ul.append(liNext);

				$("#content").append(ul);				
			},
			error : function(d) {
				console.info(d);
			}
		});
	}
</script>
</head>

<body>
	<div id="content">无用户信息</div>
</body>
</html>