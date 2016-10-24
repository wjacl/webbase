package com.wja.edu.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
import com.wja.edu.entity.Course;
import com.wja.edu.entity.MajorCourse;

@Service
public class ClazzService
{
    @Autowired
    private ClazzDao clazzDao;
    
    @Autowired
    private ClazzCourseDao clazzCourseDao;
    
    @Autowired
    private CourseService courseService;
    
    @Autowired
    private MajorService majorService;
    
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
    
    public Clazz save(Clazz c)
    {
        if (StringUtils.isNotBlank(c.getId()))
        {
            Clazz dbc = this.clazzDao.getOne(c.getId());
            BeanUtil.copyPropertiesIgnoreNull(c, dbc);
            c = dbc;
        }
        
        Clazz sc = this.clazzDao.save(c);
        if (StringUtils.isBlank(c.getId()))
        {// 新增，根据专业初始化班级课程
            List<MajorCourse> mcs = this.majorService.getMajorCourse(c.getMajor());
            if (CollectionUtil.isNotEmpty(mcs))
            {
                List<ClazzCourse> ccs = new ArrayList<>();
                Calendar cal = Calendar.getInstance();
                cal.setTime(c.getStartTime());
                int dayLessions = 6;
                short ordno = 0;
                int leftHour = 0;
                for (MajorCourse mc : mcs)
                {
                    Course cour = mc.getCourse();
                    ClazzCourse cc = new ClazzCourse();
                    cc.setClazzId(sc.getId());
                    cc.setCourse(cour);
                    cc.setOrdno(ordno++);
                    Date finishTime = cal.getTime();
                    cc.setStartTime(finishTime);
                    for (int i = 0; i < (cour.getHour() + dayLessions - 1) / dayLessions; i++)
                    {
                        cal.add(Calendar.DATE, 1);
                        // TODO
                    }
                }
            }
        }
        return sc;
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
