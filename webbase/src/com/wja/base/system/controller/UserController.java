package com.wja.base.system.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.wja.base.common.OpResult;
import com.wja.base.system.entity.User;
import com.wja.base.system.service.UserService;
import com.wja.base.util.Page;
import com.wja.base.web.RequestThreadLocal;

@Controller
@RequestMapping("/user")
public class UserController
{
    
    @Autowired
    private UserService userService;
    
    @RequestMapping("mana")
    public String manage()
    {
        return "system/user";
    }
    
    @RequestMapping("add")
    @ResponseBody
    public Object addUser(User user)
    {
        
        this.userService.addUser(user);
        
        return OpResult.addOk();
        
    }
    
    @RequestMapping("remove")
    @ResponseBody
    public Object removeUser(String[] id)
    {
        this.userService.deleteUser(id);
        return OpResult.deleteOk();
    }
    
    @RequestMapping("update")
    @ResponseBody
    public Object updateUser(User user)
    {
        this.userService.updateUser(user);
        return OpResult.updateOk();
    }
    
    @RequestMapping("query")
    @ResponseBody
    public Object query(String params, Page<User> page)
    {
        Map<String, Object> paramMap = JSON.parseObject(params, Map.class);
        return this.userService.query(paramMap, page);
    }
    
    @RequestMapping("privs")
    @ResponseBody
    public Object getCurrUserPrivTree()
    {
        User user = RequestThreadLocal.currUser.get();
        if (user == null)
        {
            return null;
        }
        else
        {
            return this.userService.getUserPrivileges(user.getId());
        }
    }
}
