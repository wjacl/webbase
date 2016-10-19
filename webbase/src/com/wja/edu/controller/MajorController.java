package com.wja.edu.controller;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.wja.base.common.OpResult;
import com.wja.base.util.Sort;
import com.wja.base.web.AppContext;
import com.wja.edu.entity.Major;
import com.wja.edu.service.CourseService;
import com.wja.edu.service.MajorService;

@Controller
@RequestMapping("/major")
public class MajorController
{
    @Autowired
    private MajorService service;
    
    @Autowired
    private CourseService courseService;
    
    @RequestMapping("manage")
    public String manage(Model model)
    {
        model.addAttribute("treeNodes", JSON.toJSONString(this.service.findAll()));
        model.addAttribute("courseTreeNodes", JSON.toJSONString(this.courseService.findAll()));
        return "edu/major";
    }
    
    @RequestMapping("nameCheck")
    @ResponseBody
    public boolean nameCheck(String name, String pid)
    {
        return this.service.getByName(name) == null;
    }
    
    @RequestMapping("getMajorCourse")
    @ResponseBody
    public Object getMajorCourse(String majorId)
    {
        return this.service.getMajorCourse(majorId);
    }
    
    @RequestMapping("setCourse")
    @ResponseBody
    public OpResult setCourse(String majorId, String[] courseIds)
    {
        this.service.updateMajorCourse(majorId, courseIds);
        return OpResult.ok();
    }
    
    @RequestMapping({"add", "update"})
    @ResponseBody
    public OpResult save(Major c)
    {
        boolean add = StringUtils.isBlank(c.getId());
        Major ec = this.service.getByName(c.getName());
        if (ec != null && !ec.getId().equals(c.getId()))
        {
            return OpResult.error(AppContext.getMessage("Major.name.exits"), c);
        }
        
        c = this.service.save(c);
        if (add)
        {
            return OpResult.addOk(c);
        }
        else
        {
            return OpResult.updateOk(c);
        }
    }
    
    @RequestMapping("list")
    @ResponseBody
    public List<Major> query(@RequestParam Map<String, Object> params, Sort sort)
    {
        return this.service.query(params, sort);
    }
    
    @RequestMapping("delete")
    @ResponseBody
    public OpResult delete(String[] ids)
    {
        this.service.delete(ids);
        return OpResult.deleteOk();
    }
}
