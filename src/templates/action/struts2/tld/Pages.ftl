package ${project.org}.tool.tags.component;

import com.opensymphony.xwork2.util.ValueStack;

import ${project.org}.tool.paging.CommonList;

import org.apache.struts2.components.Component;

import java.io.IOException;
import java.io.Writer;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * struts实现分页标签
 */
public class Pages extends Component {

    public Pages(ValueStack arg0) {
        super(arg0);
    }

    @Override
    public boolean start(Writer writer) {
        boolean result = super.start(writer);

        //从ValueStack中取出数值
        Object obj = findValue(value);

        if (obj != null && obj instanceof CommonList) {
            CommonList cl = (CommonList) obj;

            StringBuffer buffer = new StringBuffer();
            if (model == 1) {

                buffer.append("共[" + cl.pageNo + "/" + cl.pageNum + "]页" + "&nbsp;");
                if (cl.pageNo == 1) {
                    buffer.append("第一页" + "&nbsp;");
                    buffer.append("上一页" + "&nbsp;");
                } else if (cl.pageNo > 1) {
                    buffer.append("<a href=\"JavaScript:tunePage(" + 1 + ",'','" + cl.searchStr + "')\">第一页</a>" + "&nbsp;");
                    buffer.append("<a href=\"JavaScript:tunePage(" + (cl.pageNo - 1) + ",'','" + cl.searchStr + "')\">上一页</a>" + "&nbsp;");
                }
                if (cl.pageNo == cl.pageNum) {
                    buffer.append("下一页" + "&nbsp;");
                    buffer.append("最末页" + "&nbsp;");
                } else if (cl.pageNo < cl.pageNum) {
                    buffer.append("<a href=\"JavaScript:tunePage(" + (cl.pageNo + 1) + ",'','" + cl.searchStr + "')\">下一页</a>" + "&nbsp;");
                    buffer.append("<a href=\"JavaScript:tunePage(" + cl.pageNum + ",'','" + cl.searchStr + "')\">最末页</a>" + "&nbsp;");
                }

            } else if (model == 2) {
                buffer.append("共有[" + cl.recNum + "]条记录，" + cl.pageNo + "/" + cl.pageNum + "页。");
                if (cl.pageNo > 1) {
                    //---------------------------------
                    // 当前页不是第一页，
                    // 还要加入第一页和上一页标签
                    //---------------------------------
                    buffer.append(" <a href=\"JavaScript:tunePage(" + 1 + ",'','" + cl.searchStr + "')\">&#8249;</a>");
                    buffer.append(" <a href=\"JavaScript:tunePage(" + (cl.pageNo - 1) + ",'','" + cl.searchStr + "')\">&laquo;</a>");
                }

                //---------------------------------
                // 如果当前页大于每页显示页码数。
                // 则要显示快速向上翻的标签(标签是：...)
                //---------------------------------
                int currentNum = (cl.pageNo % pageNum == 0 ? (cl.pageNo / pageNum) - 1 : (int) (cl.pageNo / pageNum)) * pageNum;
                if (currentNum < 0) currentNum = 0;
                if (cl.pageNo > pageNum) {
                    buffer.append(" <a href=\"JavaScript:tunePage(" + (currentNum - pageNum + 1) + ",'','" + cl.searchStr + "')\">...</a>");
                }

                //---------------------------------
                // 显示中间可用的翻页码
                //---------------------------------
                for (int i = 0; i < pageNum; i++) {
                    if ((currentNum + i + 1) > cl.pageNum || cl.pageNum < 2) break;
                    buffer.append(" <a href=\"JavaScript:tunePage(" + (currentNum + i + 1) + ",'','" + cl.searchStr + "')\">");
                    buffer.append(currentNum + i + 1 == cl.pageNo ? "<b>" + (currentNum + i + 1) + "</b>" : (currentNum + i + 1) + "");
                    buffer.append("</a>");
                }

                //---------------------------------
                // 如果还未到达最后一版，
                // 则还要加入快速向下翻的标签(标签是：...)
                //---------------------------------
                if (cl.pageNum > (currentNum + pageNum)) {
                    buffer.append(" <a href=\"JavaScript:tunePage(" + (currentNum + 1 + pageNum) + ",'','" + cl.searchStr + "')\">...</a>");
                }

                //---------------------------------
                // 如果当前页不是最后一页，
                // 则要加入下一页和最后一页标筌
                //---------------------------------
                if (cl.pageNo < cl.pageNum) {
                    buffer.append(" <a href=\"JavaScript:tunePage(" + (cl.pageNo + 1) + ",'','" + cl.searchStr + "')\">&raquo;</a>");
                    buffer.append(" <a href=\"JavaScript:tunePage(" + cl.pageNum + ",'','" + cl.searchStr + "')\">&#8250;</a>");

                }
            } else if (model == 3) {
                buffer.append("共[" + cl.pageNo + "/" + cl.pageNum + "]页" + "&nbsp;");
                if (cl.pageNo == 1) {
                    buffer.append("第一页" + "&nbsp;");
                    buffer.append("上一页" + "&nbsp;");
                } else if (cl.pageNo > 1) {
                    buffer.append(" <a href=\"JavaScript:tunePage(" + 1 + ",'','" + cl.searchStr + "')\">第一页</a>" + "&nbsp;");
                    buffer.append(" <a href=\"JavaScript:tunePage(" + (cl.pageNo - 1) + ",'','" + cl.searchStr + "')\">上一页</a>" + "&nbsp;");
                }
                int currentNum = (cl.pageNo % pageNum == 0 ? (cl.pageNo / pageNum) - 1 : (int) (cl.pageNo / pageNum)) * pageNum;
                if (currentNum < 0) currentNum = 0;

                //---------------------------------
                // 显示中间可用的翻页码
                //---------------------------------
                for (int i = 0; i < pageNum; i++) {
                    if ((currentNum + i + 1) > cl.pageNum || cl.pageNum < 2) break;
                    buffer.append(" <a href=\"JavaScript:tunePage(" + (currentNum + i + 1) + ",'','" + cl.searchStr + "')\">");
                    buffer.append(currentNum + i + 1 == cl.pageNo ? "<b>" + (currentNum + i + 1) + "</b>" : (currentNum + i + 1) + "");
                    buffer.append("</a>");
                }

                if (cl.pageNo == cl.pageNum) {
                    buffer.append("下一页" + "&nbsp;");
                    buffer.append("最末页" + "&nbsp;");
                } else if (cl.pageNo < cl.pageNum) {
                    buffer.append(" <a href=\"JavaScript:tunePage(" + (cl.pageNo + 1) + ",'','" + cl.searchStr + "')\">下一页</a>" + "&nbsp;");
                    buffer.append(" <a href=\"JavaScript:tunePage(" + cl.pageNum + ",'','" + cl.searchStr + "')\">最末页</a>" + "&nbsp;");
                }

            } else if (model == 4) {
                if (cl.pageNo == 1) {
                    buffer.append("上一页" + "&nbsp;");
                } else if (cl.pageNo > 1) {
                    buffer.append(" <a href=\"JavaScript:tunePage(" + (cl.pageNo - 1) + ",'','" + cl.searchStr + "')\">上一页</a>" + "&nbsp;");
                }
                if (cl.pageNo == cl.pageNum) {
                    buffer.append("下一页" + "&nbsp;");
                } else if (cl.pageNo < cl.pageNum) {
                    buffer.append(" <a href=\"JavaScript:tunePage(" + (cl.pageNo + 1) + ",'','" + cl.searchStr + "')\">下一页</a>" + "&nbsp;");
                }
            } else if (model == 5) {

                buffer.append("共[" + cl.pageNo + "/" + cl.pageNum + "]页" + "&nbsp;");
                if (cl.pageNo == 1) {

                    buffer.append("上一页" + "&nbsp;");
                } else if (cl.pageNo > 1) {

                    buffer.append("<a href=\"JavaScript:tunePage(" + (cl.pageNo - 1) + ",'','" + cl.searchStr + "')\">上一页</a>" + "&nbsp;");
                }
                if (cl.pageNo == cl.pageNum) {
                    buffer.append("下一页" + "&nbsp;");

                } else if (cl.pageNo < cl.pageNum) {
                    buffer.append("<a href=\"JavaScript:tunePage(" + (cl.pageNo + 1) + ",'','" + cl.searchStr + "')\">下一页</a>" + "&nbsp;");

                }

            } else if (model == 6) {
                if (cl.pageNo == 1) {
                    buffer.append("第一页" + "&nbsp;");
                    buffer.append("上一页" + "&nbsp;");
                } else if (cl.pageNo > 1) {
                    buffer.append(" <a href=\"JavaScript:tunePage(" + 1 + ",'','" + cl.searchStr + "')\">第一页</a>" + "&nbsp;");
                    buffer.append(" <a href=\"JavaScript:tunePage(" + (cl.pageNo - 1) + ",'','" + cl.searchStr + "')\">上一页</a>" + "&nbsp;");
                }
                if (cl.pageNo == cl.pageNum) {
                    buffer.append("下一页" + "&nbsp;");
                    buffer.append("最末页" + "&nbsp;");
                } else if (cl.pageNo < cl.pageNum) {
                    buffer.append(" <a href=\"JavaScript:tunePage(" + (cl.pageNo + 1) + ",'','" + cl.searchStr + "')\">下一页</a>" + "&nbsp;");
                    buffer.append(" <a href=\"JavaScript:tunePage(" + cl.pageNum + ",'','" + cl.searchStr + "')\">最末页</a>" + "&nbsp;");
                }
            } else if (model == 7) {
                buffer.append("共[" + cl.pageNo + "/" + cl.pageNum + "]页" + "&nbsp;");
                if (cl.pageNo > 1) {
                    //---------------------------------
                    // 当前页不是第一页，
                    // 还要加入第一页和上一页标签
                    //---------------------------------
                    buffer.append(" <a href=\"JavaScript:tunePage(" + 1 + ",'','" + cl.searchStr + "')\">&#8249;</a>");
                    buffer.append(" <a href=\"JavaScript:tunePage(" + (cl.pageNo - 1) + ",'','" + cl.searchStr + "')\">&laquo;</a>");
                }

                //---------------------------------
                // 如果当前页大于每页显示页码数。
                // 则要显示快速向上翻的标签(标签是：...)
                //---------------------------------
                int currentNum = (cl.pageNo % pageNum == 0 ? (cl.pageNo / pageNum) - 1 : (int) (cl.pageNo / pageNum)) * pageNum;
                if (currentNum < 0) currentNum = 0;
                if (cl.pageNo > pageNum) {
                    buffer.append(" <a href=\"JavaScript:tunePage(" + (currentNum - pageNum + 1) + ",'','" + cl.searchStr + "')\">...</a>");
                }

                //---------------------------------
                // 显示中间可用的翻页码
                //---------------------------------
                for (int i = 0; i < pageNum; i++) {
                    if ((currentNum + i + 1) > cl.pageNum || cl.pageNum < 2) break;
                    buffer.append(" <a href=\"JavaScript:tunePage(" + (currentNum + i + 1) + ",'','" + cl.searchStr + "')\">");
                    buffer.append(currentNum + i + 1 == cl.pageNo ? "<b>" + (currentNum + i + 1) + "</b>" : (currentNum + i + 1) + "");
                    buffer.append("</a>");
                }

                //---------------------------------
                // 如果还未到达最后一版，
                // 则还要加入快速向下翻的标签(标签是：...)
                //---------------------------------
                if (cl.pageNum > (currentNum + pageNum)) {
                    buffer.append(" <a href=\"JavaScript:tunePage(" + (currentNum + 1 + pageNum) + ",'','" + cl.searchStr + "')\">...</a>");
                }

                //---------------------------------
                // 如果当前页不是最后一页，
                // 则要加入下一页和最后一页标筌
                //---------------------------------
                if (cl.pageNo < cl.pageNum) {
                    buffer.append(" <a href=\"JavaScript:tunePage(" + (cl.pageNo + 1) + ",'','" + cl.searchStr + "')\">&raquo;</a>");
                    buffer.append(" <a href=\"JavaScript:tunePage(" + cl.pageNum + ",'','" + cl.searchStr + "')\">&#8250;</a>");

                }
            }

            String pagestr = buffer.toString();
            buffer.setLength(0);
            buffer = null;

            try {
                writer.write(pagestr);

            } catch (IOException e) {
                e.printStackTrace(System.err);
            }

        }
        return result;
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

    private String value = null;
    private int pageNum = 10;
    private int model = 2;
}
