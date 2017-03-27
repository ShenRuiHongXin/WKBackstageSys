package com.shenrui.backstage.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;

import com.shenrui.backstage.vo.UserOnlineInfoBean;

@Repository("userOnlineInfoDao")
public class UserOnlineInfoDao {
	@Autowired
	@Qualifier("hibernateTemplate")
	private HibernateTemplate hibernateTemplate;

	public UserOnlineInfoBean findById(int id){
		return hibernateTemplate.get(UserOnlineInfoBean.class, id);
	}
	
	public List<UserOnlineInfoBean> findByCriteria(DetachedCriteria criteria){
		return hibernateTemplate.findByCriteria(criteria);
	}
}
