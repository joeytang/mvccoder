package ${project.org}.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Enumeration;

import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipFile;
import org.apache.tools.zip.ZipOutputStream;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;

/**
 *
 * User: joeytang
 * Date: ${project.currentTime}
 * 文件处理工具类
 */
public class FileUtil {
	final static int BUFFER = 2048;
	public final static String UPLOAD_ROOT = "/upload/";
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
	 * 根据路径获得文件全名，文件名+扩展名
	 * @param filePath
	 * @return
	 */
	public static String getFullName(String filePath )
	{
		File f = new File(filePath);
		return f.getName();
	}
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
				if(!p.mkdirs()){
					throw new RuntimeException("make directory fail");
				}
			}
			if( !destination.createNewFile()){
				throw new RuntimeException("createFileFail");
			}
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
	public static void zip(File source, ZipOutputStream destination,
			String base) throws Exception {
		if (source.isDirectory()) {
			File[] children = source.listFiles();
			base = (base == null || base.length() == 0) ? "" : base + "/";
			destination.putNextEntry(new ZipEntry(base
					+ "/"));
			for (int i = 0; i < children.length; i++) {
				zip(children[i], destination, base);
			}
		} else {
			base = (base == null || base.length() == 0) ? source.getName() : base+source.getName() ;
			destination.putNextEntry(new ZipEntry(base));
			FileInputStream in = new FileInputStream(source);
			int b = -1;
			byte[] buffer = new byte[BUFFER];
			System.out.println(base);
			while ((b = in.read(buffer)) != -1) {
				destination.write(buffer,0,b);
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
	 * @param base在压缩包里面设置层次，如果没有设置,则在压缩包里面不再多加一层文件夹
	 *            如果设置了字符串，则建立文件夹名为该字符串的文件夹，把所有文件放到该文件夹下面
	 *            如果设置的字符串是文件结构形式的，如a\\b则会根据该路径创建相应路径文件夹，然后将所有文件 放到最里面的文件夹里面。
	 * @throws Exception
	 */
	public static void zip(File source, File destination, String base) {
		try {
			ZipOutputStream out = new ZipOutputStream(new FileOutputStream(destination));
			zip(source,out,base);
			out.close();//一定要关上，否则压缩出错。折磨了1小时
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}catch (Exception e) {
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
	 * 解压文件
	 * 将source指定的zip文件里面的所有文件解压到当前destination文件夹下面。
	 * 所以如果zip里面的很多文件不在一个文件夹里面，则放在destination中会非常的多
	 * 那么如果想在destination中建立文件夹，并把zip中的文件放进去，则在destination
	 * 后面加上路径就可以了。但是注意一定要是路径，如destination\\a\\,必须由后面这个路径符号，
	 * 如果你设置成了destination\\a则解压的结果将是把zip中的所有文件的名字加上了a，
	 * 但是解压的路径都没有变。
	 * @param source需要被解压的zip文件
	 * @param destination需要被解压到的路径
	 * @throws Exception
	 */
	public static void unZip(String source, String destination)
			throws Exception {
		
		try {
			ZipFile zipFile = new ZipFile(source);
			@SuppressWarnings("rawtypes")
			Enumeration emu = zipFile.getEntries();
			while (emu.hasMoreElements()) {
				ZipEntry entry = (ZipEntry) emu.nextElement();
				// 会把目录作为一个file读出一次，所以只建立目录就可以，之下的文件还会被迭代到。
				if (entry.isDirectory()) {
					if(!new File(destination + entry.getName()).mkdirs()){
						throw new RuntimeException("make directory fail");
					}
					continue;
				}
				BufferedInputStream bis = new BufferedInputStream(zipFile
						.getInputStream(entry));
				File file = new File(destination + entry.getName());
				// 加入这个的原因是zipfile读取文件是随机读取的，这就造成可能先读取一个文件
				// 而这个文件所在的目录还没有出现过，所以要建出目录来。
				File parent = file.getParentFile();
				if (parent != null && (!parent.exists())) {
					if(!parent.mkdirs()){
						throw new RuntimeException("make directory fail");
					}
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
	 * @param file
	 * @return
	 */
	public static boolean deleteFileAndChildren(File file){
		if(!file.exists()){
			try {
				throw new Exception("The file is not exists");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if(file.isDirectory()){
			File[] children = file.listFiles();
			for(File child:children){
				deleteFileAndChildren(child);
			}
			return file.delete();
		}else{
			return file.delete();
		}
		
	}
	/**
	 * 写xml文件
	 * @param root
	 * @param path
	 * @return
	 */
	public static boolean writeXML(Element root,String path) throws FileNotFoundException,IOException{
		Document doc=new Document(root); 
		XMLOutputter outputter = new XMLOutputter(); 
		File file = new File(path);
		if(file.getParentFile() != null && !file.getParentFile().exists()){
			if(!file.getParentFile().mkdirs()){
				throw new RuntimeException("make directory fail");
			}
		}
		// 如果不设置format，仅仅是没有缩进，xml还是utf-8的，因此format不是必要的
		Format f = Format.getPrettyFormat(); 
		// f.setEncoding("UTF-8");//default=UTF-8
		outputter.setFormat(f); 
		FileOutputStream out = new FileOutputStream(file);
		outputter.output(doc, out); 
		out.flush();
		out.close(); 
		out = null;
		return true;
	}
}
