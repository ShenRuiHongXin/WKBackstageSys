<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style> 
	td{vertical-align: middle !important;text-align:center;}
</style>
<script
	src="https://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
<script
	src="https://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.7.1.js"></script>
<script>
	function  packagAdInfo(loca,type,adUrl,imgName){
		var adInfo = new Object();
		if(loca == "首页"){
			loca = "index";	
		}else if(loca == "美食"){
			loca = "food";
		}else if(loca = "抽奖"){
			loca = "draw";
		}else{}
		
		if(type == "内置广告"){
			type = "default";
		}else if(type == "合作商家"){
			type = "custom";
		}else{}
		
		if(adUrl == ""){
			adUrl = "null";
		}
		
		adInfo.loca = loca;
		adInfo.type = type;
		adInfo.adUrl = adUrl;
		adInfo.imgName = imgName;
		return adInfo;
	}
	
	$(document).ready(function() {
/***************************提交图片***************************/
		$("#submit").click(function() {
			var adImgs = $("#inputfile").prop("files");
			console.info("files: " + adImgs);
			if(adImgs.length < 1){
				alert("请选择图片");
				return;
			}
			//组装数据
			var formData = new FormData();
			var adArray = new Array();
			for(var i=0; i<adImgs.length ;i++){
				var adInfo = new Object();
				var loca = $("#dropdownMenuL"+i).text();
				var type = $("#dropdownMenuT"+i).text();
				var adUrl = $("#inputUrl"+i).val().trim();
				var imgName = adImgs[i].name;
				
				if(loca=="请选择"){
					alert("选择广告位置！");
					return;
				}else if(type=="请选择"){
					alert("选择广告类型！");
					return;
				}
				adArray[i] = packagAdInfo(loca, type, adUrl, imgName)
				
				formData.append("adImg",adImgs[i]);
			}
			console.info(JSON.stringify(adArray));
			formData.append("adInfos",JSON.stringify(adArray));
			//请求
			$.ajax({
				url : "/WKBackstageSys/add_circleAds",
				data :formData,
				// 告诉jQuery不要去处理发送的数据 
				processData : false,
				// 告诉jQuery不要去设置Content-Type请求头 
				contentType : false,
				//通过ajax 方法提交的时候有两种数据格式，一种字符串
				// data:data,
				//一个是json
				type : "POST",
				dataType : "json",
				success : function(data) {
					if(data.RESULT == "SUCCESS"){
						alert("提交成功！");
						var inputFile = $("#inputfile");
						inputFile.after(inputFile.clone(true).val(""));
						inputFile.remove();
						$("#imgPreview").empty();
					}else{
						alert("提交失败！");
					}
				}
			});
		});

/***************************选择文件***************************/
		$("#inputfile").change(function(e) {
			var files = $(this).prop("files");
			console.info("file count: " + files.length);

			$("#imgPreview").empty();
			//图片表格
			var tabImg = $("<table></table>");
			tabImg.addClass("table table-striped table-hover");
			//表头
			var trHead = $("<tr><td>图片编号</td><td>图片预览</td><td>广告位置</td><td>广告类型</td><td>广告地址</td></tr>");
			tabImg.append(trHead);
			
			for ( var i = 0; i < files.length; i++) {
				console.info("file name: " + files[i].name);
				if (files[i].size > 1024 * 1024) {
					alert("图片大小不能超过 1MB!");
					var inputFile = $(this);
					inputFile.after(inputFile.clone(true).val(""));
					inputFile.remove();
					return false;
				}
				// 获取 window 的 URL 工具
				var URL = window.URL || window.webkitURL;
				// 通过 file 生成目标 url
				var imgURL = URL.createObjectURL(files[i]);
				//用attr将img的src属性改成获得的url
				
				var trImg = $("<tr></tr>");
				var tdNum = $("<td></td>");
				tdNum.text(i+1);
				
				var tdImg = $("<td></td>");
				tdImg.width(370);
					//图片框
					var img = $("<img></img>");
					img.addClass("img-thumbnail");
					img.attr({"src":imgURL});
					img.width(360);
					img.height(125);
				tdImg.append(img);
				//广告位置
				var tdLoc = $("<td></td>");
					var divDropL = $("<div></div>");
					divDropL.addClass("dropdown");
					var btnDropL = $("<button></button>");
					btnDropL.addClass("btn dropdown-toggle");
					btnDropL.text("请选择");
					btnDropL.attr({
						"id":"dropdownMenuL"+i,
						"type":"button",
						"data-toggle":"dropdown"
					});
					var spanDropL = $("<span class=\"caret\"></span>");
					
					var ulL = $("<ul></ul>");
					ulL.addClass("dropdown-menu");
					ulL.attr({
						"role":"menu",
						"aria-labelledby":"dropdownMenuL"+i
					});
					var liL1 = $("<li type=\"L\" id="+i+" value=\"index\" role=\"presentation\"><a role=\"menuitem\" tabindex=\"-1\">首页</a></li>");
					var liL2 = $("<li type=\"L\" id="+i+" value=\"food\" role=\"presentation\"><a role=\"menuitem\" tabindex=\"-1\">美食</a></li>");
					var liL3 = $("<li type=\"L\" id="+i+" value=\"draw\" role=\"presentation\"><a role=\"menuitem\" tabindex=\"-1\">抽奖</a></li>");					
					
					ulL.append(liL1);
					ulL.append(liL2);
					ulL.append(liL3);
					
					divDropL.append(btnDropL);
					divDropL.append(ulL);
					btnDropL.append(spanDropL);
				tdLoc.append(divDropL);
				//广告类型
				var tdType = $("<td></td>");
					var divDropT = $("<div></div>");
					divDropT.addClass("dropdown");
					var btnDropT = $("<button></button>");
					btnDropT.addClass("btn dropdown-toggle");
					btnDropT.text("请选择");
					btnDropT.attr({
						"id":"dropdownMenuT"+i,
						"type":"button",
						"data-toggle":"dropdown"
					});
					var spanDropT = $("<span class=\"caret\"></span>");
					
					var ulT = $("<ul></ul>");
					ulT.addClass("dropdown-menu");
					ulT.attr({
						"role":"menu",
						"aria-labelledby":"dropdownMenuT"+i
					});
					var liT1 = $("<li type=\"T\" id="+i+" value=\"default\" role=\"presentation\"><a role=\"menuitem\" tabindex=\"-1\">内置广告</a></li>");
					var liT2 = $("<li type=\"T\" id="+i+" value=\"custom\" role=\"presentation\"><a role=\"menuitem\" tabindex=\"-1\">合作商家</a></li>");
					
					ulT.append(liT1);
					ulT.append(liT2);
					
					divDropT.append(btnDropT);
					divDropT.append(ulT);
					btnDropT.append(spanDropT);
				tdType.append(divDropT);
				//广告地址
				var tdUrl = $("<td></td>");
					var div = $("<div></div>");
					div.addClass("input-group");
					var span = $("<span></span>");
					span.addClass("input-group-addon");
					span.text("广告URL:");
					var input = $("<input></input>");
					input.attr({"type":"text","id":"inputUrl"+i});
					input.addClass("form-control");
					div.append(span);
					div.append(input);
				tdUrl.append(div);
				
				tabImg.append(trImg);
				trImg.append(tdNum);
				trImg.append(tdImg);
				trImg.append(tdLoc);
				trImg.append(tdType);
				trImg.append(tdUrl);
			}
			$("#imgPreview").append(tabImg);
			
			//li位置绑定事件
			var liLs = $("li[type='L']");
			for(var j=0; j<liLs.length; j++){
				$(liLs[j]).bind("click",function(){
					$("#dropdownMenuL"+$(this).attr("id")).text($(this).children("a").text());
					$("#dropdownMenuL"+$(this).attr("id")).append(spanDropL.clone());
				});
			}
			
			//li类型绑定事件
			var liTs = $("li[type='T']");
			for(var j=0; j<liTs.length; j++){
				$(liTs[j]).bind("click",function(){
					$("#dropdownMenuT"+$(this).attr("id")).text($(this).children("a").text());
					$("#dropdownMenuT"+$(this).attr("id")).append(spanDropT.clone());
				});
			}
			
		});
	});
