package com.wja.edu.dao;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.wja.base.common.CommRepository;
import com.wja.edu.entity.ClazzCourse;

@Repository
public interface ClazzCourseDao extends CommRepository<ClazzCourse, String>
{
    @Modifying
    @Query("delete from ClazzCourse where clazzId = ?1 ")
    void deleteClazzCourse(String clazzId);
    
    List<ClazzCourse> findByClazzIdOrderByOrdnoAsc(String clazzId);
}
