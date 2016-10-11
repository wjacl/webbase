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
@Table(name = "t_edu_student")
@Where(clause = " valid = " + CommConstants.DATA_VALID)
public class Student extends CommEntity
{
    /**
     * 学生对应的用户id
     */
    @Column(name = "user_id", length = 32)
    private String userId;
    
    // 学生个人信息
    @Column(length = 30, nullable = false)
    private String name;
    
    @Column(length = 1)
    private String sex;
    
    @DateTimeFormat(pattern = DateUtil.DATE)
    @JSONField(format = DateUtil.DATE)
    private Date birthday;
    
    @Column(length = 20)
    private String qq;
    
    @Column(length = 40)
    private String email;
    
    @Column(length = 40)
    private String phone;
    
    @Column(length = 60)
    private String address;
    
    /**
     * 所在班级
     */
    @Column(length = 32)
    private String clazz;
    
    /**
     * 学历
     */
    @Column(length = 10)
    private String education;
    
    /**
     * 专业
     */
    @Column(length = 30)
    private String major;
    
    /**
     * 毕业院校
     */
    @Column(length = 60)
    private String school;
    
    /**
     * 毕业时间
     */
    @Column(name = "grad_time")
    @DateTimeFormat(pattern = DateUtil.DATE)
    @JSONField(format = DateUtil.DATE)
    private Date graduateTime;
    
    /**
     * 父母姓名
     */
    @Column(length = 40)
    private String parent;
    
    /**
     * 家庭住址
     */
    @Column(length = 80)
    private String home;
    
    /**
     * 家庭联系电话
     */
    @Column(name = "home_phone", length = 40)
    private String homePhone;
    
    /**
     * 状态：标识是否审核通过
     */
    @Column(name = "audit_sta", length = 1)
    private String auditStatus = CommConstants.AUDIT_STATUS_WAIT;
    
    public String getAuditStatus()
    {
        return this.auditStatus;
    }
    
    public void setAuditStatus(String auditStatus)
    {
        this.auditStatus = auditStatus;
    }
    
    public String getUserId()
    {
        return userId;
    }
    
    public void setUserId(String userId)
    {
        this.userId = userId;
    }
    
    public String getName()
    {
        return name;
    }
    
    public void setName(String name)
    {
        this.name = name;
    }
    
    public String getSex()
    {
        return sex;
    }
    
    public void setSex(String sex)
    {
        this.sex = sex;
    }
    
    public Date getBirthday()
    {
        return birthday;
    }
    
    public void setBirthday(Date birthday)
    {
        this.birthday = birthday;
    }
    
    public String getQq()
    {
        return qq;
    }
    
    public void setQq(String qq)
    {
        this.qq = qq;
    }
    
    public String getEmail()
    {
        return email;
    }
    
    public void setEmail(String email)
    {
        this.email = email;
    }
    
    public String getPhone()
    {
        return phone;
    }
    
    public void setPhone(String phone)
    {
        this.phone = phone;
    }
    
    public String getAddress()
    {
        return address;
    }
    
    public void setAddress(String address)
    {
        this.address = address;
    }
    
    public String getClazz()
    {
        return clazz;
    }
    
    public void setClazz(String clazz)
    {
        this.clazz = clazz;
    }
    
    public String getEducation()
    {
        return education;
    }
    
    public void setEducation(String education)
    {
        this.education = education;
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
    
    public Date getGraduateTime()
    {
        return graduateTime;
    }
    
    public void setGraduateTime(Date graduateTime)
    {
        this.graduateTime = graduateTime;
    }
    
    public String getParent()
    {
        return parent;
    }
    
    public void setParent(String parent)
    {
        this.parent = parent;
    }
    
    public String getHome()
    {
        return home;
    }
    
    public void setHome(String home)
    {
        this.home = home;
    }
    
    public String getHomePhone()
    {
        return homePhone;
    }
    
    public void setHomePhone(String homePhone)
    {
        this.homePhone = homePhone;
    }
    
}
