/*
<LICENCE>

Copyright (c) 2008, University of Southampton
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice, this
	list of conditions and the following disclaimer.

 *	Redistributions in binary form must reproduce the above copyright notice,
	this list of conditions and the following disclaimer in the documentation
	and/or other materials provided with the distribution.

 *	Neither the name of the University of Southampton nor the names of its
	contributors may be used to endorse or promote products derived from this
	software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

</LICENCE>
 */

package com.wanmei.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import org.apache.tools.ant.taskdefs.Copy;
import org.apache.tools.ant.types.FileSet;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipFile;
import org.apache.tools.zip.ZipOutputStream;

public class FileUtil {
	/**
	 * ant copy命令
	 */
	public static void antCopy(String src, String des) {
		antCopy(src,des,"**/*",null);
	}
	/**
	 * ant copy命令
	 */
	public static void antCopy(String src, String des,String include,String exclude) {
		Copy c = new Copy();
		c.setProject(new org.apache.tools.ant.Project());
		FileSet fs = new FileSet();
		fs.setDir(new File(src));
		if(StringUtil.isNotBlank(include)){
			fs.setIncludes(include);
		}
		if(StringUtil.isNotBlank(exclude)){
			fs.setIncludes(exclude);
		}
		c.addFileset(fs);
		c.setTodir(new File(des));
		c.execute();
	}
	/**
	 * 获取文件扩展名，即从"."以后的部分
	 *
	 * @param fileName
	 *            包含扩展名的文件名称
	 * @return 文件的扩展名
	 */
	public static String getExtention(String fileName) {
		int pos = fileName.lastIndexOf(".");
		return fileName.substring(pos);
	}
	/**
	 * 路径分隔符
	 */
	public static final String FILE_SEPARATOR = System
			.getProperty("file.separator");
	/**
	 * Because remove and removeAll methods of JDOM ContentList does stupid
	 * things
	 */
	final static int BUFFER = 2048;

	/**
	 * 拷贝文件
	 * @param source
	 * @param destination
	 * @return
	 * @throws IOException 
	 */
	public static boolean copy(InputStream fis, File destination) throws IOException {
		if (!destination.exists()) {
			File p = destination.getParentFile();
			if(!p.exists()){
				p.mkdirs();
			}
			destination.createNewFile();
		}
		FileOutputStream fos = new FileOutputStream(destination);
		byte[] buffer = new byte[BUFFER];
		int len = -1;
		while ((len = fis.read(buffer)) != -1) {
			fos.write(buffer, 0, len);
		}
		fos.flush();
		fos.close();
		fis.close();
		fos = null;
		fis = null;
		return true;
	}
	/**
	 * 拷贝文件
	 * @param source
	 * @param destination
	 * @return
	 * @throws IOException 
	 */
	public static boolean copy(File source, File destination) throws IOException {
		FileInputStream fis = new FileInputStream(source);
		return copy(fis,destination);
	}

	/**
	 * 通过给定的文件的路径，判断该路径指定的文件的格式
	 * 
	 * @param url文件的路径
	 * @return
	 */
	public static String getFileType(String url) {
		if (url == null || url.length() == 0)
			return null;
		String type = null;

		int i = url.lastIndexOf('.');
		// 取得指定文件的扩展名
		if (i < 0) {
			return null;
		} else {
			type = url.substring(i + 1);
		}

		return type;
	}

	/**
	 * 
	 * @param out
	 * @param f
	 * @param base
	 * @throws Exception
	 */

	public static void zip(ZipOutputStream out, File f, String base)
			throws Exception {
		if (f.isDirectory()) {
			File[] fl = f.listFiles();
			base = base.length() == 0 ? "" : base + "/";
			out.putNextEntry(new ZipEntry(base + "/"));
			for (int i = 0; i < fl.length; i++) {
				zip(out, fl[i], base + fl[i].getName());
			}
		} else {
			out.putNextEntry(new ZipEntry(base));
			FileInputStream in = new FileInputStream(f);
			int b;
			// System.out.println(base);
			while ((b = in.read()) != -1) {
				out.write(b);
			}
			in.close();
		}
	}

	/**
	 * 
	 * @param out
	 * @param f
	 * @param base
	 * @throws Exception
	 */

	public static void zip(File source, ZipOutputStream destination, String base)
			throws Exception {
		if (source.isDirectory()) {
			File[] children = source.listFiles();
			base = (base == null || base.length() == 0) ? "" : base + "/";
			destination.putNextEntry(new ZipEntry(base + "/"));
			for (int i = 0; i < children.length; i++) {
				zip(children[i], destination, base);
			}
		} else {
			base = (base == null || base.length() == 0) ? source.getName()
					: base + source.getName();
			destination.putNextEntry(new ZipEntry(base));
			FileInputStream in = new FileInputStream(source);
			int b = -1;
			byte[] buffer = new byte[BUFFER];
			while ((b = in.read(buffer)) != -1) {
				destination.write(buffer, 0, b);
			}
			in.close();
		}
	}

