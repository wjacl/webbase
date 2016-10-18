package com.wja.edu.dao;

import org.springframework.stereotype.Repository;

import com.wja.base.common.CommRepository;
import com.wja.edu.entity.Course;

@Repository
public interface CourseDao extends CommRepository<Course, String>
{
    Course findByNameAndPid(String name, String pid);
}
