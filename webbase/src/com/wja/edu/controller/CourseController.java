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
import com.wja.base.util.Page;
import com.wja.base.util.Sort;
import com.wja.base.web.AppContext;
import com.wja.edu.entity.Course;
import com.wja.edu.service.CourseService;

@Controller
@RequestMapping("/course")
public class CourseController
{
    @Autowired
    private CourseService service;
    
    @RequestMapping("manage")
    public String manage(Model model)
    {
        model.addAttribute("treeNodes", JSON.toJSONString(this.service.findAll()));
        return "edu/course";
    }
    
    @RequestMapping("arch")
    public String archManage()
    {
        return "edu/course_arch";
    }
    
    @RequestMapping("nameCheck")
    @ResponseBody
    public boolean nameCheck(String name, String pid)
    {
        return this.service.getByNameAndPid(name, pid) == null;
    }
    
    @RequestMapping({"add", "update"})
    @ResponseBody
    public OpResult save(Course c)
    {
        boolean add = StringUtils.isBlank(c.getId());
        Course ec = this.service.getByNameAndPid(c.getName(), c.getPid());
        if (ec != null && !ec.getId().equals(c.getId()))
        {
            return OpResult.error(AppContext.getMessage("course.name.exits"), c);
        }
        
        this.service.save(c);
        if (add)
        {
            return OpResult.addOk(c);
        }
        else
        {
            return OpResult.updateOk(c);
        }
    }
    
    @RequestMapping("query")
    @ResponseBody
    public Page<Course> pageQuery(@RequestParam Map<String, Object> params, Page<Course> page)
    {
        return this.service.pageQuery(params, page);
    }
    
    @RequestMapping("list")
    @ResponseBody
    public List<Course> query(@RequestParam Map<String, Object> params, Sort sort)
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