	/**
	 * 对外使用的压缩方法 该方法使用了ant的ZipOutputStream来进行压缩，因为java自带的
	 * 压缩方法存在中文问题——如果文件名称是中文的，则压缩出错。
	 * 
	 * @param source
	 *            需要被压缩的文件或文件夹
	 * @param destination
	 *            压缩到的文件
	 * @param base在压缩包里面设置层次
	 *            ，如果没有设置,则在压缩包里面不再多加一层文件夹
	 *            如果设置了字符串，则建立文件夹名为该字符串的文件夹，把所有文件放到该文件夹下面
	 *            如果设置的字符串是文件结构形式的，如a\\b则会根据该路径创建相应路径文件夹，然后将所有文件 放到最里面的文件夹里面。
	 * @throws Exception
	 */
	public static void zip(File source, File destination, String base) {
		try {
			ZipOutputStream out = new ZipOutputStream(new FileOutputStream(
					destination));
			zip(source, out, base);
			out.close();// 一定要关上，否则压缩出错。折磨了1小时
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	/**
	 * 该方法参见zip(File source, File destination, String base)
	 * 
	 * @param source需要被压缩的文件或文件夹路径
	 * @param destination压缩到的文件路径
	 * @param base
	 * @throws Exception
	 */
	public static void zip(String source, String destination, String base)
			throws Exception {
		zip(new File(source), new File(destination), base);
	}

	/**
	 * 解压文件 将source指定的zip文件里面的所有文件解压到当前destination文件夹下面。
	 * 所以如果zip里面的很多文件不在一个文件夹里面，则放在destination中会非常的多
	 * 那么如果想在destination中建立文件夹，并把zip中的文件放进去，则在destination
	 * 后面加上路径就可以了。但是注意一定要是路径，如destination\\a\\,必须由后面这个路径符号，
	 * 如果你设置成了destination\\a则解压的结果将是把zip中的所有文件的名字加上了a， 但是解压的路径都没有变。
	 * 
	 * @param source需要被解压的zip文件
	 * @param destination需要被解压到的路径
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public static void unZip(String source, String destination)
			throws Exception {

		try {
			// String fileName = "E:\\test\\myfiles.zip";
			// String filePath = "E:\\test\\";
			ZipFile zipFile = new ZipFile(source);
			Enumeration emu = zipFile.getEntries();
			// int i = 0;
			while (emu.hasMoreElements()) {
				ZipEntry entry = (ZipEntry) emu.nextElement();
				// 会把目录作为一个file读出一次，所以只建立目录就可以，之下的文件还会被迭代到。
				if (entry.isDirectory()) {
					new File(destination + entry.getName()).mkdirs();
					continue;
				}
				BufferedInputStream bis = new BufferedInputStream(
						zipFile.getInputStream(entry));
				File file = new File(destination + entry.getName());
				// 加入这个的原因是zipfile读取文件是随机读取的，这就造成可能先读取一个文件
				// 而这个文件所在的目录还没有出现过，所以要建出目录来。
				File parent = file.getParentFile();
				if (parent != null && (!parent.exists())) {
					parent.mkdirs();
				}
				FileOutputStream fos = new FileOutputStream(file);
				BufferedOutputStream bos = new BufferedOutputStream(fos, BUFFER);
				int count;
				byte data[] = new byte[BUFFER];
				while ((count = bis.read(data, 0, BUFFER)) != -1) {
					bos.write(data, 0, count);
				}
				bos.flush();
				bos.close();
				bis.close();
			}
			zipFile.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public static String getFileNameWithoutExt(String fileName) {
		if (fileName != null) {
			int i = fileName.lastIndexOf('.');
			int j = fileName.lastIndexOf("/");
			if (j == -1) {
				j = fileName.lastIndexOf("\\");
			}
			if (i != -1) {
				return fileName.substring(j + 1, i);
			}
		}
		return "";

	}

	/**
	 * 删除当前文件以及子文件。
	 * 
	 * @param file
	 * @return
	 */
	public static boolean deleteFileAndChildren(File file) {
		if (!file.exists()) {
			try {
				throw new Exception("The file is not exists");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (file.isDirectory()) {
			File[] children = file.listFiles();
			for (File child : children) {
				deleteFileAndChildren(child);
			}
			return file.delete();
		} else {
			return file.delete();
		}

	}

	public static List<File> getZipFileNameList(String folderName) {
		List<File> zipNames = new ArrayList<File>();

		File folder = new File(folderName);
		File[] children = folder.listFiles();
		for (File child : children) {
			int i = child.getName().lastIndexOf(".");
			String fileType = child.getName().substring(i + 1);
			if (fileType.equals("zip"))
				zipNames.add(child);
		}

		return zipNames;
	}

	public static String getJarFilePath(Class<?> c) {
		String startMark = "file:";
		String endMark = ".jar";
		String s = c.getName().replace('.', '/') + ".class";
		// 当资源class放在/WEB-INF/classs中时，
		// url=file:/e:/test/project/defaultroot/WEB-INF/classes/com.world2.util.ConfigUtil.class
		// 当资源class打成jar包放在/WEB-INF/lib中时，
		// url=jar:file:/e:/test/project/defaultroot/WEB-INF/lib/res.jar!/com.world2.util.ConfigUtil.class
		java.net.URL url = c.getClassLoader().getResource(s);
		String upath = url.toString();

		int n1 = upath.indexOf(startMark);
		n1 = (n1 < 0) ? 0 : (n1 + startMark.length());

		int n2 = upath.lastIndexOf(".jar");

		if (n2 < 0) {
			return null;
		}

		n2 += endMark.length();

		String path = upath.substring(n1, n2);

		if (path.startsWith(File.separator) && (path.indexOf(":") == 2)) {
			path = path.substring(1);
		}

		return path.replace('/', FILE_SEPARATOR.charAt(0));
	}

}
