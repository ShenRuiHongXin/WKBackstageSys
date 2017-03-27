package com.shenrui.backstage.bean;

public class AdInfoBean {
	private String loca;
	private String type;
	private String adUrl;
	private String imgName;
	public String getLoca() {
		return loca;
	}
	public void setLoca(String loca) {
		this.loca = loca;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getAdUrl() {
		return adUrl;
	}
	public void setAdUrl(String adUrl) {
		this.adUrl = adUrl;
	}
	public String getImgName() {
		return imgName;
	}
	public void setImgName(String imgName) {
		this.imgName = imgName;
	}
	@Override
	public String toString() {
		return "AdInfoBean [loca=" + loca + ", type=" + type + ", adUrl="
				+ adUrl + ", imgName=" + imgName + "]";
	}
}
