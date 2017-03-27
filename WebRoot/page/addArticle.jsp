<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="https://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <style>p {text-indent: 2em;}</style>
    <style type="text/css"> 
		.comments {
			width:100%;/*自动适应父布局宽度*/
			overflow:auto; 
			word-break:break-all; 
			/*在ie中解决断行问题(防止自动变为在一行显示，主要解决ie兼容问题，ie8中当设宽度为100%时，文本域类容超过一行时， 
			当我们双击文本内容就会自动变为一行显示，所以只能用ie的专有断行属性“word-break或word-wrap”控制其断行)*/ 
		}
		#imgDiv{
			text-align:center
		}
	</style> 
    
    <script>
    	$(document).ready(function(){
    		//标题 # 双击显示编辑框
    		$("#title").dblclick(function(){
    			$("#addImgPre").hide();
    			$("#addImgAft").hide();
    			$("#btnBlod").hide();
    			$("#selectDiv").hide();
    			$("#btnDelImg").hide();
    			$("#btnChgImg").hide();
    			
    			$("#myModalLabel").text("编辑文章标题");
    			var modalBody = $("#modalBody");
    			modalBody.empty();
    			//添加输入框
    			var input = $("<input id='title' type='text' class='form-control'>");
    			input.val($(this).text());
    			modalBody.append(input);
    			//触发显示模态框
    			$("#modalDialog").removeClass("modal-dialog-lg");
    			$("#modalDialog").addClass("modal-dialog");
    			
    			$("#myModal").modal();
    		});
    		//段落 # 双击显示编辑框
    		$("p[type='paragraph']").dblclick(function(){
    			$("#addImgPre").show();
    			$("#addImgAft").show();
    			$("#btnBlod").show();
    			$("#selectDiv").hide();
    			$("#btnDelImg").hide();
    			$("#btnChgImg").hide();
    			$("#inputfile").attr("multiple","multiple");
    			
    			$("#myModalLabel").text("编辑段落");
    			var modalBody = $("#modalBody");
    			modalBody.empty();
    			//添加输入框
    			var input = $("<textarea id='textarea' class='comments' rows='10' cols='10'></textarea>");
    			input.attr("from",$(this).attr("id"));
    			input.text($(this).html());
    			modalBody.append(input);
    			//触发显示模态框
    			$("#modalDialog").removeClass("modal-dialog");
    			$("#modalDialog").addClass("modal-dialog-lg");
    			
    			$("#myModal").modal();
    			
    			//文字加粗处理逻辑
				var cursorPosition = {
					//获取光标选中文字范围
   					get: function (textarea) {
        				var rangeData = {text: "", start: 0, end: 0 };
     
				        if (textarea.setSelectionRange) { // W3C   
				            textarea.focus();
				            rangeData.start= textarea.selectionStart;
				            rangeData.end = textarea.selectionEnd;
				            rangeData.text = (rangeData.start != rangeData.end) ? textarea.value.substring(rangeData.start, rangeData.end): "";
				        } else if (document.selection) { // IE
				            textarea.focus();
				            var i,
				                oS = document.selection.createRange(),
				                oR = document.body.createTextRange();
				            oR.moveToElementText(textarea);
				             
				            rangeData.text = oS.text;
				            rangeData.bookmark = oS.getBookmark();
				             
				            for (i = 0; oR.compareEndPoints('StartToStart', oS) < 0 && oS.moveStart("character", -1) !== 0; i ++) {
				 
				                if (textarea.value.charAt(i) == '\r' ) {
				                    i ++;
				                }
				            }
				            rangeData.start = i;
				            rangeData.end = rangeData.text.length + rangeData.start;
				        }
				         
				        return rangeData;
				    },
     				//设置光标位置
				    set: function (textarea, rangeData) {
				        var oR, start, end;
				        if(!rangeData) {
				            alert("You must get cursor position first.")
				        }
				        textarea.focus();
				        if (textarea.setSelectionRange) { // W3C
				            textarea.setSelectionRange(rangeData.start, rangeData.end);
				        } else if (textarea.createTextRange) { // IE
				            oR = textarea.createTextRange();
				            if(textarea.value.length === rangeData.start) {
				                oR.collapse(false);
				                oR.select();
				            } else {
				                oR.moveToBookmark(rangeData.bookmark);
				                oR.select();
				            }
				        }
				    },
 					//添加加粗代码
				    add: function (textarea, rangeData, text) {
				        var oValue, nValue, oR, sR, nStart, nEnd, st;
				        text = "<strong>" + (!pos.text ? '//--': pos.text) + "</strong>";
				        this.set(textarea, rangeData);
				         
				        if (textarea.setSelectionRange) { // W3C
				            oValue = textarea.value;
				            nValue = oValue.substring(0, rangeData.start) + text + oValue.substring(rangeData.end);
				            nStart = nEnd = rangeData.start + text.length;
				            st = textarea.scrollTop;
				            textarea.value = nValue;
				            if(textarea.scrollTop != st) {
				                textarea.scrollTop = st;
				            }
				            textarea.setSelectionRange(nStart, nEnd);
				        } else if (textarea.createTextRange) { // IE
				            sR = document.selection.createRange();
				            sR.text = text;
				            sR.setEndPoint('StartToEnd', sR);
				            sR.select();
				        }
				    }
				}
				var tx=document.getElementById("textarea"),
				  	pos;
				document.getElementById("btnBlod").onclick = function(){
				    pos = cursorPosition.get(tx);
				    if(pos.end-pos.start == 0){
						alert("没有选中文本！");
						return;    
				    }
				    cursorPosition.add(tx, pos, "");
				}
    		});
    		//插入图片
    		var tag=0;
    		$(".btn-default").click(function(){
    			if($(this).attr("id") == "addImgPre"){
    				tag = -1;
    				$("#selectDiv").show();
    			}else if($(this).attr("id") == "addImgAft"){
    				tag = 1;
    				$("#selectDiv").show();
    			}
    		});
    		//选择图片
    		$("#inputfile").change(function(e) {
    			if($(this).attr("multiple") != "multiple"){
					var files = $(this).prop("files");
					// 获取 window 的 URL 工具
					var URL = window.URL || window.webkitURL;
					// 通过 file 生成目标 url
					var imgURL = URL.createObjectURL(files[0]);
					//用attr将img的src属性改成获得的url
					//console.info("图片控件:" + $("#imgDiv").children("img").length);
					$("#imgDiv").children("img").attr("src",imgURL);
    			}
			});
    		//图片 # 双击显示编辑框
    		$(".img-thumbnail").dblclick(imgDbclick);
    		//删除图片
    		$("#btnDelImg").click(function(){
    			//console.info(imgId+"图片父元素:"+$("#"+imgId).parent("div").attr("class"));
    			$("#"+imgId).parent("div").remove();
    			$("#myModal").modal("hide");
    		});
    		//模态编辑框关闭
    		$(function () {
    			$("#myModal").on("hide.bs.modal", function () {
      				//清空选择的文件
	      			var inputFile = $("#inputfile");
					inputFile.after(inputFile.clone(true).val(""));
					inputFile.remove();
      			});
   			});
   			//模态提交
   			$("#modalSubmit").click(function(){
   				modalSave(tag);
   				$("#myModal").modal("hide");
   			});
   			//保存按钮
	    	$("#btnSave").click(function(){
	    		//my();
	    		save_record();
	    	});
    	});
    	/**
    	*图片编辑事件
    	*/
    	var imgId = "img";
    	function imgDbclick(){
    		$("#addImgPre").hide();
    		$("#addImgAft").hide();
    		$("#btnBlod").hide();
    		$("#selectDiv").hide();
    		$("#btnDelImg").show();
    		$("#btnChgImg").show();
    		$("#inputfile").removeAttr("multiple");
    		
    		$("#myModalLabel").text("编辑图片");
    		var modalBody = $("#modalBody");
    		modalBody.empty();
    		
    		var div = $("<div id='imgDiv'></div>");
    		div.append($(this).clone());
    		
    		imgId = $(this).attr("id");
    		var imgt = $("#"+imgId).parent("div").children("h4").text();
    		
    		var imgTitle = $("<div class='input-group col-lg-4' style='margin:0 auto;'>"
    						+"<span class='input-group-addon'>图片标注:</span>"
    						+"<input id='imgt' type='text' class='form-control' placeholder="+imgt+"></div>");
    		div.append(imgTitle);
    		modalBody.append(div);
    		
    		
    		//触发显示模态框
    		$("#modalDialog").removeClass("modal-dialog");
    		$("#modalDialog").addClass("modal-dialog-lg");
    			
    		$("#myModal").modal();
    	}
	    /**
	    *保存模态框编辑的内容
	    */
	    function modalSave(tag){
	    	if($("#modalBody").find("#title").length != 0){
	    		console.info("if");
		    	var inputText = $("#modalBody").children("input").val().trim();
		      	if(inputText != ""){
		      		$("#title").text(inputText);
		      	}
      		}else if($("#modalBody").find("textarea").length != 0){
	      		var inputText = $("#modalBody").children("textarea").val().trim();
	      		var saveP = $("#"+$("#modalBody").children("textarea").attr("from"));
	      		
	      		var files = $("#inputfile").prop("files");
	      		if(files.length != 0 ){
	      			for(var i=0; i<files.length; i++){
		      			// 获取 window 的 URL 工具
						var URL = window.URL || window.webkitURL;
						// 通过 file 生成目标 url
						var imgURL = URL.createObjectURL(files[i]);
						//用attr将img的src属性改成获得的url
	      				var dImg = $("<div class='col-md-12 column text-center'></div>");
	      				var img = $("<img alt='140x140' src="+imgURL+" class='img-thumbnail'/>");
						img.attr("id","img"+($("#divContent").find("img").length+1+i));
	      				img.bind("dblclick",imgDbclick);
	      				var hImg = $("<h4 class='text-center'><strong>图片标注</strong></h4>");
	      				dImg.append(img);
	      				dImg.append(hImg);
	      				if(tag == -1){
	      					//inputText = img + inputText;
	      					saveP.before(dImg);
	      				}else if(tag == 1){
	      					//inputText = inputText + img;
	      					saveP.after(dImg);
	      				}
	      			}
	      		}
	      		$("#"+$("#modalBody").children("textarea").attr("from")).html(inputText);
      		}else if($("#modalBody").find("img").length != 0){
      			var files = $("#inputfile").prop("files");
	      		if(files.length != 0 ){
	      			// 获取 window 的 URL 工具
					var URL = window.URL || window.webkitURL;
					// 通过 file 生成目标 url
					var imgURL = URL.createObjectURL(files[0]);
					//用attr将img的src属性改成获得的url
      				$("#"+imgId).attr("src",imgURL);
      			}
      			if($("#modalBody").find("#imgt").val().trim() != ""){
      				$("#"+imgId).parent("div").children("h4").html("<strong>"+$("#modalBody").find("#imgt").val().trim()+"</strong>");
      			}
      		}
	    }
	    /**
	    *将页面内容保存到新的html文件
	    */
	    function save_record(){
	    	var content = "<!DOCTYPE html>";
	    	
		    var box = $("<html></html>");
		    //html
    		var html = $("<html></html>");
    		html.attr("lang","en");
    		//head
    		var head = $("<head></head>");
    		head.append("<meta charset=\"UTF-8\">");
    		head.append("<title>Title</title>");
    		head.append("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">");
    		head.append("<link rel=\"stylesheet\" href=\"https:\/\/cdn.static.runoob.com\/libs\/bootstrap\/3.3.7\/css\/bootstrap.min.css\">");
    		head.append("<script src=\"https:\/\/cdn.static.runoob.com\/libs\/jquery\/2.1.1\/jquery.min.js\"><\/script>");
    		head.append("<script src=\"https:\/\/cdn.static.runoob.com\/libs\/jquery\/2.1.1\/jquery.min.js\"><\/script>");
    		head.append("<style>p{text-indent:2em;}</style>");
    		//body
    		var body = $("<body></body>");
    			//container
    		var divContainer = $("<div class=\"container\"></div>");
    				//row
    				var divRow = $("<div class=\"row clearfix\"></div>");
    					//col
    					var divCol = $("<div class=\"col-md-12 column\"><h3 class=\"text-center\">前进!帕斯卡!2016年13款游戏本性能对决<\/h3></div>");
		    //封装
		   	divRow.append($("#divContent").html());
		   	divContainer.append(divRow);
		    body.append(divContainer);
		    
		   	html.append(head);
		   	html.append(body)
		    
		    box.append(html);
		    
		    
		    content= content + box.html();
    		var blob = new Blob([content], {type: "text/plain;charset=utf-8"});
    		saveAs(blob, "file.html");//saveAs(blob,filename)
    	}
    </script>
</head>
<body>
	<h2>添加文章</h2>
	<div class="panel panel-primary">
		<div class="panel-heading">
			<h3 class="panel-title">编辑文章</h3>
			<br>
			<button id="btnSave" type="button" class="btn btn-default">保存</button>
		</div>
		<div class="panel-body">
			<div class="container">
    <div class="row clearfix">
        <div class="col-md-12 column" id='divContent'>
            <h3 class="text-center" id="title">前进!帕斯卡!2016年13款游戏本性能对决</h3>
            <p class="text-left" id="paragraph1" type="paragraph">便携计算机诞生三十年来，一直在体积与重量的枷锁中艰难的挣扎。没有限制，不足以成就笔记本；没有困难，不足以凸显笔记本之美。最近几年兴起的游戏本恰恰是人类智慧在刀尖上跳舞的典范代表，适逢全球范围内PC移动浪潮兴起，年轻消费一族用脚投票支撑着曾被视为怪胎的游戏本市场震撼崛起。随着游戏本的大热趋势渐渐形成，也有越来越多的厂商在这片不知深浅的海洋中搏杀。到底游戏本市场是红海还是蓝海，厂商和发烧友们的乐观期待信心何在？这是ZOl作为IT垂直媒体非常关注的问题。2016年，由NVIDIA主导的帕斯卡架构GTX10系游戏本，为游戏本的前路给出了新的答案，在市场前进的方向中迈出了坚实的新一步。</p>
            <div class="col-md-12 column text-center">
            	<img id="img1" alt="140x140" src=images/1.jpg class="img-thumbnail"/>
                <h4 class="text-center"><strong>前进!帕斯卡!2016游戏本横评性能篇</strong></h4>
            </div>
            <p class="text-left" id="paragraph2" type="paragraph">从某种意义上讲，在市场的研发——生产——销售循环中，游戏本爱好者、游戏本代工厂和游戏本研发团队构成了同志加战友的关系。笔者作为编辑曾经接触过一些著名游戏本品牌的产销人员，他们对产品自身的精诚热爱殊不亚于贴吧、论坛上聚集的发烧大神们，许多更是直接从其中脱颖而出转化而来。面对帕斯卡架构带来的游戏本性能巨大飞跃，所有关注游戏本的粉丝们都涌现出了革命般的情怀。这篇以帕斯卡为主题的2016游戏本横评，希望能对消费者提供有针对性的建设性帮助。</p>
            <div class="col-md-12 column text-center">
            	<img id="img2" alt="140x140" src=images/2.png class="img-thumbnail"/>
                <h4 class="text-center"><strong>全线规格图</strong></h4>
            </div>
            <p class="text-left" id="paragraph3" type="paragraph">由于性能的大幅提升，实际上帕斯卡架构的GTX 10系列游戏本产品线实现了纵向的扩展——GTX1060 对位的是上一代的GTX970M，进行一对一替换；GTX 1080替换的是上一代的桌面版GTX980；GTX1070 替代的则是原来的GTX980M。帕斯卡架构显卡的定位进行了全面调整，但诸多厂家的实际市场安排却造成了混乱的局面——GTX1060 游戏本的价格跨度很大，最低接近原来GTX965M的七千元档，最高却超出一万关口甚多；GTX1080定位较高，普及程度也远不如前代GTX980旗舰。</p>
            <p class="text-left" id="paragraph4" type="paragraph"><strong> 针对此局面，ZOL笔记本频道将推出“帕斯卡架构游戏本系列横评”文章，从性能和散热角度为消费者提供积极、可靠、有效、详实的信息。本文属于这个系列横评的第一篇——性能篇，将为您带来十三款帕斯卡架构游戏本的对比分析。</strong></p>
        </div>
    </div>
</div>
		</div>
	</div>
	
	
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog-lg" id="modalDialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel">
					模态框（Modal）标题
				</h4>
			</div>
			<div class="modal-body" id="modalBody">
				在这里添加一些文本
				<textarea id='textarea' class='comments' rows='10' cols='10'></textarea>
			</div>
			<div class="modal-footer">
				
				<div style='float:right'>
					<button type="button" class="btn btn-default" tag="addImg" id="addImgPre">段前插入图片</button>
					<button type="button" class="btn btn-default" tag="addImg" id="addImgAft">段后插入图片</button>
					
					<button type="button" class="btn btn-default" id="btnDelImg">删除图片</button>
					<button type="button" class="btn btn-default" id="btnChgImg" onclick="$('#selectDiv').show()">修改图片</button>
					
					<button type="button" class="btn btn-default" id="btnBlod">加粗</button>
					
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="modalSubmit">提交更改</button>
				</div>
				<div id="selectDiv" style='float:right'><input type="file" accept="image/png,image/jpeg" id="inputfile" multiple="multiple"></div>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>
</body>
</html>