<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script>	
	$(document).ready(function() {
		var num1= 1;
		getPageData(num1);
	});
					
	function getPageData(num){
		$.ajax({
									type : "post",
									url : "/WKBackstageSys/get_trade",
									data : {
										"pageNum":num
									},
									dataType : "json",
									success : function(d) {
										var tradeDatas = d.tradeDatas;
										obj = eval("(" + tradeDatas + ")");
										var curPage = obj.page;
										var totalCount = obj.totalCount;
										var totalPage = obj.totalPage;
										var limit = obj.limit;
										var list = obj.list;
										
										var table = $("<table></table>");
										table.addClass("table table-striped table-bordered table-hover");
										var trHead = $("<tr><td>淘宝订单ID</td><td>买家淘宝账户ID</td><td>淘宝卖家昵称</td><td>淘宝卖家店铺</td><td>淘宝订单创建时间</td><td>订单状态</td><td>订单类型</td><td>是否电子凭证类订单</td><td>商品列表</td></tr>");
										table.append(trHead);
										
										for ( var i = 0; i < list.length; i++) {
											var trContent = $("<tr></tr>");
											
											var tdOrder_id = $("<td></td>");
											tdOrder_id.text(list[i].order_id);
											
											var tdBuyer_id = $("<td></td>");
											tdBuyer_id.text(list[i].buyer_id);
					
											var tdSeller_nick = $("<td></td>");
											tdSeller_nick.text(list[i].seller_nick);
											
											var tdShop_title = $("<td></td>");
											tdShop_title.text(list[i].shop_title);
											
											var tdCreate_order_time = $("<td></td>");
											tdCreate_order_time.text(list[i].create_order_time);
											
											var tdOrder_status = $("<td></td>");
											tdOrder_status.text(list[i].order_status);
											
											var tdOrder_type = $("<td></td>");
											tdOrder_type.text(list[i].order_type);
											
											var tdIs_eticket = $("<td></td>");
											tdIs_eticket.text(list[i].is_eticket);
											
											var tdAuctionInfos = $("<td></td>");
											
											var btnInfo = $("<button></button>");
											btnInfo.addClass("btn btn-default");
											btnInfo.text("商品列表");
											btnInfo.attr({
												"position":i,
												"type":"button",
												"title":"商品详情",
												"data-container":"body",
												"data-toggle":"modal",
												"data-target":"#myModal"
											});
											
											btnInfo.bind("click",function(){
												var goods = eval("("+ list[parseInt($(this).attr("position"))].AuctionInfos+ ")");
												
												var tbInfo = $("<table><tr><td>订单ID:</td><td>商品ID:</td><td>实际支付:</td><td>商品标题:</td><td>商品数量:</td><td>商品图片:</td></tr></table>");
												tbInfo.addClass("table table-striped table-bordered table-hover");
												
												for ( var j = 0; j < goods.length; j++) {
													var tr1 = $("<tr></tr>");
													
													var td1 = $("<td></td>");
													td1.text(goods[j].detail_order_id);
													
													var td2 = $("<td></td>");
													td2.text(goods[j].auction_id);
													
													var td3 = $("<td></td>");
													td3.text(goods[j].real_pay);
													
													var td4 = $("<td></td>");
													td4.text(goods[j].auction_title);
													
													var td5 = $("<td></td>");
													td5.text(goods[j].auction_amount);
													
													var td6 = $("<td></td>");
													td6.text(goods[j].auction_pict_url);
													
													tbInfo.append(tr1);
													
													tr1.append(td1);
													tr1.append(td2);
													tr1.append(td3);
													tr1.append(td4);
													tr1.append(td5);
													tr1.append(td6);
												}
												$(".modal-body").empty();
												$(".modal-body").append(tbInfo);
											});
											
											tdAuctionInfos.append(btnInfo);
											
											table.append(trContent);
											
											trContent.append(tdOrder_id);
											trContent.append(tdBuyer_id);
											trContent.append(tdSeller_nick);
											trContent.append(tdShop_title);
											trContent.append(tdCreate_order_time);
											trContent.append(tdOrder_status);
											trContent.append(tdOrder_type);
											trContent.append(tdIs_eticket);
											trContent.append(tdAuctionInfos);
											
										}
										
										$("#p").text("");
										$("#p").empty();
										$("#p").append(table);
										
										var ul = $("<ul></ul>");
										ul.addClass("pagination");
										
										var liPrevious = $("<li><a href=\"#\">&laquo;</a></li>");
										liPrevious.bind("click",function(){
											if(obj.page > 1){
												getPageData(--obj.page);
											}
										});
										ul.append(liPrevious);
										
										for ( var i = 1; i <= totalPage; i++) {
											var liPage = $("<li></li>");
											if(i == obj.page){
												liPage.addClass("active");
											}
											var a = $("<a></a>");
											a.text(i);
											a.attr("href","#");
											a.bind("click",function(){
												console.info("page num: " + $(this).text());
												var pageClick = parseInt($(this).text()); 
												if(obj.page != pageClick){
													getPageData(pageClick);
												}
											});
											liPage.append(a);
											
											ul.append(liPage);
										}
										
										var liNext = $("<li><a href=\"#\">&raquo;</a></li>");
										liNext.bind("click",function(){
											if(obj.page < obj.totalPage){
												getPageData(++obj.page);
											}
										});
										ul.append(liNext);
										
										$("#p").append(ul);
										
									},
									error : function(d) {
										console.info(d);
									}
								});
	}
</script>
</head>
<body>
	<div id="p">无订单信息</div>
<!-- 模态框（Modal）商品列表 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog-lg">
		<div class="modal-content">
			<div class="modal-header bg-primary">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" style="color:white" id="myModalLabel">
					商品详情
				</h4>
			</div>
			<div class="modal-body">
				在这里添加一些文本
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭
				</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>
</body>
</html>