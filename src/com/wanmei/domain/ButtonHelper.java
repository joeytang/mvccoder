package com.wanmei.domain;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class ButtonHelper {

	public static final byte TYPE_ADD = 1;
	public static final byte TYPE_EDIT = 2;
	public static final byte TYPE_DEL = 3;
	public static final byte TYPE_VIEW = 4;
	public static final byte TYPE_DELMORE = 5;
	
	public static Map<Byte,String> typeMap = new LinkedHashMap<Byte,String>();
    static {
    	typeMap.put(TYPE_ADD, "添加");
    	typeMap.put(TYPE_EDIT, "修改");
    	typeMap.put(TYPE_DEL, "删除");
    	typeMap.put(TYPE_VIEW, "详情");
    	typeMap.put(TYPE_DELMORE, "批量删除");
    }
    public static List<Button> defaultButtons = new ArrayList<Button>();
	static { 
		Button bCreate = new Button();
		bCreate.setFunction("create");
		bCreate.setLabel(typeMap.get(TYPE_ADD));
		bCreate.setType(TYPE_ADD);
		defaultButtons.add(bCreate);
		
		Button bEdit = new Button();
		bEdit.setFunction("edit");
		bEdit.setLabel(typeMap.get(TYPE_EDIT));
		bEdit.setType(TYPE_EDIT);
		defaultButtons.add(bEdit);
		
		Button bDel = new Button();
		bDel.setFunction("remove");
		bDel.setLabel(typeMap.get(TYPE_DEL));
		bDel.setType(TYPE_DEL);
		defaultButtons.add(bDel);
		
		Button bView = new Button();
		bView.setFunction("view");
		bView.setLabel(typeMap.get(TYPE_VIEW));
		bView.setType(TYPE_VIEW);
		defaultButtons.add(bView);
		
		Button bDelMore = new Button();
		bDelMore.setFunction("removeMore");
		bDelMore.setLabel(typeMap.get(TYPE_DELMORE));
		bDelMore.setType(TYPE_DELMORE);
		defaultButtons.add(bDelMore);
	}
	
}
