package com.wja.base.system.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wja.base.system.entity.User;
import com.wja.base.system.service.UserService;
import com.wja.base.util.Page;

@Controller
@RequestMapping("/user")
public class UserController
{
    
    @Autowired
    private UserService userService;
    
    @RequestMapping("mana")
    public String manage(){
    	return "system/user";
    }
    
    @RequestMapping("add")
    @ResponseBody
    public Object addUser(User user)
    {
        
        this.userService.addUser(user);
        
        return user;
        
    }
    
    @RequestMapping("query")
    @ResponseBody
    public Object query(Page<User> page){
    	return this.userService.query(null, page);
    }
}
