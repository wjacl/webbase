package com.wja.attend.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wja.attend.dao.AttendDao;
import com.wja.attend.entity.Attendance;
import com.wja.base.common.CommSpecification;
import com.wja.base.util.BeanUtil;
import com.wja.base.util.CollectionUtil;
import com.wja.base.util.Page;
import com.wja.base.util.Sort;
import com.wja.edu.entity.Student;
import com.wja.edu.service.StudentService;

@Service
public class AttendService
{
    @Autowired
    private AttendDao dao;
    
    @Autowired
    private StudentService studentService;
    
    public Object add(Attendance c, String[] perIds)
    {
        if (c == null)
        {
            return null;
        }
        
        if (CollectionUtil.isNotEmpty(perIds) && perIds.length > 1)
        {
            List<Attendance> atts = new ArrayList<>();
            for (String perId : perIds)
            {
                Attendance a = new Attendance();
                BeanUtil.copyProperties(c, a);
                a.setPersonId(perId);
                atts.add(a);
            }
            
            return this.dao.save(atts);
        }
        else
        {
            return this.dao.save(c);
        }
    }
    
    public Attendance get(String id)
    {
        if (StringUtils.isBlank(id))
        {
            return null;
        }
        
        return this.dao.getOne(id);
    }
    
    public List<Attendance> getByPersonId(String perId)
    {
        return this.dao.findByPersonId(perId);
    }
    
    public Attendance save(Attendance e)
    {
        if (StringUtils.isNotBlank(e.getId()))
        {
            Attendance dbc = this.dao.getOne(e.getId());
            BeanUtil.copyPropertiesIgnoreNull(e, dbc);
            e = dbc;
        }
        
        return this.dao.save(e);
    }
    
    public void delete(String[] ids)
    {
        if (!CollectionUtil.isEmpty(ids))
        {
            this.dao.logicDeleteInBatch(ids);
        }
    }
    
    private Map<String, Object> paramsHandle(Map<String, Object> params)
    {
        
        String personIds = (String)params.get("personId_in_string");
        if (StringUtils.isBlank(personIds))
        {
            String clazzId = (String)params.get("clazzId");
            if (StringUtils.isNotBlank(clazzId))
            {
                Map<String, Object> p = new HashMap<>();
                p.put("clazz", clazzId);
                List<Student> sts = studentService.query(p, null);
                if (CollectionUtil.isNotEmpty(sts))
                {
                    List<String> ids = new ArrayList<String>();
                    for (Student st : sts)
                    {
                        ids.add(st.getId());
                    }
                    
                    params.put("personId_in_string", ids);
                }
                else
                {
                    // 班级没有学生，则查询一个不存在的学生，避免查询出非本班的数据
                    params.put("personId", "0");
                }
            }
        }
        
        params.remove("clazzId");
        
        return params;
    }
    
    public List<Attendance> query(Map<String, Object> params, Sort sort)
    {
        return this.dao.findAll(new CommSpecification<Attendance>(paramsHandle(params)),
            sort == null ? null : sort.getSpringSort());
    }
    
    public Page<Attendance> pageQuery(Map<String, Object> params, Page<Attendance> page)
    {
        return page.setPageData(
            this.dao.findAll(new CommSpecification<Attendance>(paramsHandle(params)), page.getPageRequest()));
    }
}
