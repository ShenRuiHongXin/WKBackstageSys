package com.shenrui.backstage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shenrui.backstage.bean.PageBean;
import com.shenrui.backstage.dao.TaobaoTradeDao;
import com.shenrui.backstage.vo.TaobaoTradeBean;

@Transactional
@Service("taobaoTradeService")
public class TaobaoTradeService {
	// Service中注入Dao
	@Autowired
	@Qualifier("taobaoTradeDao")
	private TaobaoTradeDao taobaoTradeDao;
	
	public void getAllRowCount(String hql){
		taobaoTradeDao.getAllRowCount(hql);
	 }
	
	public PageBean<TaobaoTradeBean> findByPage(int page) {
        PageBean<TaobaoTradeBean> pageBean =new PageBean<TaobaoTradeBean>();
        pageBean.setPage(page);
        int limit=4;
        pageBean.setLimit(limit);
        int totalCount=taobaoTradeDao.findTotalCount();
        
//        System.out.println("订单总数: " + totalCount);
//        System.out.println("总ye数: " + totalCount/Float.parseFloat(String.valueOf(limit)));
        
        pageBean.setTotalCount(totalCount);
        
        int totalpage=(int)Math.ceil(totalCount/Float.parseFloat(String.valueOf(limit)));
        pageBean.setTotalPage(totalpage);
        //每页显示的数据集合
        int begin=(page-1)*limit;
        List<TaobaoTradeBean> list=taobaoTradeDao.findByPageId(begin,limit);
        pageBean.setList(list);
        return pageBean;
    }
}
