package com.shenrui.backstage.vo;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="circle_ads")
public class CircleAdBean {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	private String location;//广告位置
	private String adType;//广告类型：APP内部活动促销广告、合作商家广告
	private String imgURL;//广告图片URL
	private String adURL;//广告内容地址,用于点击跳转
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getAdType() {
		return adType;
	}
	public void setAdType(String adType) {
		this.adType = adType;
	}
	public String getImgURL() {
		return imgURL;
	}
	public void setImgURL(String imgURL) {
		this.imgURL = imgURL;
	}
	public String getAdURL() {
		return adURL;
	}
	public void setAdURL(String adURL) {
		this.adURL = adURL;
	}
	@Override
	public String toString() {
		return "CircleAdBean [id=" + id + ", location=" + location
				+ ", adType=" + adType + ", imgURL=" + imgURL + ", adURL="
				+ adURL + "]";
	}
}
