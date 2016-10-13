package com.wja.edu.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wja.base.common.CommConstants;
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
            
            User u = this.userService.getUser(dbc.getUserId());
            if (!e.getName().equals(dbc.getName()))
            {
                // 改名字了，用户表中的姓名跟着变
                if (u != null)
                {
                    u.setName(e.getName());
                }
            }
            
            // 教师审核通过，用户状态变为正常
            if (Teacher.STATUS_AT_JOB.equals(e.getStatus()) && Teacher.STATUS_NEED_AUDIT.equals(dbc.getStatus()))
            {
                if (u != null)
                {
                    u.setStatus(CommConstants.User.STATUS_NORMAL);
                }
            }
            
            // 教师离职，删除对应的用户
            if (Teacher.STATUS_AT_JOB.equals(dbc.getStatus()) && Teacher.STATUS_LEAVE.equals(e.getStatus()))
            {
                if (u != null)
                {
                    this.userService.deleteUser(new String[] {u.getId()});
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
