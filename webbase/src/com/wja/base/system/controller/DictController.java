package com.wja.base.system.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wja.base.common.OpResult;
import com.wja.base.system.entity.Dict;
import com.wja.base.system.service.DictService;

@Controller
@RequestMapping("/dict")
public class DictController
{
    @Autowired
    private DictService ds;
    
    @RequestMapping("main")
    public String toMain()
    {
        return "system/dict";
    }
    
    @RequestMapping("tree")
    @ResponseBody
    public List<Dict> getRoots(String id)
    {
        return this.ds.getAll();
    }
    
    @RequestMapping("get")
    @ResponseBody
    public List<Dict> getByPid(String pid)
    {
        return this.ds.getByPid(pid);
    }
    
    @RequestMapping("save")
    @ResponseBody
    public Object save(Dict dict)
    {
        OpResult res = null;
        if (dict.getId() == null)
        {
            this.ds.add(dict);
            return OpResult.addOk(dict.getId());
        }
        else
        {
            this.ds.update(dict);
            return OpResult.updateOk();
        }
    }
    
    @RequestMapping("remove")
    @ResponseBody
    public Object remove(String[] ids)
    {
        if (ids != null && ids.length > 0)
        {
            this.ds.delete(Dict.class, ids);
        }
        
        return OpResult.deleteOk();
    }
    
}
