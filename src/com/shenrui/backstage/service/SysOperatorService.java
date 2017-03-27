package com.shenrui.backstage.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shenrui.backstage.dao.SysOperatorDao;
import com.shenrui.backstage.vo.SysOperatorBean;

@Transactional
@Service("sysOperatorService")
public class SysOperatorService {
	// Service中注入Dao
	@Autowired
	@Qualifier("sysOperatorDao")
	private SysOperatorDao sysOperatorDao;

	// 增
	public void add(SysOperatorBean sysOperatorBean) {
		System.out.println("Service层执行了");
		sysOperatorDao.save(sysOperatorBean);
	}

	// 删
	public void delete(SysOperatorBean sysOperatorBean) {
		sysOperatorDao.delete(sysOperatorBean);
	}

	// 改
	public void update(SysOperatorBean sysOperatorBean) {
		sysOperatorDao.update(sysOperatorBean);
	}

	// 查
	public List<SysOperatorBean> findByName(String userName) {
		DetachedCriteria criteria = DetachedCriteria.forClass(SysOperatorBean.class);
		criteria.add(Restrictions.eq("name", userName));
		return sysOperatorDao.findByName(criteria);
	}

}
