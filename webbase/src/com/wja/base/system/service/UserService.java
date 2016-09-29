package com.wja.base.system.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wja.base.common.service.CommService;
import com.wja.base.system.dao.UserDao;
import com.wja.base.system.entity.Privilege;
import com.wja.base.system.entity.User;
import com.wja.base.util.MD5;

@Service
public class UserService extends CommService<User>
{
    
    @Autowired
    private UserDao userDao;
    
    public User getUserByUsername(String username)
    {
        return this.userDao.getUserByUsername(username);
    }
    
    @Override
    public void add(User user)
    {
        addUser(user);
    }
    
    public void addUser(User user)
    {
        if (user == null)
        {
            return;
        }
        
        user.setPassword(MD5.encode(user.getPassword()));
        this.commDao.save(user);
    }
    
    public List<Privilege> getUserPrivileges(String id)
    {
        return this.userDao.getUserPrivileges(id);
    }
    
}
