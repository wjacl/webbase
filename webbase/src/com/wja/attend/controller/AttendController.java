package com.wja.attend.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wja.attend.entity.Attendance;
import com.wja.attend.service.AttendService;
import com.wja.base.common.OpResult;
import com.wja.base.util.BeanUtil;
import com.wja.base.util.Page;
import com.wja.base.util.Sort;

@Controller
@RequestMapping("/attend")
public class AttendController
{
    @Autowired
    private AttendService service;
    
    @RequestMapping("toAdd")
    public String toAdd()
    {
        return "attend/add";
    }
    
    @RequestMapping("manage")
    public String manage()
    {
        return "attend/attend";
    }
    
    @RequestMapping("update")
    @ResponseBody
    public OpResult save(Attendance c)
    {
        c = this.service.save(c);
        return OpResult.updateOk(c);
        
    }
    
    @RequestMapping({"add"})
    @ResponseBody
    public OpResult add(Attendance c, String[] personId)
    {
        return OpResult.addOk(this.service.add(c, personId));
    }
    
    @RequestMapping("query")
    @ResponseBody
    public Page<Attendance> pageQuery(@RequestParam Map<String, Object> params, Page<Attendance> page)
    {
        this.service.pageQuery(params, page);
        BeanUtil.setCollFieldValues(page.getRows());
        return page;
    }
    
    @RequestMapping("list")
    @ResponseBody
    public List<Attendance> query(@RequestParam Map<String, Object> params, Sort sort)
    {
        List<Attendance> list = this.service.query(params, sort);
        BeanUtil.setCollFieldValues(list);
        return list;
    }
    
    @RequestMapping("delete")
    @ResponseBody
    public OpResult delete(String[] id)
    {
        this.service.delete(id);
        return OpResult.deleteOk();
    }
}
