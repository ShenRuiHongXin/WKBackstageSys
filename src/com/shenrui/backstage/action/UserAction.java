package com.shenrui.backstage.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.apache.struts2.convention.annotation.Result;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.shenrui.backstage.service.SysOperatorService;
import com.shenrui.backstage.service.UserService;
import com.shenrui.backstage.vo.SysOperatorBean;
import com.shenrui.backstage.vo.UserBean;

@Namespace("/")
@ParentPackage("json-default")
@Controller("userAction")
@Scope("prototype")
public class UserAction extends ActionSupport implements ModelDriven<UserBean>{
	private UserBean userBean = new UserBean();
	public UserBean getModel() {
		return userBean;
	}

	//在Action中注入Service
	@Autowired
	@Qualifier("userService")
	private UserService userService;
	
	//会把本类所有getter方法序列化成字符串返回给jsp页面
	private Map<String, String> dataMap;
	public Map<String, String> getDataMap() {
		return dataMap;
	}
	public void setDataMap(Map<String, String> dataMap) {
		this.dataMap = dataMap;
	}
	
	/**
	 * 获取用户列表
	 * @return
	 */
	@Action(value="get_users",results = { @Result(type = "json", params = { "root", "dataMap" }) })
	public String login(){
		this.dataMap = new HashMap<String, String>();

		// 1.获取ActionContext
		ActionContext actionContext = ActionContext.getContext();

		// 2获取请求参数
		Map<String, Object> paramMap = actionContext.getParameters();
		String pageNumStr = ((String[]) paramMap.get("pageNum"))[0];
		
		dataMap.put("userDatas", new Gson().toJson(userService.findByPage(Integer.parseInt(pageNumStr))));
		return SUCCESS;
	}
}
