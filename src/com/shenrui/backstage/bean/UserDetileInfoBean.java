package com.shenrui.backstage.bean;

public class UserDetileInfoBean {
	private int id;
	private String nick_name;
	private int sex;
	private String avatar;
	private double balance;
	private double tmp_balance;
	private int integral;
	private String invite_code;
	private String regist_time;
	
	private String identity_type;
	private String identifier;
	private String credential;
	
	private String last_login_time;//最近一次登录时间
	private String last_login_ip;//最近一次登录IP
	private String last_login_device_model;//最近一次登录设备型号
	private String last_login_device_id;//最近一次登录设备ID
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNick_name() {
		return nick_name;
	}
	public void setNick_name(String nick_name) {
		this.nick_name = nick_name;
	}
	public int getSex() {
		return sex;
	}
	public void setSex(int sex) {
		this.sex = sex;
	}
	public String getAvatar() {
		return avatar;
	}
	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}
	public double getBalance() {
		return balance;
	}
	public void setBalance(double balance) {
		this.balance = balance;
	}
	public double getTmp_balance() {
		return tmp_balance;
	}
	public void setTmp_balance(double tmp_balance) {
		this.tmp_balance = tmp_balance;
	}
	public int getIntegral() {
		return integral;
	}
	public void setIntegral(int integral) {
		this.integral = integral;
	}
	public String getInvite_code() {
		return invite_code;
	}
	public void setInvite_code(String invite_code) {
		this.invite_code = invite_code;
	}
	public String getRegist_time() {
		return regist_time;
	}
	public void setRegist_time(String regist_time) {
		this.regist_time = regist_time;
	}
	public String getIdentity_type() {
		return identity_type;
	}
	public void setIdentity_type(String identity_type) {
		this.identity_type = identity_type;
	}
	public String getIdentifier() {
		return identifier;
	}
	public void setIdentifier(String identifier) {
		this.identifier = identifier;
	}
	public String getCredential() {
		return credential;
	}
	public void setCredential(String credential) {
		this.credential = credential;
	}
	public String getLast_login_time() {
		return last_login_time;
	}
	public void setLast_login_time(String last_login_time) {
		this.last_login_time = last_login_time;
	}
	public String getLast_login_ip() {
		return last_login_ip;
	}
	public void setLast_login_ip(String last_login_ip) {
		this.last_login_ip = last_login_ip;
	}
	public String getLast_login_device_model() {
		return last_login_device_model;
	}
	public void setLast_login_device_model(String last_login_device_model) {
		this.last_login_device_model = last_login_device_model;
	}
	public String getLast_login_device_id() {
		return last_login_device_id;
	}
	public void setLast_login_device_id(String last_login_device_id) {
		this.last_login_device_id = last_login_device_id;
	}
	
	
}
