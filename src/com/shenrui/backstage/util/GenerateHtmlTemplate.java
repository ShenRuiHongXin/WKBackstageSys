package com.shenrui.backstage.util;

import java.util.Map;

import com.shenrui.backstage.bean.HtmlEleBean;

public class GenerateHtmlTemplate {
	private static String br = "\r\n";
	/**
	 * 生成html
	 * @return
	 */
	public static String generateHtml(){
		StringBuilder html = new StringBuilder();
		html.append(generateHead());
		
		return html.toString();
	}
	
	/**
	 * 生成头部
	 * @return
	 */
	private static String generateHead(){
		StringBuilder head = new StringBuilder("<!DOCTYPE html>").append(br)
				.append("<html lang=\"en\">").append("<head>").append(br)
				.append("<meta charset=\"UTF-8\">").append(br)
				.append("<title>Title</title>").append(br)
				.append("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">").append(br)
				.append("<link rel=\"stylesheet\" href=\"https://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css\">").append(br)
				.append("<script src=\"https://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js\"></script>").append(br)
				.append("<script src=\"https://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js\"></script>").append(br)
				.append("<script src=\"http://api.html5media.info/1.1.8/html5media.min.js\"></script>").append(br)
				.append("<script src=\"../js/my.js\"></script>").append(br)
				.append("<link rel=\"stylesheet\" href=\"../css/my.css\" type=\"text/css\"/>").append(br)
				.append("</head>");
		
		return head.toString();
	}
	
	private static String generateBody(Map<String, HtmlEleBean> contentMap){
		StringBuilder body = new StringBuilder("<body>").append(br)
				.append("<div class=\"container\">").append(br)
				.append("<div class=\"row clearfix\">").append(br)
				.append("<div class=\"col-md-12 column\">").append(br);
		//标题
		body.append("<h3 class=\"text-center\">").append(contentMap.get("title").getContent()).append("</h3>");
		
		return body.toString();
	}
}
