package com.wja.base.system.dao;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.Repository;

import com.wja.base.system.entity.Dict;

@org.springframework.stereotype.Repository
public interface DictDao extends Repository<Dict, String>
{
    @Query("from Dict t where t.pid is null ")
    List<Dict> getRoots();
}