</script>
</head>

<body>
	<h2>添加轮播广告图片</h2>
	<div class="panel panel-primary">
		<div class="panel-heading">
			<h3 class="panel-title">悟空返利页面轮播广告</h3>
		</div>
		<div class="panel-body">
				<form role="form">
					<div class="alert alert-success"><strong>图片格式说明:</strong><br>
						<p>&nbsp;&nbsp;<span class="badge">1</span>&nbsp;图片格式 jpg/jpeg/png;</p>					
						<p>&nbsp;&nbsp;<span class="badge">2</span>&nbsp;图片大小不超过1M;</p>				
						<p>&nbsp;&nbsp;<span class="badge">3</span>&nbsp;图片文件命名须规范,只能包含数字、字母、下划线;</p>				
						<p>&nbsp;&nbsp;<span class="badge">4</span>&nbsp;图片尺寸 (1080px * 375px) (720px * 250px)......其他尺寸保持宽高比不变按比例缩放。</p>				
					</div>
					<div class="form-group">
						<label for="inputfile">选择文件</label> <input type="file"
							accept="image/png,image/jpeg" id="inputfile" multiple="multiple">
					</div>
					<div id="imgPreview"></div>
					<br>
					<button id="submit" class="btn btn-primary">提交图片</button>
				</form>
		</div>
	</div>

</body>

</html>