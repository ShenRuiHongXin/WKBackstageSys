package com.shenrui.backstage.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;

import com.shenrui.backstage.util.PageHibernateCallback;
import com.shenrui.backstage.vo.UserBean;

@Repository("userDao")
public class UserDao {
	// 装载hibernateTemplate
	@Autowired
	@Qualifier("hibernateTemplate")
	private HibernateTemplate hibernateTemplate;

	/**
	 * 条件
	 * 
	 * @param criteria
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<UserBean> findByCriteria(DetachedCriteria criteria) {
		return hibernateTemplate.findByCriteria(criteria);
	}

	// 查询用户表中总记录数
	@SuppressWarnings("unchecked")
	public int findTotalCount() {
		String hql = "select count(*) from UserBean";
		List<Long> list = (List<Long>) hibernateTemplate.find(hql);
		if (list != null && list.size() > 0) {
			return list.get(0).intValue();
		}
		return 0;
	}

	// 查询当前页面的用户集合
	@SuppressWarnings("unchecked")
	public List<UserBean> findByPageId(int begin, int limit) {
		String hql = "from UserBean";
		List<UserBean> list = (List<UserBean>) hibernateTemplate
				.execute((HibernateCallback<UserBean>) new PageHibernateCallback(
						hql, new Object[] {}, begin, limit));
		if (list != null && list.size() > 0) {

			return list;
		}
		return null;
	}
}
