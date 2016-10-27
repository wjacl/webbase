package com.wja.attend.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.wja.attend.entity.Attendance;
import com.wja.base.common.CommRepository;

@Repository
public interface AttendDao extends CommRepository<Attendance, String>
{
    List<Attendance> findByPersonId(String perId);
}
