package com.wja.base.system.dao;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.wja.base.common.CommRepository;
import com.wja.base.system.entity.Dict;

@Repository
public interface DictDao extends CommRepository<Dict, String>
{
    @Query("from Dict t where t.pid is null ")
    List<Dict> getRoots();
    
    List<Dict> findByPid(String pid);
}
