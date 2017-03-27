package com.shenrui.backstage.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;

import com.shenrui.backstage.vo.UserAuthsBean;
import com.shenrui.backstage.vo.UserOnlineInfoBean;

@Repository("userAuthsDao")
public class UserAuthsDao {
	@Autowired
	@Qualifier("hibernateTemplate")
	private HibernateTemplate hibernateTemplate;
	
	public UserAuthsBean findById(int id){
		return hibernateTemplate.get(UserAuthsBean.class, id);
	}
}
