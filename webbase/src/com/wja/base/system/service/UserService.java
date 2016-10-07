package com.wja.base.system.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wja.base.common.CommSpecification;
import com.wja.base.system.dao.UserDao;
import com.wja.base.system.entity.Privilege;
import com.wja.base.system.entity.User;
import com.wja.base.util.BeanUtil;
import com.wja.base.util.MD5;
import com.wja.base.util.Page;

@Service
public class UserService
{
    
    @Autowired
    private UserDao userDao;
    
    public User getUserByUsername(String username)
    {
        return this.userDao.getUserByUsername(username);
    }
    
    public void deleteUser(String[] ids)
    {
        this.userDao.logicDeleteInBatch(ids);
    }
    
    public void updateUser(User user)
    {
        if (user == null || user.getId() == null)
        {
            return;
        }
        
        User dbUser = this.userDao.findOne(user.getId());
        if (!dbUser.getPassword().equals(user.getPassword()))
        {
            user.setPassword(MD5.encode(user.getPassword()));
        }
        
        BeanUtil.copyPropertiesIgnoreNull(user, dbUser);
        this.userDao.save(dbUser);
    }
    
    public void addUser(User user)
    {
        if (user == null)
        {
            return;
        }
        
        user.setPassword(MD5.encode(user.getPassword()));
        this.userDao.save(user);
    }
    
    public List<Privilege> getUserPrivileges(String id)
    {
        return this.userDao.getUserPrivileges(id);
    }
    
    public Page<User> query(Map<String, Object> params, Page<User> page)
    {
        return page.setPageData(this.userDao.findAll(new CommSpecification<User>(params), page.getPageRequest()));
    }
}