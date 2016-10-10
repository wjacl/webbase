package com.wja.edu.controller;

import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wja.base.common.OpResult;
import com.wja.base.util.Page;
import com.wja.edu.entity.Clazz;
import com.wja.edu.service.ClazzService;

@Controller
@RequestMapping("/clazz")
public class ClazzController
{
    @Autowired
    private ClazzService clazzService;
    
    @RequestMapping("manage")
    public String manage()
    {
        return "edu/clazz";
    }
    
    @RequestMapping("nameExits")
    @ResponseBody
    public boolean nameExits(String name)
    {
        return this.clazzService.getClazzByName(name) == null;
    }
    
    @RequestMapping({"add", "update"})
    @ResponseBody
    public OpResult save(Clazz c)
    {
        boolean add = StringUtils.isBlank(c.getId());
        this.clazzService.save(c);
        if (add)
        {
            return OpResult.addOk(c.getId());
        }
        else
        {
            return OpResult.updateOk();
        }
    }
    
    @RequestMapping("query")
    @ResponseBody
    public Page<Clazz> save(@RequestParam Map<String, Object> params, Page<Clazz> page)
    {
        return this.clazzService.pageQuery(params, page);
    }
    
    @RequestMapping("delete")
    @ResponseBody
    public OpResult delete(String[] id)
    {
        this.clazzService.delete(id);
        return OpResult.deleteOk();
    }
}
