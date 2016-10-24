package com.wja.edu.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Where;
import org.springframework.format.annotation.DateTimeFormat;

import com.alibaba.fastjson.annotation.JSONField;
import com.wja.base.common.CommConstants;
import com.wja.base.common.CommEntity;
import com.wja.base.util.DateUtil;
import com.wja.base.util.SetValue;

@Entity
@Table(name = "t_edu_class_course")
@Where(clause = " valid = " + CommConstants.DATA_VALID)
public class ClazzCourse extends CommEntity
{
    @Column(name = "class_id", length = 32)
    private String clazzId;
    
    @OneToOne
    @JoinColumn(name = "course_id")
    private Course course;
    
    private Short ordno;
    
    /**
     * 开始时间
     */
    @DateTimeFormat(pattern = DateUtil.DATE)
    @JSONField(format = DateUtil.DATE)
    private Date startTime;
    
    /**
     * 完成时间
     */
    @DateTimeFormat(pattern = DateUtil.DATE)
    @JSONField(format = DateUtil.DATE)
    private Date finishTime;
    
    /**
     * 授课老师
     */
    @Column(length = 32)
    private String teacher;
    
    @Transient
    @SetValue(id = "teacher", clazz = Teacher.class, field = "name")
    private String teacherName;
    
    /**
     * 课程完成状态
     */
    @Column(length = 32)
    private String status;
    
    public Course getCourse()
    {
        return course;
    }
    
    public void setCourse(Course course)
    {
        this.course = course;
    }
    
    public Short getOrdno()
    {
        return ordno;
    }
    
    public void setOrdno(Short ordno)
    {
        this.ordno = ordno;
    }
    
    public String getClazzId()
    {
        return clazzId;
    }
    
    public void setClazzId(String clazzId)
    {
        this.clazzId = clazzId;
    }
    
    public Date getStartTime()
    {
        return startTime;
    }
    
    public void setStartTime(Date startTime)
    {
        this.startTime = startTime;
    }
    
    public Date getFinishTime()
    {
        return finishTime;
    }
    
    public void setFinishTime(Date finishTime)
    {
        this.finishTime = finishTime;
    }
    
    public String getStatus()
    {
        return status;
    }
    
    public void setStatus(String status)
    {
        this.status = status;
    }
    
    public String getTeacher()
    {
        return teacher;
    }
    
    public void setTeacher(String teacher)
    {
        this.teacher = teacher;
    }
    
    public String getTeacherName()
    {
        return teacherName;
    }
    
    public void setTeacherName(String teacherName)
    {
        this.teacherName = teacherName;
    }
    
}
