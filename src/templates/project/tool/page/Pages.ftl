package ${project.org}.tool.paging;

import java.io.IOException;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyTagSupport;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 分页标签基本类
 */
@SuppressWarnings("serial")
public class Pages extends BodyTagSupport {
	
	@Override
	public int doStartTag() {
		if (null == commonList || !(commonList instanceof CommonList)) {
			return EVAL_PAGE;
		}
		CommonList cl = (CommonList) commonList;

		if (null != uri)
			cl.setUri(uri);
		if (null != target)
			cl.setTarget(target);
		if (model == 1) {
			pagesModel = new PagesModel1();
		} else if (model == 2) {
			pagesModel = new PagesModel2();
		} else if (model == 3) {
			pagesModel = new PagesModel3();
		} else if (model == 4) {
			pagesModel = new PagesModel4();
		} else if (model == 5) {
			pagesModel = new PagesModel5();
		} else if (model == 6) {
			pagesModel = new PagesModel6();
		} else if (model == 7) {
			pagesModel = new PagesModel7();
		} else if (model == 8) {
			pagesModel = new PagesModel8();
		} else if (model == 10) {
			pagesModel = new PagesModel10();
		} else if (model == 11) {
			pagesModel = new PagesModel11();
		} else {
			pagesModel = new PagesModel1();
		}
		op = checkOp(op);
		String pagestr = pagesModel.genPageHtml(cl, pageNum, op);
		try {
			JspWriter writer = pageContext.getOut();
			writer.write(pagestr);
		} catch (IOException e) {
			e.printStackTrace(System.err);
		}
		return EVAL_PAGE;
	}

	public int getModel() {
		return model;
	}

	public void setModel(int model) {
		this.model = model;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public Object getCommonList() {
		return commonList;
	}

	public void setCommonList(Object commonList) {
		this.commonList = commonList;
	}

	public String getUri() {
		return uri;
	}

	public void setUri(String uri) {
		this.uri = uri;
	}

	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	public String getOp() {
		return op;
	}

	public void setOp(String op) {
		this.op = op;
	}

	private String checkOp(String op) {
		if (null == op || op.trim().length() == 0) {
			op = "html";
			return op;
		}
		op = op.trim();
		if(!op.equals("html") && !op.equals("replace") && !op.equals("prepend") && !op.equals("append") && !op.equals("before") && !op.equals("after")){
			op = "html";
		}
		return op;
	}

	private String value = null;
	// 限制每屏显示的页码个数 ，如：上一页 1 2 3 4 5 下一页该值表示中间显示多少个页码
	private int pageNum = 5;
	// 显示类型
	private int model = 2;
	// 分页属性
	private Object commonList;
	// 将分页内容进行操作 参考jquery的内容操作方法：html,replace,prepend,append,after,before
	private String op;
	// 分页策略
	private PagesModel pagesModel;

	private String uri;

	private String target;

}
