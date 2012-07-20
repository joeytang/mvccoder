package ${project.org}.security.web.action;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;

import ${project.org}.util.ConfigUtil;


/**
 * User:joeytang
 * Date: ${project.currentTime}
 * 后台基础action
 */
public class BaseBackAction extends PageAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private static final int BUFFER_SIZE = 1024 * 1024; // 1M
	
	/**
	 * 上传文件 首先根据struts2的上传组件将文件上传到本地缓存目录，然后将上传的文件拷贝到/admin/upload目录下，
	 * 并返回拷贝后的文件的绝对路径
	 *
	 * @return 上传到服务器的文件的绝对路径
	 * @throws Exception
	 */
	protected String uploads(File upload,String uploadFileName,String ext,String fileDir) throws Exception {
		if (upload == null) {
			return null;
		}
		String pos = getExtention(uploadFileName);
		if (null == ext || ext.toLowerCase().equals(pos.toLowerCase())) {
			String filename = new Date().getTime() + pos;
			String path = ConfigUtil.defaultHomePath() + fileDir;
			File newFile = new File(path);
			if (!newFile.isDirectory()) {
				newFile.mkdirs();
			}
			path = ConfigUtil.defaultHomePath() + fileDir
					+ "/" + filename;
			newFile = new File(path);
			copy(upload, newFile);
			return fileDir + "/" + filename;
		} else {
			throw new Exception();
		}

	}

	/**
	 * 将一个文件拷贝到另一个地方
	 *
	 * @param src
	 *            源文件
	 * @param dst
	 *            目标文件
	 * @throws Exception
	 */
	protected void copy(File src, File dst) throws Exception {
		try {
			InputStream in = null;
			OutputStream out = null;
			try {
				in = new BufferedInputStream(new FileInputStream(src),
						BUFFER_SIZE);
				out = new BufferedOutputStream(new FileOutputStream(dst),
						BUFFER_SIZE);
				if (in.available() > 1024 * 1024 * 35) {
					throw new Exception("文件太大！");
				}
				byte[] buffer = new byte[BUFFER_SIZE];
				int len = 0;
				while ((len = in.read(buffer)) > 0) {
					out.write(buffer, 0, len);
				}
			} catch (Exception e1) {
				throw new Exception(e1);
			} finally {
				if (null != in) {
					in.close();
				}
				if (null != out) {
					out.close();
				}
			}
		} catch (Exception e) {
			throw new Exception(e);
		}
	}
	/**
	 * 获取文件扩展名，即"."以后的部分
	 *
	 * @param fileName
	 *            包含扩展名的文件名称
	 * @return 文件的扩展名
	 */
	protected String getExtention(String fileName) {
		int pos = fileName.lastIndexOf(".");
		return fileName.substring(pos);
	}

}
