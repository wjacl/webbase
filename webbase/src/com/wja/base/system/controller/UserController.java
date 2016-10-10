package com.wja.base.system.controller;

import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wja.base.common.CommConstants;
import com.wja.base.common.OpResult;
import com.wja.base.system.dao.RoleDao;
import com.wja.base.system.entity.Role;
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
    
    @Autowired
    private RoleDao roleDao;
    
    @RequestMapping("mana")
    public String manage()
    {
        return "system/user";
    }
    
    @RequestMapping(value = "regist", method = RequestMethod.GET)
    public String toRegist()
    {
        return "system/regist";
    }
    
    @RequestMapping(value = "regist", method = RequestMethod.POST)
    @ResponseBody
    public Object regist(User user)
    {
        if (this.userService.getUserByUsername(user.getUsername()) != null)
        {
            return OpResult.error("unameExits", null);
        }
        
        user.setStatus(CommConstants.User.STATUS_LOCK);
        this.userService.addUser(user);
        
        return OpResult.ok();
    }
    
    @RequestMapping("unameCheck")
    @ResponseBody
    public boolean checkUsername(String username)
    {
        User user = this.userService.getUserByUsername(username);
        return user == null;
    }
    
    @RequestMapping("add")
    @ResponseBody
    public Object addUser(User user, String[] roleIds)
    {
        
        if (roleIds != null && roleIds.length > 1)
        {
            Set<Role> roles = new HashSet<>();
            roles.addAll(this.roleDao.findAll(roleIds));
            user.setRoles(roles);
        }
        
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
    public Object updateUser(User user, String[] roleIds)
    {
        if (roleIds != null && roleIds.length > 0)
        {
            Set<Role> roles = new HashSet<>();
            roles.addAll(this.roleDao.findAll(roleIds));
            user.setRoles(roles);
        }
        this.userService.updateUser(user);
        return OpResult.updateOk();
    }
    
    @RequestMapping("query")
    @ResponseBody
    public Object query(@RequestParam Map<String, Object> params, Page<User> page)
    {
        return this.userService.query(params, page);
    }
    
    @RequestMapping("find")
    @ResponseBody
    public List<User> find(@RequestParam Map<String, Object> params)
    {
        return this.userService.query(params);
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
    
    @RequestMapping("roles")
    @ResponseBody
    public Object getCurrUserRoles()
    {
        User user = RequestThreadLocal.currUser.get();
        user = this.userService.getUser(user.getId());
        Set<Role> roles = this.roleDao.findByCreateUser(user.getId());
        roles.addAll(user.getRoles());
        return roles;
    }
}
