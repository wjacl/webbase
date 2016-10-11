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
import com.wja.edu.entity.Student;
import com.wja.edu.service.StudentService;

@Controller
@RequestMapping("/student")
public class StudentController
{
    @Autowired
    private StudentService studentService;
    
    @RequestMapping("manage")
    public String manage()
    {
        return "edu/student";
    }
    
    @RequestMapping({"add", "update"})
    @ResponseBody
    public OpResult save(Student c)
    {
        boolean add = StringUtils.isBlank(c.getId());
        this.studentService.save(c);
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
    public Page<Student> pageQuery(@RequestParam Map<String, Object> params, Page<Student> page)
    {
        return this.studentService.pageQuery(params, page);
    }
    
    @RequestMapping("list")
    @ResponseBody
    public List<Student> query(@RequestParam Map<String, Object> params, Sort sort)
    {
        return this.studentService.query(params, sort);
    }
    
    @RequestMapping("delete")
    @ResponseBody
    public OpResult delete(String[] id)
    {
        this.studentService.delete(id);
        return OpResult.deleteOk();
    }
}
