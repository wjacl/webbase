package com.wja.base.system.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wja.base.system.dao.OrgDao;
import com.wja.base.system.entity.Org;
import com.wja.base.util.BeanUtil;

@Service
public class OrgService
{
    @Autowired
    private OrgDao dao;
    
    public void save(Org org)
    {
        if (org.getId() != null)
        {
            Org temp = this.dao.getOne(org.getId());
            BeanUtil.copyPropertiesIgnoreNull(org, temp);
            org = temp;
        }
        
        this.dao.save(org);
    }
    
    public List<Org> findAll()
    {
        return this.dao.findAll();
    }
    
    public void delete(String[] ids)
    {
        this.dao.logicDeleteInBatch(ids);
    }
    
    public Org get(String id)
    {
        return this.dao.getOne(id);
    }
}
