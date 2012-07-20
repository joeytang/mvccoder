package com.wanmei.support;

import java.io.File;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.wanmei.util.FileUtil;
import com.wanmei.util.RenderUtils;

/**
 * spring mvc文件上传相关处理
 * @author joeytang
 *
 */
@Service
public class MvcUploadSupport {

	/**
	 * 上传文件,用于springmvc中未统一指定CommonsMultipartResolver。对当前HttpServletRequest自定义一个CommonsMultipartResolver处理文件上传
	 * 
	 * @param request
	 *            当前请求，文件上传的HttpServletRequest
	 * @param maxSize
	 *            文件大小限制,可以为空，默认5M
	 * @param fileParamName
	 *            request中文件域变量名称
	 * @param contentType
	 *            限制文件格式 ,可以为空，默认不限制
	 * @param destDir
	 *            文件上传目录相对于web根目录的相对地址 ，可以为空，默认"/upload"
	 * @param destFileName
	 *            文件上传后文件名 ，可以为空 默认 当前时间毫秒数_原文件名称.扩展名
	 * @return 返回上传情况json对象
	 * 		 成功返回{status:200,result:上传后相对于web根目录的地址}
	 * 		失败返回{status:失败原因对应的code,error:失败提醒信息}
	 * 
	 */
	public JSONObject upload(HttpServletRequest request, Long maxSize,
			String fileParamName, String contentType, String destDir,
			String destFileName, boolean canNull) {
		CommonsMultipartResolver commonsMultipartResolver = new CommonsMultipartResolver(
				request.getSession().getServletContext());
		commonsMultipartResolver.setMaxUploadSize(maxSize);
		MultipartHttpServletRequest muHttpServletRequest = commonsMultipartResolver
				.resolveMultipart(request);
		return this.upload(muHttpServletRequest, maxSize,fileParamName, contentType, destDir,
				destFileName, canNull);
	}

	/**
	 * 上传文件,用于springmvc中统一指定CommonsMultipartResolver。将当前request强制转换成MultipartHttpServletRequest，处理文件上传
	 * 
	 * @param request
	 *            当前请求，文件上传的HttpServletRequest强制转换成MultipartHttpServletRequest
	 * @param maxSize
	 *            文件大小限制,可以为空，默认5M
	 * @param fileParamName
	 *            request中文件域变量名称
	 * @param contentType
	 *            限制文件格式 ,可以为空，默认不限制
	 * @param destDir
	 *            文件上传目录相对于web根目录的相对地址 ，可以为空，默认"/upload"
	 * @param destFileName
	 *            文件上传后文件名 ，可以为空 默认 当前时间毫秒数_原文件名称.扩展名
	 * @return 返回上传情况json对象
	 * 		 成功返回{status:200,result:上传后相对于web根目录的地址}
	 * 		失败返回{status:失败原因对应的code,error:失败提醒信息}
	 * 
	 */
	public JSONObject upload(MultipartHttpServletRequest request, Long maxSize,
			String fileParamName, String contentType, String destDir,
			String destFileName, boolean canNull) {
		JSONObject json = null;
		if (StringUtils.isBlank(fileParamName)) {
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR, "上传文件参数名称不能为空");
			return json;
		}
		MultipartFile file = null;
		try {
			file = request.getFile(fileParamName);
		} catch (Exception e) {
			if (e instanceof MaxUploadSizeExceededException) {
				json = RenderUtils.getStatusValidParam();
				json.put(RenderUtils.KEY_ERROR, "文件过大");
				return json;
			}
		}
		return this.upload(file, request, maxSize, contentType, destDir,
				destFileName, canNull);
	}

	/**
	 * 上传文件，用于直接将MultipartFile上传到指定位置
	 * 
	 * @param file
	 *            需要上传的文件
	 * @param maxSize
	 *            文件大小限制,默认5M
	 * @param fileParamName
	 *            request中文件变量名称
	 * @param contentType
	 *            限制文件格式 ,默认不限制
	 * @param destDir
	 *            文件上传目录相对于web根目录的相对地址 默认upload
	 * @param destFileName
	 *            文件上传后文件名 默认 当前时间_原文件名称.扩展名
	 * @param request
	 * @return 返回json对象， status：success
	 *         成功;fails失败;error:失败原因;result成功后保存的文件相对web根目录地址
	 * @throws Exception
	 */
	public JSONObject upload(MultipartFile file, HttpServletRequest request,
			Long maxSize, String contentType, String destDir,
			String destFileName, boolean canNull) {
		if (maxSize == null || maxSize < 1) {
			maxSize = (long) (5 * 1024 * 1024);
		}

		if (StringUtils.isBlank(destDir)) {
			destDir = "/upload/";
		}
		JSONObject json = null;
		String path = destDir;
		destDir = getWebRoot(request) + destDir;

		if (null == file || file.getSize() < 1) {
			if (canNull) {
				json = RenderUtils.getStatusOk();
				json.put(RenderUtils.KEY_RESULT, "");
				return json;
			}
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR, "文件为空，请重新上传。");
			return json;
		}
		if (file.getSize() > maxSize) {
			json = RenderUtils.getStatusValidParam();
			json.put(RenderUtils.KEY_ERROR, "文件大小不能超过" + maxSize
					/ (1024 * 1024) + "M");
			return json;
		}
		try {
			String ext = FileUtil.getExtention(file.getOriginalFilename());
			if (StringUtils.isBlank(destFileName)) {
				destFileName = new Date().getTime() + "_" + file.getName()
						+ ext;
			}
			if (StringUtils.isNotBlank(contentType)) {
				String ct = file.getContentType();
				if (!contentType.toLowerCase().contains(ct.toLowerCase()) || file.getSize() <= 0) {
					json = RenderUtils.getStatusValidParam();
					json.put(RenderUtils.KEY_ERROR, "仅支持" + contentType);
					return json;
				}
			}
			String destination = destDir + destFileName;
			FileUtil.copy(file.getInputStream(), new File(destination));
			json = RenderUtils.getStatusOk();
			json.put(RenderUtils.KEY_RESULT, path + "/" + destFileName);
			return json;
		} catch (Exception e) {
			json = RenderUtils.getStatusSystem();
			json.put(RenderUtils.KEY_ERROR, "上传失败，请重新上传");
			return json;
		}
	}
	 /**
	 * 得到网站部署的根目录绝对路径
	 * 后面带有/
	 * @param request
	 * @return
	 */
	public String getWebRoot(HttpServletRequest request){
		return request.getSession().getServletContext().getRealPath("/");
	}
}
