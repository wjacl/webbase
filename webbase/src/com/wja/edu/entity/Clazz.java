package com.wja.edu.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import org.hibernate.annotations.Where;
import org.springframework.format.annotation.DateTimeFormat;

import com.alibaba.fastjson.annotation.JSONField;
import com.wja.base.common.CommConstants;
import com.wja.base.common.CommEntity;
import com.wja.base.util.DateUtil;

@Entity
@Table(name = "t_edu_class")
@Where(clause = " valid = " + CommConstants.DATA_VALID)
public class Clazz extends CommEntity
{
    public static final String STATUS_NOT_START = "notStart";
    
    public static final String STATUS_STARTED = "started";
    
    public static final String STATUS_FINISHED = "finished";
    
    /**
     * 班级名
     */
    @Column(length = 20, nullable = false)
    private String name;
    
    /**
     * 专业
     */
    @Column(length = 32)
    private String major;
    
    /**
     * 开班时间
     */
    @DateTimeFormat(pattern = DateUtil.DATE)
    @JSONField(format = DateUtil.DATE)
    private Date startTime;
    
    /**
     * 毕业时间
     */
    @DateTimeFormat(pattern = DateUtil.DATE)
    @JSONField(format = DateUtil.DATE)
    private Date finishTime;
    
    /**
     * 班级状态 未开班、已开班、已毕业
     */
    @Column(length = 32)
    private String status;
    
    /**
     * 校区
     */
    @Column(length = 32)
    private String school;
    
    /**
     * 班主任id
     */
    @Column(length = 32)
    private String admin;
    
    public String getName()
    {
        return name;
    }
    
    public void setName(String name)
    {
        this.name = name;
    }
    
    public Date getStartTime()
    {
        return startTime;
    }
    
    public void setStartTime(Date startTime)
    {
        this.startTime = startTime;
    }
    
    public String getStatus()
    {
        return status;
    }
    
    public void setStatus(String status)
    {
        this.status = status;
    }
    
    public String getAdmin()
    {
        return admin;
    }
    
    public void setAdmin(String admin)
    {
        this.admin = admin;
    }
    
    public Date getFinishTime()
    {
        return finishTime;
    }
    
    public void setFinishTime(Date finishTime)
    {
        this.finishTime = finishTime;
    }
    
    public String getMajor()
    {
        return major;
    }
    
    public void setMajor(String major)
    {
        this.major = major;
    }
    
    public String getSchool()
    {
        return school;
    }
    
    public void setSchool(String school)
    {
        this.school = school;
    }
    
}
