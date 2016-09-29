package com.wja.base.system.controller;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
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
        return "system/dict/main";
    }
    
    @RequestMapping("getTree")
    @ResponseBody
    public List<Dict> getRoots()
    {
        return this.ds.getRoots();
    }
    
    @RequestMapping("get")
    @ResponseBody
    public List<Dict> getByPid(String pid){
    	return this.ds.getByPid(pid);
    }
    
    @RequestMapping("add")
    @ResponseBody
    public Object add(Dict dict)
    {
        this.ds.add(dict);
        return OpResult.addOk(dict);
    }
    
    @RequestMapping("remove")
    @ResponseBody
    public Object remove(String ids)
    {
        if (StringUtils.isNotBlank(ids))
        {
            String[] idarray = ids.split(",");
            this.ds.delete(Dict.class, idarray);
        }
        
        return OpResult.deleteOk();
    }
    
    @RequestMapping("update")
    @ResponseBody
    public Object update(Dict dict)
    {
        this.ds.update(dict);
        return OpResult.updateOk();
    }
}
