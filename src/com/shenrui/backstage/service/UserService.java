package com.shenrui.backstage.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shenrui.backstage.bean.PageBean;
import com.shenrui.backstage.bean.UserDetileInfoBean;
import com.shenrui.backstage.dao.UserAuthsDao;
import com.shenrui.backstage.dao.UserDao;
import com.shenrui.backstage.dao.UserOnlineInfoDao;
import com.shenrui.backstage.vo.UserAuthsBean;
import com.shenrui.backstage.vo.UserBean;
import com.shenrui.backstage.vo.UserOnlineInfoBean;


@Transactional
@Service("userService")
public class UserService {
	//Service中注入Dao
	@Autowired
	@Qualifier("userDao")
	private UserDao userDao;
	
	@Autowired
	@Qualifier("userAuthsDao")
	private UserAuthsDao userAuthsDao;
	
	@Autowired
	@Qualifier("userOnlineInfoDao")
	private UserOnlineInfoDao userOnlineInfoDao;
	
	public PageBean<UserDetileInfoBean> findByPage(int page) {
        PageBean<UserDetileInfoBean> pageBean =new PageBean<UserDetileInfoBean>();
        pageBean.setPage(page);
        int limit=10;
        pageBean.setLimit(limit);
        int totalCount=userDao.findTotalCount();
        
//        System.out.println("订单总数: " + totalCount);
//        System.out.println("总ye数: " + totalCount/Float.parseFloat(String.valueOf(limit)));
        
        pageBean.setTotalCount(totalCount);
        
        int totalpage=(int)Math.ceil(totalCount/Float.parseFloat(String.valueOf(limit)));
        pageBean.setTotalPage(totalpage);
        //每页显示的数据集合
        int begin=(page-1)*limit;
        List<UserBean> list=userDao.findByPageId(begin,limit);
        //封装用户详细信息
        List<UserDetileInfoBean> UDIBlist = new ArrayList<UserDetileInfoBean>();
        for(UserBean u : list){
        	UserAuthsBean uab = null;
        	UserOnlineInfoBean uoib = null;
        	uab = userAuthsDao.findById(u.getId());
        	uoib = userOnlineInfoDao.findById(u.getId());
        	
        	UserDetileInfoBean udib = new UserDetileInfoBean();
        	udib.setBalance(u.getBalance());
        	udib.setId(u.getId());
        	udib.setIntegral(u.getIntegral());
        	udib.setInvite_code(u.getInvite_code());
        	udib.setNick_name(u.getNick_name());
        	udib.setRegist_time(u.getRegist_time());
        	udib.setSex(u.getSex());
        	udib.setTmp_balance(u.getTmp_balance());
        	
        	if(uab == null){
        		udib.setIdentifier("");
            	udib.setIdentity_type("");
            	udib.setIdentifier("");
            	udib.setIdentity_type("");
        	}else{
        		udib.setIdentifier(uab.getIdentifier());
        		udib.setIdentity_type(uab.getIdentity_type());
        		udib.setIdentifier(uab.getIdentifier());
        		udib.setIdentity_type(uab.getIdentity_type());
        	}
        	
        	if(uoib == null){
        		udib.setLast_login_device_id("");
        		udib.setLast_login_device_model("");
        		udib.setLast_login_ip("");
        		udib.setLast_login_time("");
        	}else{
        		udib.setLast_login_device_id(uoib.getLast_login_device_id());
        		udib.setLast_login_device_model(uoib.getLast_login_device_model());
        		udib.setLast_login_ip(uoib.getLast_login_ip());
        		udib.setLast_login_time(uoib.getLast_login_time());
        	}
        	
        	UDIBlist.add(udib);
        }
        pageBean.setList(UDIBlist);
        return pageBean;
    }
}
