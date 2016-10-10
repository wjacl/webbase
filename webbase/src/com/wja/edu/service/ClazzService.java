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
import com.wja.edu.dao.ClazzDao;
import com.wja.edu.entity.Clazz;

@Service
public class ClazzService
{
    @Autowired
    private ClazzDao clazzDao;
    
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
    
    public Page<Clazz> pageQuery(Map<String, Object> params, Page<Clazz> page)
    {
        return page.setPageData(this.clazzDao.findAll(new CommSpecification<Clazz>(params), page.getPageRequest()));
    }
}
