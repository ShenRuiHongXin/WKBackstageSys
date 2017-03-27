package com.shenrui.backstage.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;

import com.shenrui.backstage.util.PageHibernateCallback;
import com.shenrui.backstage.vo.PaidInfoBean;
import com.shenrui.backstage.vo.TaobaoTradeBean;

@Repository("paidInfoDao")
public class PaidInfoDao {
	// 装载hibernateTemplate
	@Autowired
	@Qualifier("hibernateTemplate")
	private HibernateTemplate hibernateTemplate;

	// /**
	// * 增
	// * @param paidInfoBean
	// */
	// public void save(PaidInfoBean paidInfoBean){
	// System.out.println("PaidInfoDao save(): " + paidInfoBean.toString());
	// hibernateTemplate.save(paidInfoBean);
	// System.out.println("自动生成的ID：" + paidInfoBean.getId());
	// }

	/**
	 * 条件
	 * 
	 * @param criteria
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<PaidInfoBean> findByCriteria(DetachedCriteria criteria) {
		return hibernateTemplate.findByCriteria(criteria);
	}

	// 查询订单表中总记录数
	@SuppressWarnings("unchecked")
	public int findTotalCount() {
		String hql = "select count(*) from PaidInfoBean";
		List<Long> list = (List<Long>) hibernateTemplate.find(hql);
		if (list != null && list.size() > 0) {
			return list.get(0).intValue();
		}
		return 0;
	}

	// 查询当前页面的订单集合
	@SuppressWarnings("unchecked")
	public List<PaidInfoBean> findByPageId(int begin, int limit) {
		String hql = "from PaidInfoBean";
		List<PaidInfoBean> list = (List<PaidInfoBean>) hibernateTemplate
				.execute((HibernateCallback<PaidInfoBean>) new PageHibernateCallback(
						hql, new Object[] {}, begin, limit));
		if (list != null && list.size() > 0) {

			return list;
		}
		return null;
	}
}
