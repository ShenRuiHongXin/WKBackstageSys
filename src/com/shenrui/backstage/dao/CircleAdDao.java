package com.shenrui.backstage.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;

import com.shenrui.backstage.util.PageHibernateCallback;
import com.shenrui.backstage.vo.CircleAdBean;

@Repository("circleAdDao")
public class CircleAdDao {
	// 装载hibernateTemplate
	@Autowired
	@Qualifier("hibernateTemplate")
	private HibernateTemplate hibernateTemplate;

	 /**
	 * 增
	 * @param paidInfoBean
	 */
	 public void save(CircleAdBean circleAdBean){
		 System.out.println("PaidInfoDao save(): " + circleAdBean.toString());
		 hibernateTemplate.save(circleAdBean);
		 System.out.println("自动生成的ID：" + circleAdBean.getId());
	 }

	/**
	 * 条件
	 * 
	 * @param criteria
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<CircleAdBean> findByCriteria(DetachedCriteria criteria) {
		return hibernateTemplate.findByCriteria(criteria);
	}

	// 查询广告表中总记录数
	@SuppressWarnings("unchecked")
	public int findTotalCount() {
		String hql = "select count(*) from CircleAdBean";
		List<Long> list = (List<Long>) hibernateTemplate.find(hql);
		if (list != null && list.size() > 0) {
			return list.get(0).intValue();
		}
		return 0;
	}

	// 查询当前页面的广告集合
	@SuppressWarnings("unchecked")
	public List<CircleAdBean> findByPageId(int begin, int limit) {
		String hql = "from CircleAdBean";
		List<CircleAdBean> list = (List<CircleAdBean>) hibernateTemplate
				.execute((HibernateCallback<CircleAdBean>) new PageHibernateCallback(
						hql, new Object[] {}, begin, limit));
		if (list != null && list.size() > 0) {

			return list;
		}
		return null;
	}
}
