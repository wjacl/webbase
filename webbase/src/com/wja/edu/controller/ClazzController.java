package com.wja.edu.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wja.base.common.OpResult;
import com.wja.base.util.Page;
import com.wja.base.util.Sort;
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
    
    @RequestMapping("registGet")
    @ResponseBody
    public List<Clazz> registsGet()
    {
        Map<String, Object> params = new HashMap<>();
        params.put("status_in", new String[] {Clazz.STATUS_NOT_START, Clazz.STATUS_STARTED});
        return this.clazzService.query(params, Sort.desc("startTime"));
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
    public Page<Clazz> pageQuery(@RequestParam Map<String, Object> params, Page<Clazz> page)
    {
        return this.clazzService.pageQuery(params, page);
    }
    
    @RequestMapping("list")
    @ResponseBody
    public List<Clazz> pageQuery(@RequestParam Map<String, Object> params, Sort sort)
    {
        return this.clazzService.query(params, sort);
    }
    
    @RequestMapping("delete")
    @ResponseBody
    public OpResult delete(String[] id)
    {
        this.clazzService.delete(id);
        return OpResult.deleteOk();
    }
}
