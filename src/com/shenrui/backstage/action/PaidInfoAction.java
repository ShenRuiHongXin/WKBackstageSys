package com.shenrui.backstage.action;

import java.util.HashMap;
import java.util.Map;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.shenrui.backstage.service.PaidInfoService;
import com.shenrui.backstage.vo.PaidInfoBean;

@Namespace("/")
@ParentPackage("json-default")
@Controller("paidInfoAction")
@Scope("prototype")
public class PaidInfoAction extends ActionSupport implements
		ModelDriven<PaidInfoBean> {
	private PaidInfoBean paidInfoBean = new PaidInfoBean();

	public PaidInfoBean getModel() {
		return paidInfoBean;
	}

	// Action中注入Service
	@Autowired
	@Qualifier("paidInfoService")
	private PaidInfoService paidInfoService;

	// 会把本类所有getter方法序列化成字符串返回给jsp页面
	private Map<String, String> dataMap;
	public Map<String, String> getDataMap() {
		return dataMap;
	}
	public void setDataMap(Map<String, String> dataMap) {
		this.dataMap = dataMap;
	}

	
	@Action(value = "get_rebate_trade", results = { @Result(type = "json", params = {"root", "dataMap" }) })
	public String getRebateTrade() {
		this.dataMap = new HashMap<String, String>();

		// 1.获取ActionContext
		ActionContext actionContext = ActionContext.getContext();

		// 2获取请求参数
		Map<String, Object> paramMap = actionContext.getParameters();
		String pageNumStr = ((String[]) paramMap.get("pageNum"))[0];

		System.out.println("pageNum: " + pageNumStr);

		// System.out.println(taobaoTradeService.findByPage(Integer.parseInt(pageNumStr)).getList().get(0).getAuctionInfos());
		dataMap.put("tradeDatas", new Gson().toJson(paidInfoService.findByPage(Integer.parseInt(pageNumStr))));
		return SUCCESS;
	}

}
