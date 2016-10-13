package com.wja.edu.dao;

import org.springframework.stereotype.Repository;

import com.wja.base.common.CommRepository;
import com.wja.edu.entity.Student;

@Repository
public interface StudentDao extends CommRepository<Student, String>
{
    Student findByUserId(String userId);
}
