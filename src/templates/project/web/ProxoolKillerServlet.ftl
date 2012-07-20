package ${project.org}.web.servlet;

import javax.servlet.http.HttpServlet;

import org.logicalcobwebs.proxool.ProxoolFacade;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 *  重启关闭proxool
 */
public class ProxoolKillerServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public void destroy(){
		ProxoolFacade.shutdown();
	}
}
