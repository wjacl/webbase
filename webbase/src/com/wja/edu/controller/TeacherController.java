package com.wja.edu.controller;

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
import com.wja.edu.entity.Teacher;
import com.wja.edu.service.TeacherService;

@Controller
@RequestMapping("/teacher")
public class TeacherController
{
    @Autowired
    private TeacherService service;
    
    @RequestMapping("manage")
    public String manage()
    {
        return "edu/teacher";
    }
    
    @RequestMapping({"add", "update"})
    @ResponseBody
    public OpResult save(Teacher c)
    {
        boolean add = StringUtils.isBlank(c.getId());
        this.service.save(c);
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
    public Page<Teacher> pageQuery(@RequestParam Map<String, Object> params, Page<Teacher> page)
    {
        return this.service.pageQuery(params, page);
    }
    
    @RequestMapping("list")
    @ResponseBody
    public List<Teacher> query(@RequestParam Map<String, Object> params, Sort sort)
    {
        return this.service.query(params, sort);
    }
    
    @RequestMapping("delete")
    @ResponseBody
    public OpResult delete(String[] id)
    {
        this.service.delete(id);
        return OpResult.deleteOk();
    }
}
