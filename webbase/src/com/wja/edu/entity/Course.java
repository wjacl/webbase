package com.wja.edu.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Where;

import com.wja.base.common.CommConstants;
import com.wja.base.common.CommEntity;

@Entity
@Table(name = "t_edu_course")
@Where(clause = " valid = " + CommConstants.DATA_VALID)
public class Course extends CommEntity
{
    /**
     * 课程名
     */
    @Column(length = 30, nullable = false)
    private String name;
    
    /**
     * 课时
     */
    private Integer hour;
    
    /**
     * 学分
     */
    private Byte credit;
    
    /**
     * 课程说明
     */
    @Column(length = 300)
    private String descr;
    
    public String getName()
    {
        return name;
    }
    
    public void setName(String name)
    {
        this.name = name;
    }
    
    public Integer getHour()
    {
        return hour;
    }
    
    public void setHour(Integer hour)
    {
        this.hour = hour;
    }
    
    public Byte getCredit()
    {
        return credit;
    }
    
    public void setCredit(Byte credit)
    {
        this.credit = credit;
    }
    
    public String getDescr()
    {
        return descr;
    }
    
    public void setDescr(String descr)
    {
        this.descr = descr;
    }
    
}
