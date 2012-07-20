package com.wanmei.util;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import freemarker.cache.ClassTemplateLoader;
import freemarker.cache.MultiTemplateLoader;
import freemarker.cache.TemplateLoader;
import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;
import freemarker.template.TemplateException;

public class FreeMarkertUtil {
	/**
	 * 
	 * @param templateName
	 *            模板文件名称
	 * @param templateEncoding
	 *            模板文件的编码方式
	 * @param root
	 *            数据模型根对象
	 */
	public  void analysisTemplate(String teemplateRoot,String templateName,String output,
			Map<?, ?> root) {
		try {
			/**
			 * 创建Configuration对象
			 */
			Configuration config = new Configuration();
			/**
			 * 指定模板路径
			 */
			File file = new File(teemplateRoot);
//			/**
//			 * 设置要解析的模板所在的目录，并加载模板文件
//			 */
			if(file != null && file.exists()){
				config.setDirectoryForTemplateLoading(file);
			}
			/**
			 * 设置包装器，并将对象包装为数据模型
			 */
			List<ClassTemplateLoader> loaders = new ArrayList<ClassTemplateLoader>();
			
			loaders.add(new ClassTemplateLoader(this.getClass(),"/")); // the template names are like pojo/Somewhere so have to be a rooted classpathloader
			
			config.setTemplateLoader(new MultiTemplateLoader((TemplateLoader[]) loaders.toArray(new TemplateLoader[loaders.size()])));
			config.setObjectWrapper(new DefaultObjectWrapper());
			config.setDefaultEncoding("UTF-8");
			
			/**
			 * 获取模板,并设置编码方式，这个编码必须要与页面中的编码格式一致
			 */
			Template template = config.getTemplate(templateName );
			template.setEncoding("UTF-8");
			/**
			 * 合并数据模型与模板
			 */
			File outputFile = new File(output);
			if(!outputFile.exists()){
				if(!outputFile.getParentFile().exists()){
					outputFile.getParentFile().mkdirs();
				}
				outputFile.createNewFile();
			}
			FileOutputStream fos=new FileOutputStream(outputFile); 
			OutputStreamWriter osw=new OutputStreamWriter(fos,"UTF-8"); 
			BufferedWriter bw=new BufferedWriter(osw); 
//			Writer out = new OutputStreamWriter(new FileOutputStream(new File(
//			"user.java")));
//			Writer out = new OutputStreamWriter(bw));
//			template.process(root, out);
			template.process(root, bw);
//			System.out.println(tempWriter.toString());
			bw.close(); 
		} catch (IOException e) {
			throw new RuntimeException(e);
		} catch (TemplateException e) {
			throw new RuntimeException(e);
		}
		
	}
	/**
	 * 
	 * @param templateName
	 *            模板文件名称
	 * @param templateEncoding
	 *            模板文件的编码方式
	 * @param root
	 *            数据模型根对象
	 */
	public  void analysisTemplate(Template template,String output,Map<?, ?> root) {
		try {
			/**
			 * 合并数据模型与模板
			 */
			File outputFile = new File(output);
			if(!outputFile.exists()){
				if(!outputFile.getParentFile().exists()){
					outputFile.getParentFile().mkdirs();
				}
				outputFile.createNewFile();
			}
			FileOutputStream fos=new FileOutputStream(outputFile); 
			OutputStreamWriter osw=new OutputStreamWriter(fos,"UTF-8"); 
			BufferedWriter bw=new BufferedWriter(osw); 
//			Writer out = new OutputStreamWriter(new FileOutputStream(new File(
//			"user.java")));
//			Writer out = new OutputStreamWriter(bw));
//			template.process(root, out);
			template.process(root, bw);
//			System.out.println(tempWriter.toString());
			bw.close(); 
		} catch (IOException e) {
			e.printStackTrace();
		} catch (TemplateException e) {
			e.printStackTrace();
		}

	}
}
