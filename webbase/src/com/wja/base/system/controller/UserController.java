package com.wja.base.system.controller;

import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
import com.wja.base.util.BeanUtil;
import com.wja.base.util.CollectionUtil;
import com.wja.base.util.MD5;
import com.wja.base.util.Page;
import com.wja.base.web.AppContext;
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
    
    @RequestMapping("oldPwdCheck")
    @ResponseBody
    public boolean oldPwdCheck(String pwd)
    {
        return RequestThreadLocal.currUser.get().getPassword().equals(MD5.encode(pwd));
    }
    
    @RequestMapping("pwdupdate")
    @ResponseBody
    public Object updatePwd(String oldpassword, String password)
    {
        User user = RequestThreadLocal.currUser.get();
        if (!user.getPassword().equals(MD5.encode(oldpassword)))
        {
            return OpResult.updateError(AppContext.getMessage("user.oldpwd.error"), null);
        }
        
        if (StringUtils.isBlank(password))
        {
            return OpResult.updateError(AppContext.getMessage("user.pwd.notnull"), null);
        }
        
        this.userService.updatePwd(user.getId(), password);
        return OpResult.updateOk();
    }
    
    @RequestMapping(value = "regist", method = RequestMethod.GET)
    public String toRegist()
    {
        return "system/regist";
    }
    
    @RequestMapping(value = "regist", method = RequestMethod.POST)
    public String regist(User user, String clazz, Model model)
    {
        if (this.userService.getUserByUsername(user.getUsername()) != null)
        {
            model.addAttribute("error", AppContext.getMessage(""));
            return "system/regist";
        }
        
        user.setStatus(CommConstants.User.STATUS_NEED_AUDIT);
        model.addAttribute("data", this.userService.addUser(user, clazz));
        
        switch (user.getType())
        {
            case CommConstants.User.TYPE_STUDENT:
                return "edu/student_reg";
            case CommConstants.User.TYPE_STAFF:
                return "edu/teacher_reg";
            case CommConstants.User.TYPE_COMPANY:
                return "edu/company_reg";
        }
        
        return "redirect:login";
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
    public Object addUser(User user, String[] roleIds, String clazz)
    {
        
        if (!CollectionUtil.isEmpty(roleIds))
        {
            Set<Role> roles = new HashSet<>();
            roles.addAll(this.roleDao.findAll(roleIds));
            user.setRoles(roles);
        }
        
        this.userService.addUser(user, clazz);
        
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
        if (!CollectionUtil.isEmpty(roleIds))
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
        this.userService.query(params, page);
        BeanUtil.setCollFieldValues(page.getRows());
        return page;
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
