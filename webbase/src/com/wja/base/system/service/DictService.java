package com.wja.base.system.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wja.base.common.service.CommService;
import com.wja.base.system.dao.DictDao;
import com.wja.base.system.entity.Dict;

@Service
public class DictService extends CommService<Dict>
{
    @Autowired
    private DictDao dictDao;
    
    public List<Dict> getRoots()
    {
        return this.dictDao.getRoots();
    }
    
    @Override
    public void update(Dict dict)
    {
        Dict temp = this.get(Dict.class, dict.getId());
        temp.setName(dict.getName());
        this.dictDao.save(temp);
    }
    
    public List<Dict> getByPid(String pid)
    {
        return this.dictDao.findByPid(pid);
    }
    
    public List<Dict> getAll()
    {
        return this.dictDao.findAll();
    }
}
