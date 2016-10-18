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
     * 数据类型：t:分类,c:课程
     */
    @Column(length = 1)
    private String type;
    
    @Column(length = 32)
    private String pid;
    
    /**
     * 课程说明
     */
    @Column(length = 300)
    private String descr;
    
    private Integer ordno;
    
    public String getPid()
    {
        return pid;
    }
    
    public void setPid(String pid)
    {
        this.pid = pid;
    }
    
    public Integer getOrdno()
    {
        return ordno;
    }
    
    public void setOrdno(Integer ordno)
    {
        this.ordno = ordno;
    }
    
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
    
    public String getType()
    {
        return type;
    }
    
    public void setType(String type)
    {
        this.type = type;
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
