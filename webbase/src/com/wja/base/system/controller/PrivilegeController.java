package com.wja.base.system.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wja.base.system.entity.Privilege;
import com.wja.base.system.service.PrivilegeService;

@Controller
@RequestMapping("/priv")
public class PrivilegeController {

	@Autowired
	private PrivilegeService ps;
	
	@RequestMapping("add")
	@ResponseBody
	public Object add(Privilege p){
		//this.ps.addPrivilege(p);
		this.ps.add(p);
		return p;
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public Object delete(String id){
		//this.ps.deletePrivilege(id);
		this.ps.delete(Privilege.class,id);
		return this.ps.get(Privilege.class,id);
	}
	
	@RequestMapping("get")
	@ResponseBody
	public Object get(String id){
		return this.ps.get(Privilege.class,id);
	}
	
}
