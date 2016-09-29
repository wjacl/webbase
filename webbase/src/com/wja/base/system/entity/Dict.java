package com.wja.base.system.entity;

import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Where;

import com.wja.base.common.CommConstants;
import com.wja.base.common.CommEntity;

/**
 * 
 * 系统数据字典实例
 * 
 * @author wja
 * @version [v1.0, 2016年9月26日]
 * @see [相关类/方法]
 * @since [产品/模块版本]
 */
@Entity
@Table(name = "t_sys_dict")
@Where(clause = " valid = " + CommConstants.DATA_VALID)
public class Dict extends CommEntity
{
    @Column(length = 20, nullable = false)
    private String text;
    
    @Column(length = 32)
    private String pid;
    
    @OneToMany
    @JoinColumn(name = "pid")
    @Where(clause = " valid = " + CommConstants.DATA_VALID)
    private Set<Dict> children;
    
    /**
     * 字典类型:s系统字典，b业务字典
     */
    @Column(length = 1, nullable = false)
    private String type = "b";
    
    public String getText()
    {
        return text;
    }
    
    public void setText(String text)
    {
        this.text = text;
    }
    
    public String getPid()
    {
        return pid;
    }
    
    public void setPid(String pid)
    {
        this.pid = pid;
    }
    
    public Set<Dict> getChildren()
    {
        return children;
    }
    
    public void setChildren(Set<Dict> children)
    {
        this.children = children;
    }
    
    public String getType()
    {
        return type;
    }
    
    public void setType(String type)
    {
        this.type = type;
    }
    
}
