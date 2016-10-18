package com.wja.edu.dao;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.wja.base.common.CommRepository;
import com.wja.edu.entity.MajorCourse;

@Repository
public interface MajorCourseDao extends CommRepository<MajorCourse, String>
{
    @Modifying
    @Query("delete from MajorCourse where majorId = ?1 ")
    void deleteMajorCourse(String majorId);
}
