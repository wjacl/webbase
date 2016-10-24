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
import com.wja.edu.dao.ClazzCourseDao;
import com.wja.edu.dao.ClazzDao;
import com.wja.edu.entity.Clazz;
import com.wja.edu.entity.ClazzCourse;

@Service
public class ClazzService
{
    @Autowired
    private ClazzDao clazzDao;
    
    @Autowired
    private ClazzCourseDao clazzCourseDao;
    
    @Autowired
    private CourseService courseService;
    
    public Clazz get(String id)
    {
        return this.clazzDao.getOne(id);
    }
    
    public List<ClazzCourse> getClazzCourse(String clazzId)
    {
        if (StringUtils.isBlank(clazzId))
        {
            return null;
        }
        
        return this.clazzCourseDao.findByClazzIdOrderByOrdnoAsc(clazzId);
    }
    
    public void saveClazzCourse(String clazzId, List<ClazzCourse> courses)
    {
        this.clazzCourseDao.deleteClazzCourse(clazzId);
        if (CollectionUtil.isNotEmpty(courses))
        {
            for (ClazzCourse cc : courses)
            {
                cc.setCourse(this.courseService.get(cc.getCourse().getId()));
            }
            this.clazzCourseDao.save(courses);
        }
    }
    
    public void save(Clazz c)
    {
        if (StringUtils.isNotBlank(c.getId()))
        {
            Clazz dbc = this.clazzDao.getOne(c.getId());
            BeanUtil.copyPropertiesIgnoreNull(c, dbc);
            c = dbc;
        }
        
        this.clazzDao.save(c);
    }
    
    public void delete(String[] ids)
    {
        if (!CollectionUtil.isEmpty(ids))
        {
            this.clazzDao.logicDeleteInBatch(ids);
        }
    }
    
    public Clazz getClazzByName(String name)
    {
        Map<String, Object> params = new HashMap<>();
        params.put("name", name);
        List<Clazz> list = this.clazzDao.findAll(new CommSpecification<Clazz>(params));
        if (CollectionUtil.isEmpty(list))
        {
            return null;
        }
        else
        {
            return list.get(0);
        }
    }
    
    public List<Clazz> query(Map<String, Object> params, Sort sort)
    {
        return this.clazzDao.findAll(new CommSpecification<Clazz>(params), sort == null ? null : sort.getSpringSort());
    }
    
    public Page<Clazz> pageQuery(Map<String, Object> params, Page<Clazz> page)
    {
        return page.setPageData(this.clazzDao.findAll(new CommSpecification<Clazz>(params), page.getPageRequest()));
    }
}
