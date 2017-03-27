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

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.shenrui.backstage.service.SysOperatorService;
import com.shenrui.backstage.vo.SysOperatorBean;

@Namespace("/")
@ParentPackage("json-default")
@Controller("sysOperatorAction")
@Scope("prototype")
public class SysOperatorAction extends ActionSupport implements ModelDriven<SysOperatorBean>{
	private SysOperatorBean sysOperatorBean = new SysOperatorBean();
	public SysOperatorBean getModel() {
		return sysOperatorBean;
	}

	//在Action中注入Service
	@Autowired
	@Qualifier("sysOperatorService")
	private SysOperatorService sysOperatorService;
	
	//会把本类所有getter方法序列化成字符串返回给jsp页面
	private Map<String, String> dataMap;
	public Map<String, String> getDataMap() {
		return dataMap;
	}
	public void setDataMap(Map<String, String> dataMap) {
		this.dataMap = dataMap;
	}
	
	/**
	 * 后台运维登录
	 * @return
	 */
	@Action(value="user_login",results = { @Result(type = "json", params = { "root", "dataMap" }) })
	public String login(){
		System.out.println("Action层执行了");
		
		this.dataMap = new HashMap<String, String>();

		// 1.获取ActionContext
		ActionContext actionContext = ActionContext.getContext();

		// 2获取请求参数
		Map<String, Object> paramMap = actionContext.getParameters();

		// 参数名称必须和jsp的空间名称一一对应
		String userName = ((String[]) paramMap.get("userName"))[0];
		String password = ((String[]) paramMap.get("password"))[0];
		
		System.out.println("userName: " + userName + "password: " + password);
		
		List<SysOperatorBean> listUserBeans = sysOperatorService.findByName(userName);
		System.out.println("list size: " + listUserBeans.size());
		
		dataMap.put("isSuccess", "true");
		SimpleDateFormat now = new SimpleDateFormat("yyyy年MM月dd日 HH时mm分ss秒");
		dataMap.put("sayHi", "Hi:" + userName + "  当前时间为：" + now.format(new Date()) + password);
		
		return SUCCESS;
	}
}
