package com.wja.edu.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Where;

import com.wja.base.common.CommConstants;
import com.wja.base.common.CommEntity;

@Entity
@Table(name = "t_edu_major")
@Where(clause = " valid = " + CommConstants.DATA_VALID)
public class Major extends CommEntity
{
    @Column(length = 30)
    private String name;
    
    @Column(length = 300)
    private String descr;
    
    private Short ordno;
    
    public String getName()
    {
        return name;
    }
    
    public void setName(String name)
    {
        this.name = name;
    }
    
    public String getDescr()
    {
        return descr;
    }
    
    public void setDescr(String descr)
    {
        this.descr = descr;
    }
    
    public Short getOrdno()
    {
        return ordno;
    }
    
    public void setOrdno(Short ordno)
    {
        this.ordno = ordno;
    }
    
}
