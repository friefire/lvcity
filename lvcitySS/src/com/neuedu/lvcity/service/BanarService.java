package com.neuedu.lvcity.service;

import java.util.List;
import java.util.Map;

import com.neuedu.lvcity.model.Banar;

public interface BanarService {
	
	public int banarCount();
	public List<Banar> findAllBanar(Map<String, Object> map);
	public int addBanar(String imagePath);
	public int updateBanar(Banar banar);
	public int deleteBanar(Banar banar);
	public Banar findOneBanar(Banar banar);
}
