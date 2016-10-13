package com.wja.edu.service;

import java.util.HashMap;
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
import com.wja.edu.dao.StudentDao;
import com.wja.edu.entity.Student;

@Service
public class StudentService
{
    @Autowired
    private StudentDao studentDao;
    
    @Autowired
    private UserService userService;
    
    public Student get(String id)
    {
        if (StringUtils.isBlank(id))
        {
            return null;
        }
        
        return this.studentDao.getOne(id);
    }
    
    public Student getByUserId(String userId)
    {
        return this.studentDao.findByUserId(userId);
    }
    
    public void save(Student c)
    {
        if (StringUtils.isNotBlank(c.getId()))
        {
            Student dbc = this.studentDao.getOne(c.getId());
            
            User u = this.userService.getUser(dbc.getUserId());
            if (!c.getName().equals(dbc.getName()))
            {
                // 改名字了，用户表中的姓名跟着变
                if (u != null)
                {
                    u.setName(c.getName());
                }
            }
            
            // 学生审核通过，用户状态变为正常
            if (Student.STATUS_IN_LEARNING.equals(c.getStatus()) && Student.STATUS_NEED_AUDIT.equals(dbc.getStatus()))
            {
                if (u != null)
                {
                    u.setStatus(CommConstants.User.STATUS_NORMAL);
                }
            }
            
            // 学生毕业、辍学，删除对应的用户
            if (Student.STATUS_IN_LEARNING.equals(dbc.getStatus()) && !Student.STATUS_IN_LEARNING.equals(c.getStatus())
                && !Student.STATUS_NEED_AUDIT.equals(c.getStatus()))
            {
                if (u != null)
                {
                    this.userService.deleteUser(new String[] {u.getId()});
                }
            }
            
            BeanUtil.copyPropertiesIgnoreNull(c, dbc);
            c = dbc;
        }
        
        this.studentDao.save(c);
    }
    
    public void delete(String[] ids)
    {
        if (!CollectionUtil.isEmpty(ids))
        {
            // 删除对应的用户数据
            List<Student> list = this.studentDao.findAll(ids);
            String[] uids = new String[list.size()];
            int i = 0;
            for (Student s : list)
            {
                uids[i++] = s.getUserId();
            }
            this.userService.deleteUser(uids);
            // 删除学生
            this.studentDao.logicDeleteInBatch(ids);
        }
    }
    
    public Student getStudentByName(String name)
    {
        Map<String, Object> params = new HashMap<>();
        params.put("name", name);
        List<Student> list = this.studentDao.findAll(new CommSpecification<Student>(params));
        if (CollectionUtil.isEmpty(list))
        {
            return null;
        }
        else
        {
            return list.get(0);
        }
    }
    
    public List<Student> query(Map<String, Object> params, Sort sort)
    {
        return this.studentDao.findAll(new CommSpecification<Student>(params),
            sort == null ? null : sort.getSpringSort());
    }
    
    public Page<Student> pageQuery(Map<String, Object> params, Page<Student> page)
    {
        return page.setPageData(this.studentDao.findAll(new CommSpecification<Student>(params), page.getPageRequest()));
    }
}
