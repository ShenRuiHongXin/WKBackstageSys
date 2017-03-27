package com.shenrui.backstage.action;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.Type;
import com.google.gson.reflect.TypeToken;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.google.gson.Gson;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.shenrui.backstage.bean.AdInfoBean;
import com.shenrui.backstage.service.CircleAdService;
import com.shenrui.backstage.vo.CircleAdBean;

@Namespace("/")
@ParentPackage("json-default")
@Controller("circleAdAction")
@Scope("prototype")
public class CircleAdAction extends ActionSupport implements ModelDriven<CircleAdBean> {
	private CircleAdBean circleAdBean = new CircleAdBean();
	public CircleAdBean getModel() {
		return circleAdBean;
	}

	// Action中注入Service
	@Autowired
	@Qualifier("circleAdService")
	private CircleAdService circleAdService;

	// 会把本类所有getter方法序列化成字符串返回给jsp页面
	private Map<String, String> dataMap;
	public Map<String, String> getDataMap() {
		return dataMap;
	}
	public void setDataMap(Map<String, String> dataMap) {
		this.dataMap = dataMap;
	}

	/********************************************添加广告************************/
	private File[] adImg; //上传的文件
	private String[] adImgFileName; //文件名称
	private String[] adImgContentType; //文件类型
	
	public File[] getAdImg() {
		return adImg;
	}
	public void setAdImg(File[] adImg) {
		this.adImg = adImg;
	}
	public String[] getAdImgFileName() {
		return adImgFileName;
	}
	public void setAdImgFileName(String[] adImgFileName) {
		this.adImgFileName = adImgFileName;
	}
	public String[] getAdImgContentType() {
		return adImgContentType;
	}
	public void setAdImgContentType(String[] adImgContentType) {
		this.adImgContentType = adImgContentType;
	}
	/**
	 * 添加广告
	 * 
	 * @return
	 */
	@Action(value = "add_circleAds", results = { @Result(type = "json", params = {"root", "dataMap" }) })
	public String add() {
		this.dataMap = new HashMap<String, String>();
		// 1.获取ActionContext
		ActionContext actionContext = ActionContext.getContext();

		// 2获取请求参数
		Map<String, Object> paramMap = actionContext.getParameters();
		String adInfosStr = ((String[]) paramMap.get("adInfos"))[0];
		
		Type type = new TypeToken<ArrayList<AdInfoBean>>(){}.getType();
		ArrayList<AdInfoBean> adInfoList = new Gson().fromJson(adInfosStr, type);
		
		ServletContext sc = (ServletContext) actionContext.get(ServletActionContext.SERVLET_CONTEXT);
		
		String savePath = sc.getRealPath("/Resources/CircleAdImages");
		System.out.println("path: " + savePath);
		File saveFileDir = new File(savePath);
		if (!saveFileDir.exists()) {
			// 创建临时目录
			saveFileDir.mkdirs();
		}
		
		//创建映射目录
		String mappingPath = sc.getRealPath("/");
		System.out.println("mappingPath: " + mappingPath);
		String diskStr = mappingPath.substring(0,mappingPath.indexOf(":")+2);
		System.out.println("盘符：" + diskStr);
		String mappingDir = diskStr + "WukongServer";
		System.out.println("映射目录: " + mappingDir);
		File mappingFileDir = new File(mappingDir + "\\Resources\\CircleAdImages");	
		if(!mappingFileDir.exists()){
			//创建保存目录
			mappingFileDir.mkdirs();
		}
		
		for(int i=0; i<adImg.length; i++){
			System.out.println("fileName: " + adImgFileName[i]);
			String tmpFileName = System.currentTimeMillis()+adImgFileName[i].substring(adImgFileName[i].lastIndexOf(".")-1);
			System.out.println("saveFileName: " + tmpFileName);
			File mappingFile = new File(mappingFileDir,tmpFileName);
			try {
				//FileUtils.copyFile(adImg[i], circleAdImgFile);
				FileUtils.copyFile(adImg[i], mappingFile);
				
				String filePath = mappingFile.getAbsolutePath(); 
				System.out.println("file path: "+ filePath);
				String fileNameTmp = filePath.substring(filePath.lastIndexOf("WukongServer"));
				System.out.println(fileNameTmp);
				String fileName = fileNameTmp.replace("\\", "/");
				System.out.println("访问路径： "+fileName);
				circleAdBean = new CircleAdBean();
				for(AdInfoBean ad : adInfoList){
					if(ad.getImgName().equals(adImgFileName[i])){
						circleAdBean.setLocation(ad.getLoca());
						circleAdBean.setAdType(ad.getType());
						circleAdBean.setAdURL(ad.getAdUrl());
						circleAdBean.setImgURL(fileName);
					}
				}
				circleAdService.add(circleAdBean);
				
			} catch (IOException e) {
				e.printStackTrace();
			}
			dataMap.put("RESULT", "SUCCESS");
		}
		
		System.out.println("dataMap: " + dataMap);
		
		return SUCCESS;
	}
	
	/******************************************** 添加广告 end ************************/
	
	//获取广告
	@Action(value = "get_circleAds", results = { @Result(type = "json", params = {"root", "dataMap" }) })
	public String getCircleAds() {
		this.dataMap = new HashMap<String, String>();

		// 1.获取ActionContext
		ActionContext actionContext = ActionContext.getContext();

		// 2获取请求参数
		Map<String, Object> paramMap = actionContext.getParameters();
		String pageNumStr = ((String[]) paramMap.get("pageNum"))[0];

		System.out.println("pageNum: " + pageNumStr);

		// System.out.println(taobaoTradeService.findByPage(Integer.parseInt(pageNumStr)).getList().get(0).getAuctionInfos());
		dataMap.put("tradeDatas", new Gson().toJson(circleAdService.findByPage(Integer.parseInt(pageNumStr))));
		return SUCCESS;
	}

}
