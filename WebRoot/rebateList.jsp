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
		var num1 = 1;
		getPageData(num1);
	});

	function getPageData(num) {
		$
				.ajax({
					type : "post",
					url : "/WKBackstageSys/get_rebate_trade",
					data : {
						"pageNum" : num
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
						var trHead = $("<tr><td>淘宝订单ID</td><td>买家淘宝账户ID</td><td>买家悟空账户ID</td><td>付款时间</td><td>返利金额(¥)</td><td>操作设备</td></tr>");
						table.append(trHead);

						for ( var i = 0; i < list.length; i++) {
							var trContent = $("<tr></tr>");

							var tdOrderId = $("<td></td>");
							tdOrderId.text(list[i].tb_trade_id);

							var tdTbUserId = $("<td></td>");
							tdTbUserId.text(list[i].tb_account_id);

							var tdWkUserId = $("<td></td>");
							tdWkUserId.text(list[i].user_id);

							var tdPaidTime = $("<td></td>");
							tdPaidTime.text(list[i].paid_time);

							var tdReMoney = $("<td></td>");
							tdReMoney.text(list[i].rebate_amount);

							var tdDevice = $("<td></td>");
							tdDevice.text(list[i].device_model);

							table.append(trContent);

							trContent.append(tdOrderId);
							trContent.append(tdTbUserId);
							trContent.append(tdWkUserId);
							trContent.append(tdPaidTime);
							trContent.append(tdReMoney);
							trContent.append(tdDevice);
						}

						$("#p").empty();
						$("#p").append(table);

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
	<div id="p">无返利订单信息</div>
</body>
</html>
