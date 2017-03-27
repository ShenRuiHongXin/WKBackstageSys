package com.shenrui.backstage.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;

import com.shenrui.backstage.vo.SysOperatorBean;

@Repository("sysOperatorDao")
public class SysOperatorDao {
	@Autowired
	@Qualifier("hibernateTemplate")
	private HibernateTemplate hibernateTemplate;

	// 增
	public void save(SysOperatorBean sysOperatorBean) {
		System.out.println("Dao层执行了");
		hibernateTemplate.save(sysOperatorBean);
	}

	// 删
	public void delete(SysOperatorBean sysOperatorBean) {
		System.out.println("Dao层执行了 delete");
		hibernateTemplate.delete(sysOperatorBean);
	}

	// 改
	public void update(SysOperatorBean sysOperatorBean) {
		System.out.println("Dao层执行了 delete");
		hibernateTemplate.update(sysOperatorBean);
	}

	// 查
	public List<SysOperatorBean> findByName(DetachedCriteria criteria){
		return hibernateTemplate.findByCriteria(criteria);
	}
}
