package com.wja.edu.service;

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
import com.wja.edu.dao.CourseDao;
import com.wja.edu.entity.Course;

@Service
public class CourseService
{
    @Autowired
    private CourseDao dao;
    
    public Course get(String id)
    {
        if (StringUtils.isBlank(id))
        {
            return null;
        }
        
        return this.dao.getOne(id);
    }
    
    public Course getByName(String name)
    {
        if (StringUtils.isBlank(name))
        {
            return null;
        }
        return this.dao.findByName(name);
    }
    
    public List<Course> find(String[] ids)
    {
        return this.dao.findAll(ids);
    }
    
    public void save(Course e)
    {
        if (StringUtils.isNotBlank(e.getId()))
        {
            Course dbc = this.dao.getOne(e.getId());
            BeanUtil.copyPropertiesIgnoreNull(e, dbc);
            e = dbc;
        }
        
        this.dao.save(e);
    }
    
    public void delete(String id)
    {
        if (StringUtils.isNotBlank(id))
        {
            this.dao.logicDelete(id);
        }
    }
    
    public void delete(String[] ids)
    {
        if (!CollectionUtil.isEmpty(ids))
        {
            this.dao.logicDeleteInBatch(ids);
        }
    }
    
    public List<Course> query(Map<String, Object> params, Sort sort)
    {
        return this.dao.findAll(new CommSpecification<Course>(params), sort == null ? null : sort.getSpringSort());
    }
    
    public Page<Course> pageQuery(Map<String, Object> params, Page<Course> page)
    {
        return page.setPageData(this.dao.findAll(new CommSpecification<Course>(params), page.getPageRequest()));
    }
}
