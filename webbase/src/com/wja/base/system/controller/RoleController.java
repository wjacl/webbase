package com.wja.base.system.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wja.base.common.OpResult;
import com.wja.base.system.dao.RoleDao;
import com.wja.base.system.entity.Role;
import com.wja.base.util.Page;

@Controller
@RequestMapping("/role")
public class RoleController
{
    @Autowired
    private RoleDao dao;
    
    @RequestMapping("manage")
    public String manage()
    {
        return "system/role";
    }
    
    @RequestMapping("query")
    @ResponseBody
    public Object query(Page<Role> page)
    {
        
        return page.setPageData(this.dao.findAll(null, page.getPageRequest()));
    }
    
    @RequestMapping("get")
    @ResponseBody
    public Object get(String id)
    {
        return this.dao.getOne(id);
    }
    
    @RequestMapping("delete")
    @ResponseBody
    public Object delete(String id)
    {
        this.dao.logicDelete(id);
        return OpResult.deleteOk();
    }
    
    @RequestMapping("add")
    @ResponseBody
    public OpResult add(Role role)
    {
        this.dao.save(role);
        return OpResult.addOk(role);
    }
    
    @RequestMapping("update")
    @ResponseBody
    public OpResult update(Role role)
    {
        this.dao.save(role);
        return OpResult.updateOk(role);
    }
    
}
