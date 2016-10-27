package com.wja.attend.service;

import java.util.ArrayList;
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

@Service
public class AttendService
{
    @Autowired
    private AttendDao dao;
    
    public Object add(Attendance c, String[] perIds)
    {
        if (c == null)
        {
            return null;
        }
        
        if (CollectionUtil.isNotEmpty(perIds))
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
    
    public List<Attendance> query(Map<String, Object> params, Sort sort)
    {
        return this.dao.findAll(new CommSpecification<Attendance>(params), sort == null ? null : sort.getSpringSort());
    }
    
    public Page<Attendance> pageQuery(Map<String, Object> params, Page<Attendance> page)
    {
        return page.setPageData(this.dao.findAll(new CommSpecification<Attendance>(params), page.getPageRequest()));
    }
}
