package com.shenrui.backstage.bean;

public class HtmlEleBean {
	private int position;
	private String content;
	public int getPosition() {
		return position;
	}
	public void setPosition(int position) {
		this.position = position;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@Override
	public String toString() {
		return "HtmlEleBean [position=" + position + ", content=" + content
				+ "]";
	}
	
}
