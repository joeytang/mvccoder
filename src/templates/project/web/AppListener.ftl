package ${project.org}.web.listener;

import javax.servlet.ServletContextListener;
import javax.servlet.ServletContextEvent;
/**
 * Created by IntelliJ IDEA.
 * User: joeytang
 * Date: ${project.currentTime}
 * 监听器 初始化常量
 */
public class AppListener implements ServletContextListener {


    public void contextInitialized(final ServletContextEvent servletContextEvent) {
      //  ServletContext servletContext = servletContextEvent.getServletContext();
        //设置枚举常量
//        servletContext.setAttribute("authEnum", Constants.authEnum());
    }

    public void contextDestroyed(final ServletContextEvent servletContextEvent) {

    }
}

