package com.wja.edu.dao;

import org.springframework.stereotype.Repository;

import com.wja.base.common.CommRepository;
import com.wja.edu.entity.Major;

@Repository
public interface MajorDao extends CommRepository<Major, String>
{
    Major findByName(String name);
}
