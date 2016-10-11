package com.wja.edu.dao;

import org.springframework.stereotype.Repository;

import com.wja.base.common.CommRepository;
import com.wja.edu.entity.Teacher;

@Repository
public interface TeacherDao extends CommRepository<Teacher, String>
{

}
