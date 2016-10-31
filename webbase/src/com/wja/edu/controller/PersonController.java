package com.wja.edu.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSON;
import com.wja.base.common.CommConstants;
import com.wja.base.system.entity.User;
import com.wja.base.web.RequestThreadLocal;
import com.wja.edu.service.StudentService;
import com.wja.edu.service.TeacherService;

@Controller
@RequestMapping("/person")
public class PersonController
{
    @Autowired
    private StudentService studentService;
    
    @Autowired
    private TeacherService teacherService;
    
    @RequestMapping("info")
    public String info(Model model)
    {
        User u = RequestThreadLocal.currUser.get();
        Object o = null;
        String res = null;
        if (u.getType().equals(CommConstants.User.TYPE_STUDENT))
        {
            o = this.studentService.getByUserId(u.getId());
            res = "edu/student_reg";
        }
        else if (u.getType().equals(CommConstants.User.TYPE_STAFF))
        {
            o = this.teacherService.getByUserId(u.getId());
            res = "edu/teacher_reg";
        }
        
        model.addAttribute("personData", JSON.toJSONString(o));
        model.addAttribute("personInfo", "yes");
        return res;
    }
}
