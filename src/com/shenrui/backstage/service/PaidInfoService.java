package com.shenrui.backstage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shenrui.backstage.bean.PageBean;
import com.shenrui.backstage.dao.PaidInfoDao;
import com.shenrui.backstage.vo.PaidInfoBean;
import com.shenrui.backstage.vo.TaobaoTradeBean;


@Transactional
@Service("paidInfoService")
public class PaidInfoService {
	//Service中注入Dao
	@Autowired
	@Qualifier("paidInfoDao")
	private PaidInfoDao paidInfoDao;
	
	public PageBean<PaidInfoBean> findByPage(int page) {
        PageBean<PaidInfoBean> pageBean =new PageBean<PaidInfoBean>();
        pageBean.setPage(page);
        int limit=4;
        pageBean.setLimit(limit);
        int totalCount=paidInfoDao.findTotalCount();
        
//        System.out.println("订单总数: " + totalCount);
//        System.out.println("总ye数: " + totalCount/Float.parseFloat(String.valueOf(limit)));
        
        pageBean.setTotalCount(totalCount);
        
        int totalpage=(int)Math.ceil(totalCount/Float.parseFloat(String.valueOf(limit)));
        pageBean.setTotalPage(totalpage);
        //每页显示的数据集合
        int begin=(page-1)*limit;
        List<PaidInfoBean> list=paidInfoDao.findByPageId(begin,limit);
        pageBean.setList(list);
        return pageBean;
    }
}
