package com.wja.base.system.entity;

import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Where;

import com.wja.base.common.CommConstants;
import com.wja.base.common.CommEntity;
import com.wja.base.util.SetValue;

/**
 * 
 * 系统用户表
 * 
 * @author wja
 * @version [v1.0, 2016年9月22日]
 * @see [相关类/方法]
 * @since [产品/模块版本]
 */
@Entity
@Table(name = "t_sys_user")
@Where(clause = " valid = " + CommConstants.DATA_VALID)
public class User extends CommEntity
{
    @Transient
    @SetValue(clazz = User.class, id = "createUser", field = "name")
    private String createUserName;
    
    @Column(length = 20, nullable = false)
    private String username;
    
    @Column(length = 32, nullable = false)
    private String password;
    
    /**
     * 姓名
     */
    @Column(length = 30)
    private String name;
    
    /**
     * 用户类别
     */
    @Column(length = 1, nullable = false)
    private String type;
    
    /**
     * 用户状态
     * 
     * @see CommConstants.User
     */
    @Column(length = 1, nullable = false)
    private String status = CommConstants.User.STATUS_NORMAL;
    
    @ManyToMany
    @JoinTable(name = "t_sys_user_role", joinColumns = {@JoinColumn(name = "u_id")}, inverseJoinColumns = {
        @JoinColumn(name = "r_id")})
    private Set<Role> roles;
    
    public String getUsername()
    {
        return username;
    }
    
    public void setUsername(String username)
    {
        this.username = username;
    }
    
    public String getPassword()
    {
        return password;
    }
    
    public void setPassword(String password)
    {
        this.password = password;
    }
    
    public String getName()
    {
        return name;
    }
    
    public void setName(String name)
    {
        this.name = name;
    }
    
    public String getType()
    {
        return type;
    }
    
    public void setType(String type)
    {
        this.type = type;
    }
    
    public Set<Role> getRoles()
    {
        return roles;
    }
    
    public void setRoles(Set<Role> roles)
    {
        this.roles = roles;
    }
    
    public String getStatus()
    {
        return status;
    }
    
    public void setStatus(String status)
    {
        this.status = status;
    }
    
    public String getCreateUserName()
    {
        return createUserName;
    }
    
    public void setCreateUserName(String createUserName)
    {
        this.createUserName = createUserName;
    }
    
}
