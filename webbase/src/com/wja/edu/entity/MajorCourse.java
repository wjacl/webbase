package com.wja.edu.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Where;

import com.wja.base.common.CommConstants;
import com.wja.base.common.CommEntity;

@Entity
@Table(name = "t_edu_major_course")
@Where(clause = " valid = " + CommConstants.DATA_VALID)
public class MajorCourse extends CommEntity
{
    @Column(name = "major_id", length = 32)
    private String majorId;
    
    @OneToOne
    @JoinColumn(name = "course_id")
    private Course course;
    
    private Short ordno;
    
    public String getMajorId()
    {
        return majorId;
    }
    
    public void setMajorId(String majorId)
    {
        this.majorId = majorId;
    }
    
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
    
}
