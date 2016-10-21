package com.wja.base.system.service;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wja.base.system.dao.OrgDao;
import com.wja.base.system.entity.Org;
import com.wja.base.util.BeanUtil;
import com.wja.base.util.CollectionUtil;
import com.wja.base.util.Sort;

@Service
public class OrgService
{
    @Autowired
    private OrgDao dao;
    
    public Org save(Org org)
    {
        if (StringUtils.isNotBlank(org.getId()))
        {
            Org temp = this.dao.getOne(org.getId());
            BeanUtil.copyPropertiesIgnoreNull(org, temp);
            org = temp;
        }
        
        return this.dao.save(org);
    }
    
    public Org getByPidAndName(String pid, String name)
    {
        return this.dao.findByPidAndName(pid, name);
    }
    
    /**
     * 
     * 对一个机构下的子机构进行排序
     * 
     * @param orgIds
     * @see [类、类#方法、类#成员]
     */
    public void setOrder(String[] orgIds)
    {
        if (CollectionUtil.isNotEmpty(orgIds))
        {
            Org org = null;
            for (short i = 0; i < orgIds.length; i++)
            {
                org = this.get(orgIds[i]);
                if (org != null)
                {
                    org.setOrdno(i);
                    this.dao.save(org);
                }
            }
        }
    }
    
    public List<Org> findAll()
    {
        Sort sort = new Sort("pid,ordno", "asc,asc");
        return this.dao.findAll(sort.getSpringSort());
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
