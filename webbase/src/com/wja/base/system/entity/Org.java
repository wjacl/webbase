package com.wja.base.system.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Where;

import com.wja.base.common.CommConstants;
import com.wja.base.common.CommEntity;

@Entity
@Table(name = "t_sys_org")
@Where(clause = " valid = " + CommConstants.DATA_VALID)
public class Org extends CommEntity
{
    @Column(length = 32, nullable = false)
    private String name;
    
    /**
     * 父结构id
     */
    @Column(length = 32)
    private String pid;
    
    public String getName()
    {
        return name;
    }
    
    public void setName(String name)
    {
        this.name = name;
    }
    
    public String getPid()
    {
        return pid;
    }
    
    public void setPid(String pid)
    {
        this.pid = pid;
    }
    
}
