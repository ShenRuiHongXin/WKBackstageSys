package com.shenrui.backstage.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import com.shenrui.backstage.util.PageHibernateCallback;
import com.shenrui.backstage.vo.TaobaoTradeBean;

@Repository("taobaoTradeDao")
public class TaobaoTradeDao {
	@Autowired
	@Qualifier("hibernateTemplate")
	private HibernateTemplate hibernateTemplate;

	/**
	 * 增
	 * 
	 * @param book
	 */
	public void saveTaobaoTrade(TaobaoTradeBean taobaoTradeBean) {
		System.out.println("保存淘宝订单信息");
		hibernateTemplate.save(taobaoTradeBean);
	}

	// public List<TaobaoTradeBean> queryByPage(String hql, int offset, int
	// pageSize){
	//
	// }

	public void getAllRowCount(String hql) {
		hql = "select count(*) from TaobaoTradeBean taobaoTradeBean";
		int count = ((Long) hibernateTemplate.find(hql.toString()).iterator()
				.next()).intValue();

		System.out.println("订单总数: " + count);
	}

	// 查询订单表中总记录数
	public int findTotalCount() {
		String hql = "select count(*) from TaobaoTradeBean";
		List<Long> list = (List<Long>) hibernateTemplate.find(hql);
		if (list != null && list.size() > 0) {
			return list.get(0).intValue();
		}
		return 0;
	}

	// 查询当前页面的订单集合
	public List<TaobaoTradeBean> findByPageId(int begin, int limit) {
		String hql = "from TaobaoTradeBean";
		List<TaobaoTradeBean> list = (List<TaobaoTradeBean>) hibernateTemplate
				.execute((HibernateCallback<TaobaoTradeBean>) new PageHibernateCallback(
						hql, new Object[] {}, begin, limit));
		if (list != null && list.size() > 0) {

			return list;
		}
		return null;
	}

}
