package com.wja.edu.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wja.base.common.CommSpecification;
import com.wja.base.system.entity.User;
import com.wja.base.system.service.UserService;
import com.wja.base.util.BeanUtil;
import com.wja.base.util.CollectionUtil;
import com.wja.base.util.Page;
import com.wja.base.util.Sort;
import com.wja.edu.dao.TeacherDao;
import com.wja.edu.entity.Teacher;

@Service
public class TeacherService
{
    @Autowired
    private TeacherDao dao;
    
    @Autowired
    private UserService userService;
    
    public Teacher get(String id)
    {
        if (StringUtils.isBlank(id))
        {
            return null;
        }
        
        return this.dao.getOne(id);
    }
    
    public Teacher getByUserId(String userId)
    {
        return this.dao.findByUserId(userId);
    }
    
    public void save(Teacher e)
    {
        if (StringUtils.isNotBlank(e.getId()))
        {
            Teacher dbc = this.dao.getOne(e.getId());
            if (!e.getName().equals(dbc.getName()))
            {
                // 该名字了，用户表中的姓名跟着变
                User u = this.userService.getUser(dbc.getUserId());
                if (u != null)
                {
                    u.setName(e.getName());
                }
            }
            BeanUtil.copyPropertiesIgnoreNull(e, dbc);
            e = dbc;
        }
        
        this.dao.save(e);
    }
    
    public void delete(String[] ids)
    {
        if (!CollectionUtil.isEmpty(ids))
        {
            // 删除对应的用户数据
            List<Teacher> list = this.dao.findAll(ids);
            String[] uids = new String[list.size()];
            int i = 0;
            for (Teacher s : list)
            {
                uids[i++] = s.getUserId();
            }
            this.userService.deleteUser(uids);
            this.dao.logicDeleteInBatch(ids);
        }
    }
    
    public List<Teacher> query(Map<String, Object> params, Sort sort)
    {
        return this.dao.findAll(new CommSpecification<Teacher>(params), sort == null ? null : sort.getSpringSort());
    }
    
    public Page<Teacher> pageQuery(Map<String, Object> params, Page<Teacher> page)
    {
        return page.setPageData(this.dao.findAll(new CommSpecification<Teacher>(params), page.getPageRequest()));
    }
}
