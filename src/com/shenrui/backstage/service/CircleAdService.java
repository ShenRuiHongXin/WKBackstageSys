package com.shenrui.backstage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shenrui.backstage.bean.PageBean;
import com.shenrui.backstage.dao.CircleAdDao;
import com.shenrui.backstage.vo.CircleAdBean;


@Transactional
@Service("circleAdService")
public class CircleAdService {
	//Service中注入Dao
	@Autowired
	@Qualifier("circleAdDao")
	private CircleAdDao circleAdDao;
	
	//保存
	public void add(CircleAdBean circleAdBean){
		circleAdDao.save(circleAdBean);
	}
	
	//分页查找
	public PageBean<CircleAdBean> findByPage(int page) {
        PageBean<CircleAdBean> pageBean =new PageBean<CircleAdBean>();
        pageBean.setPage(page);
        int limit=4;
        pageBean.setLimit(limit);
        int totalCount=circleAdDao.findTotalCount();
        
//        System.out.println("订单总数: " + totalCount);
//        System.out.println("总ye数: " + totalCount/Float.parseFloat(String.valueOf(limit)));
        
        pageBean.setTotalCount(totalCount);
        
        int totalpage=(int)Math.ceil(totalCount/Float.parseFloat(String.valueOf(limit)));
        pageBean.setTotalPage(totalpage);
        //每页显示的数据集合
        int begin=(page-1)*limit;
        List<CircleAdBean> list=circleAdDao.findByPageId(begin,limit);
        pageBean.setList(list);
        return pageBean;
    }
}
