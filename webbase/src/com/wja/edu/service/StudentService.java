package com.wja.edu.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wja.base.common.CommSpecification;
import com.wja.base.util.BeanUtil;
import com.wja.base.util.CollectionUtil;
import com.wja.base.util.Page;
import com.wja.base.util.Sort;
import com.wja.edu.dao.StudentDao;
import com.wja.edu.entity.Student;

@Service
public class StudentService
{
    @Autowired
    private StudentDao studentDao;
    
    public Student get(String id)
    {
        if (StringUtils.isBlank(id))
        {
            return null;
        }
        
        return this.studentDao.getOne(id);
    }
    
    public void save(Student c)
    {
        if (StringUtils.isNotBlank(c.getId()))
        {
            Student dbc = this.studentDao.getOne(c.getId());
            BeanUtil.copyPropertiesIgnoreNull(c, dbc);
            c = dbc;
        }
        
        this.studentDao.save(c);
    }
    
    public void delete(String[] ids)
    {
        if (!CollectionUtil.isEmpty(ids))
        {
            this.studentDao.logicDeleteInBatch(ids);
        }
    }
    
    public Student getStudentByName(String name)
    {
        Map<String, Object> params = new HashMap<>();
        params.put("name", name);
        List<Student> list = this.studentDao.findAll(new CommSpecification<Student>(params));
        if (CollectionUtil.isEmpty(list))
        {
            return null;
        }
        else
        {
            return list.get(0);
        }
    }
    
    public List<Student> query(Map<String, Object> params, Sort sort)
    {
        return this.studentDao.findAll(new CommSpecification<Student>(params),
            sort == null ? null : sort.getSpringSort());
    }
    
    public Page<Student> pageQuery(Map<String, Object> params, Page<Student> page)
    {
        return page.setPageData(this.studentDao.findAll(new CommSpecification<Student>(params), page.getPageRequest()));
    }
}
