package com.shenrui.backstage.action;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletContext;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.shenrui.backstage.util.GenerateHtmlTemplate;
import com.shenrui.backstage.vo.ArticlePageBean;

@Namespace("/")
@ParentPackage("json-default")
@Controller("articlePageAction")
@Scope("prototype")
public class ArticlePageAction extends ActionSupport implements ModelDriven<ArticlePageBean>{
	private ArticlePageBean articlePageBean = new ArticlePageBean();
	public ArticlePageBean getModel() {
		return articlePageBean;
	}
	
	// 会把本类所有getter方法序列化成字符串返回给jsp页面
	private Map<String, String> dataMap;
	public Map<String, String> getDataMap() {
		return dataMap;
	}
	public void setDataMap(Map<String, String> dataMap) {
		this.dataMap = dataMap;
	}

	/********************************************添加广告************************/
	private File[] pageImg; //上传的文件
	private String[] pageImgFileName; //文件名称
	private String[] pageImgContentType; //文件类型
	public File[] getPageImg() {
		return pageImg;
	}
	public void setPageImg(File[] pageImg) {
		this.pageImg = pageImg;
	}
	public String[] getPageImgFileName() {
		return pageImgFileName;
	}
	public void setPageImgFileName(String[] pageImgFileName) {
		this.pageImgFileName = pageImgFileName;
	}
	public String[] getPageImgContentType() {
		return pageImgContentType;
	}
	public void setPageImgContentType(String[] pageImgContentType) {
		this.pageImgContentType = pageImgContentType;
	}

	/**
	 * 添加广告
	 * 
	 * @return
	 */
	@Action(value = "add_articlePage", results = { @Result(type = "json", params = {"root", "dataMap" }) })
	public String add() {
		// 1.获取ActionContext
		ActionContext actionContext = ActionContext.getContext();

		// 2获取请求参数
		Map<String, Object> paramMap = actionContext.getParameters();
		String eleInfoArrayStr = ((String[]) paramMap.get("eleInfoArray"))[0];
		
		System.out.println("eleInfoArray:" + eleInfoArrayStr);
		
		for(String str : pageImgFileName){
			System.out.println("name:"+str);
		}
		
		ServletContext sc = (ServletContext) actionContext.get(ServletActionContext.SERVLET_CONTEXT);
		String savePath = sc.getRealPath("/Resources/page");
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
		File mappingFileDir = new File(mappingDir + "\\Resources\\page");	
		if(!mappingFileDir.exists()){
			//创建保存目录
			mappingFileDir.mkdirs();
		}
		//创建文件
		String tmpFileName = System.currentTimeMillis()+".html";
		System.out.println("saveFileName: " + tmpFileName);
		File mappingFile = new File(mappingFileDir,tmpFileName);
		

		long begin = System.currentTimeMillis();
        try {
        	FileWriter fw = new FileWriter(mappingFile); 
        	//fw.write(GenerateHtmlTemplate.generateHtml());
          	fw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}     

        long end3 = System.currentTimeMillis();     
        System.out.println("FileWriter执行耗时:" + (end3 - begin)+ "豪秒");
		
	    if(!mappingFile.exists())   
	    {   
	        try {   
	        	mappingFile.createNewFile();   
	        } catch (IOException e) {   
	            e.printStackTrace();   
	        }   
	    } 
		
		return NONE;
	}
}
