package com.wja.base.system.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wja.base.system.entity.User;
import com.wja.base.system.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController
{
    
    @Autowired
    private UserService userService;
    
    @RequestMapping("add")
    @ResponseBody
    public Object addUser(User user)
    {
        
        this.userService.addUser(user);
        
        return user;
        
    }
}
