package com.wja.edu.service;

import java.util.ArrayList;
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
import com.wja.edu.dao.MajorCourseDao;
import com.wja.edu.dao.MajorDao;
import com.wja.edu.entity.Course;
import com.wja.edu.entity.Major;
import com.wja.edu.entity.MajorCourse;

@Service
public class MajorService
{
    @Autowired
    private MajorDao dao;
    
    @Autowired
    private MajorCourseDao mcDao;
    
    @Autowired
    private CourseService courseService;
    
    public Major get(String id)
    {
        if (StringUtils.isBlank(id))
        {
            return null;
        }
        
        return this.dao.getOne(id);
    }
    
    public List<MajorCourse> getMajorCourse(String majorId)
    {
        return StringUtils.isBlank(majorId) ? null : this.mcDao.findByMajorIdOrderByOrdnoAsc(majorId);
    }
    
    public void updateMajorCourse(String majorId, String[] courseIds)
    {
        if (StringUtils.isBlank(majorId))
        {
            return;
        }
        
        this.mcDao.deleteMajorCourse(majorId);
        
        if (CollectionUtil.isNotEmpty(courseIds))
        {
            List<MajorCourse> mcs = new ArrayList<>();
            short ordno = 1;
            for (String cid : courseIds)
            {
                if (StringUtils.isNotBlank(cid))
                {
                    Course c = this.courseService.get(cid);
                    if (c != null)
                    {
                        MajorCourse mc = new MajorCourse();
                        mc.setMajorId(majorId);
                        mc.setOrdno(ordno++);
                        mc.setCourse(c);
                        mcs.add(mc);
                    }
                }
            }
            if (mcs.size() > 0)
            {
                this.mcDao.save(mcs);
            }
        }
    }
    
    public List<Major> findAll()
    {
        Sort sort = new Sort("ordno", "asc");
        return this.dao.findAll(sort.getSpringSort());
    }
    
    public Major getByName(String name)
    {
        if (StringUtils.isBlank(name))
        {
            return null;
        }
        return this.dao.findByName(name);
    }
    
    public List<Major> find(String[] ids)
    {
        return this.dao.findAll(ids);
    }
    
    public Major save(Major e)
    {
        if (StringUtils.isNotBlank(e.getId()))
        {
            Major dbc = this.dao.getOne(e.getId());
            BeanUtil.copyPropertiesIgnoreNull(e, dbc);
            e = dbc;
        }
        
        return this.dao.save(e);
    }
    
    public void delete(String id)
    {
        if (StringUtils.isNotBlank(id))
        {
            this.dao.logicDelete(id);
            this.mcDao.deleteMajorCourse(id);
        }
    }
    
    public void delete(String[] ids)
    {
        if (!CollectionUtil.isEmpty(ids))
        {
            this.dao.logicDeleteInBatch(ids);
            for (String id : ids)
            {
                this.mcDao.deleteMajorCourse(id);
            }
        }
        
    }
    
    public List<Major> query(Map<String, Object> params, Sort sort)
    {
        return this.dao.findAll(new CommSpecification<Major>(params), sort == null ? null : sort.getSpringSort());
    }
    
    public Page<Major> pageQuery(Map<String, Object> params, Page<Major> page)
    {
        return page.setPageData(this.dao.findAll(new CommSpecification<Major>(params), page.getPageRequest()));
    }
}
