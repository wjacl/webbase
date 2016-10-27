package com.wja.attend.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Index;
import javax.persistence.Table;

import org.hibernate.annotations.Where;
import org.springframework.format.annotation.DateTimeFormat;

import com.alibaba.fastjson.annotation.JSONField;
import com.wja.base.common.CommConstants;
import com.wja.base.common.CommEntity;
import com.wja.base.util.DateUtil;

@Entity
@Table(name = "t_attend_attendance", indexes = @Index(columnList = "per_id") )
@Where(clause = " valid = " + CommConstants.DATA_VALID)
public class Attendance extends CommEntity
{
    @Column(name = "per_id", length = 32, nullable = false)
    private String personId;
    
    /**
     * 人员类别
     */
    @Column(name = "per_type", length = 1)
    private String personType;
    
    /**
     * 考勤类别：1迟到、2早退、3旷工（课）、4事假、5病假、6调休、7、年休、8、加班
     */
    @Column(length = 10)
    private String type;
    
    /**
     * 事由
     */
    @Column(length = 200)
    private String reason;
    
    /**
     * 备注
     */
    @Column(length = 200)
    private String remark;
    
    /**
     * 时长：小时
     */
    private Float length;
    
    /**
     * 开始时间
     */
    @DateTimeFormat(pattern = DateUtil.DATE_MINUTE)
    @JSONField(format = DateUtil.DATE_MINUTE)
    private Date startTime;
    
    /**
     * 结束时间
     */
    @DateTimeFormat(pattern = DateUtil.DATE_MINUTE)
    @JSONField(format = DateUtil.DATE_MINUTE)
    private Date endTime;
    
    /**
     * 0待审核、1通过、2未通过
     */
    @Column(length = 1)
    private String status;
    
    public String getPersonId()
    {
        return personId;
    }
    
    public void setPersonId(String personId)
    {
        this.personId = personId;
    }
    
    public String getPersonType()
    {
        return personType;
    }
    
    public void setPersonType(String personType)
    {
        this.personType = personType;
    }
    
    public String getType()
    {
        return type;
    }
    
    public void setType(String type)
    {
        this.type = type;
    }
    
    public String getRemark()
    {
        return remark;
    }
    
    public void setRemark(String remark)
    {
        this.remark = remark;
    }
    
    public Float getLength()
    {
        return length;
    }
    
    public void setLength(Float length)
    {
        this.length = length;
    }
    
    public Date getStartTime()
    {
        return startTime;
    }
    
    public void setStartTime(Date startTime)
    {
        this.startTime = startTime;
    }
    
    public Date getEndTime()
    {
        return endTime;
    }
    
    public void setEndTime(Date endTime)
    {
        this.endTime = endTime;
    }
    
    public String getStatus()
    {
        return status;
    }
    
    public void setStatus(String status)
    {
        this.status = status;
    }
    
    public String getReason()
    {
        return reason;
    }
    
    public void setReason(String reason)
    {
        this.reason = reason;
    }
    
}
