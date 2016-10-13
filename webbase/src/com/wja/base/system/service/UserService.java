package com.wja.base.system.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wja.base.common.CommConstants;
import com.wja.base.common.CommSpecification;
import com.wja.base.system.dao.UserDao;
import com.wja.base.system.entity.Privilege;
import com.wja.base.system.entity.User;
import com.wja.base.util.BeanUtil;
import com.wja.base.util.MD5;
import com.wja.base.util.Page;
import com.wja.edu.entity.Clazz;
import com.wja.edu.entity.Student;
import com.wja.edu.entity.Teacher;
import com.wja.edu.service.ClazzService;
import com.wja.edu.service.StudentService;
import com.wja.edu.service.TeacherService;

@Service
public class UserService
{
    
    @Autowired
    private UserDao userDao;
    
    @Autowired
    private StudentService studentService;
    
    @Autowired
    private TeacherService teacherService;
    
    @Autowired
    private ClazzService clazzService;
    
    public User getUser(String id)
    {
        return this.userDao.getOne(id);
    }
    
    public User getUserByUsername(String username)
    {
        return this.userDao.getUserByUsername(username);
    }
    
    public void deleteUser(String[] ids)
    {
        List<User> users = this.userDao.findAll(ids);
        if (users != null && users.size() > 0)
        {
            for (User u : users)
            {
                u.setRoles(null);
                u.setValid(CommConstants.DATA_INVALID);
            }
            
            this.userDao.save(users);
        }
    }
    
    public void updatePwd(String id, String pwd)
    {
        User user = this.userDao.findOne(id);
        if (user != null)
        {
            user.setPassword(MD5.encode(pwd));
            this.userDao.save(user);
        }
    }
    
    public void updateUser(User user)
    {
        if (user == null || user.getId() == null)
        {
            return;
        }
        
        User dbUser = this.userDao.findOne(user.getId());
        if (!dbUser.getPassword().equals(user.getPassword()))
        {
            user.setPassword(MD5.encode(user.getPassword()));
        }
        
        BeanUtil.copyPropertiesIgnoreNull(user, dbUser);
        
        if (user.getRoles() == null)
        {
            dbUser.setRoles(null);
        }
        
        this.userDao.save(dbUser);
    }
    
    public void addUser(User user, String clazz)
    {
        if (user == null)
        {
            return;
        }
        
        user.setPassword(MD5.encode(user.getPassword()));
        this.userDao.save(user);
        
        // 学生-增加学生记录
        if (CommConstants.User.TYPE_STUDENT.equals(user.getType()))
        {
            Clazz c = this.clazzService.get(clazz);
            Student s = new Student();
            s.setClazz(clazz);
            s.setLearnMajor(c.getMajor());
            s.setStartTime(c.getStartTime());
            s.setUserId(user.getId());
            s.setName(user.getName());
            s.setStatus(Student.STATUS_NEED_AUDIT);
            studentService.save(s);
        }
        else if (CommConstants.User.TYPE_STAFF.equals(user.getType()))
        {
            // 教师-增加教师记录
            Teacher t = new Teacher();
            t.setUserId(user.getId());
            t.setName(user.getName());
            t.setStatus(Teacher.STATUS_NEED_AUDIT);
            teacherService.save(t);
        }
    }
    
    public List<Privilege> getUserPrivileges(String id)
    {
        return this.userDao.getUserPrivileges(id);
    }
    
    public Page<User> query(Map<String, Object> params, Page<User> page)
    {
        return page.setPageData(this.userDao.findAll(new CommSpecification<User>(params), page.getPageRequest()));
    }
    
    public List<User> query(Map<String, Object> params)
    {
        return this.userDao.findAll(new CommSpecification<User>(params));
    }
}
