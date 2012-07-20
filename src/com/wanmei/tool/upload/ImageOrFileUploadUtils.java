package com.wanmei.tool.upload;

import java.awt.AlphaComposite;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.geom.AffineTransform;
import java.awt.image.AffineTransformOp;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;

import javax.imageio.ImageIO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

import com.wanmei.util.ConfigUtil;

/**
 * User: joeytang
 * Date: 2012-03-20 18:17
 * 图片上传、缩放、文字水印、图片水印
 */
public class ImageOrFileUploadUtils {
    //    private static final int BUFFER_SIZE = 1024 * 1024;  //1M
    private Log log = LogFactory.getLog(getClass());


    /**
     * 文件大小
     */
    private int bufferSize = 1024 * 1024;  //1M
    /**
     * 缩略图宽
     */
    private int zoomWidth = 130;
    /**
     * 缩略图高
     */
    private int zoomHeight = 80;

    /**
     * 上传路径  /view/chibi/guild-logo/1/
     */
    private String filePath;
    /**
     * 文字水印
     */
    private String textTitle;
    /**
     * 图片水印   /view/chibi/guild-logo/write.gif
     */
    private String waterImgPath;

    // 输入参数:上传过来的文件路径
    private File file;

    /**
     * 输入参数:文件名称 由struts的拦截器默认赋值,注意setter的写法:file+fileName
     */
    private String fileName;

    /**
     * 输入参数 由struts的拦截器默认赋值,注意setter的写法:file+contentType
     */
    private String contentType;

    // 输出参数
    private String imageFileName;

    // 输出参数:原图保存路径
    private String ipath;

    // 输出参数:缩略图保存路径
    private String imgPath;

    // 输出参数
    private String json;

    public ImageOrFileUploadUtils() {
    }

    /**
     * 得到文件名称
     *
     * @param fileName
     * @return
     */
    public String getExtention(String fileName) {
        int pos = fileName.lastIndexOf(".");
        return fileName.substring(pos);
    }

    /**
     * 拷贝
     *
     * @param src  原地址
     * @param dist 目标地址
     * @throws Exception
     */
    private void copy(File src, File dist) throws Exception {
        log.debug("[src]--" + src);
        log.debug("[dist]--" + dist);

        try {
            InputStream in = null;
            OutputStream out = null;
            try {
                in = new BufferedInputStream(new FileInputStream(src), this.bufferSize);
                out = new BufferedOutputStream(new FileOutputStream(dist), this.bufferSize);
                byte[] buf = new byte[this.bufferSize];
                while (in.read(buf) > 0) {
                    out.write(buf);
                }
                out.close();
                in.close();
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                if (in != null)
                    in.close();
                if (out != null)
                    out.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e);
        }
    }

    /**
     * 图片上传
     */
    public void uploadImage() throws Exception {
        log.debug("[file]--" + file);
        log.debug("[file name]--" + fileName);
        imageFileName = new Date().getTime() + getExtention(fileName);
        // 得到文件存放路径
        log.debug("[imageFileName]--" + imageFileName);
        String dir = ConfigUtil.defaultHomePath() + ConfigUtil.FILE_SEPARATOR + this.filePath;
        File dirs = new File(dir);
        if (!dirs.exists())
            dirs.mkdir();
        // 使用原来的文件名保存图片
        String path = dir + imageFileName;
        File imageFile = new File(path);
        copy(file, imageFile);
        // 大图路径
        ipath = this.filePath + imageFileName;
    }


    /**
     * 缩放处理
     *
     * @return
     */
    public void zoom(File imageFile) throws Exception {
        log.debug("[zoom][imageFile]--" + imageFile);
        try {
            // 缩略图存放路径
            File todir = new File(ConfigUtil.defaultHomePath() + ConfigUtil.FILE_SEPARATOR + this.filePath + "zoom");
            if (!todir.exists()) {
                todir.mkdir();
            }

            if (!imageFile.isFile())
                throw new Exception(imageFile + " is not image file error in CreateThumbnail!");

            File sImg = new File(todir, this.imageFileName);

            BufferedImage Bi = ImageIO.read(imageFile);
            // 假设图片宽 高 最大为130 80,使用默认缩略算法
            Image Itemp = Bi.getScaledInstance(this.zoomWidth, this.zoomHeight, Image.SCALE_DEFAULT);

            double Ratio = 0.0;
            if ((Bi.getHeight() > this.zoomWidth) || (Bi.getWidth() > this.zoomHeight)) {
                if (Bi.getHeight() > Bi.getWidth())
                    Ratio = Double.parseDouble(String.valueOf(this.zoomHeight)) / Double.parseDouble(String.valueOf(Bi.getHeight()));
                else
                    Ratio = Double.parseDouble(String.valueOf(this.zoomWidth)) / Double.parseDouble(String.valueOf(Bi.getWidth()));

                AffineTransformOp op = new AffineTransformOp(AffineTransform.getScaleInstance(Ratio, Ratio), null);
                Itemp = op.filter(Bi, null);
            }

            ImageIO.write((BufferedImage) Itemp, "jpg", sImg);
            imgPath = this.filePath + "zoom/" + this.imageFileName;
        } catch (IOException e) {
            e.printStackTrace();
            throw new Exception(e);
        }
    }

    /**
     * 添加文字水印
     *
     * @return
     * @throws Exception
     * @throws Exception
     */
    public void watermark(File img) throws Exception {
        log.debug("[watermark file name]--" + img.getPath());
        try {

            if (!img.exists()) {
                throw new IllegalArgumentException("file not found!");
            }

            log.debug("[watermark][img]--" + img);

            // 创建一个FileInputStream对象从源图片获取数据流
            FileInputStream sFile = new FileInputStream(img);

            // 创建一个Image对象并以源图片数据流填充
            Image src = ImageIO.read(sFile);

            // 得到源图宽
            int width = src.getWidth(null);
            // 得到源图长
            int height = src.getHeight(null);

            // 创建一个BufferedImage来作为图像操作容器
            BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
            // 创建一个绘图环境来进行绘制图象
            Graphics2D g = image.createGraphics();
            // 将原图像数据流载入这个BufferedImage
            log.debug("width:" + width + " height:" + height);
            g.drawImage(src, 0, 0, width, height, null);
            // 设定文本字体
            g.setFont(new Font("宋体", Font.BOLD, 28));
            String rand = this.textTitle;
            // 设定文本颜色
            g.setColor(Color.blue);
            // 设置透明度
            g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP, 0.5f));
            // 向BufferedImage写入文本字符,水印在图片上的坐标
            g.drawString(rand, width - (width - 20), height - (height - 60));
            // 使更改生效
            g.dispose();
            // 创建输出文件流
            FileOutputStream outi = new FileOutputStream(img);
            // 创建JPEG编码对象
            JPEGImageEncoder encodera = JPEGCodec.createJPEGEncoder(outi);
            // 对这个BufferedImage (image)进行JPEG编码
            encodera.encode(image);
            // 关闭输出文件流
            outi.close();
            sFile.close();

        } catch (IOException e) {
            e.printStackTrace();
            throw new Exception(e);
        }
    }


    /**
     * 添加图片水印
     */
    public void imageWaterMark(File imgFile) throws Exception {
        try {
            // 目标文件
            Image src = ImageIO.read(imgFile);
            int wideth = src.getWidth(null);
            int height = src.getHeight(null);
            BufferedImage image = new BufferedImage(wideth, height, BufferedImage.TYPE_INT_RGB);
            Graphics2D g = image.createGraphics();
            g.drawImage(src, 0, 0, wideth, height, null);

            // 水印文件 路径
            String waterImgPath = ConfigUtil.defaultHomePath() + ConfigUtil.FILE_SEPARATOR + this.waterImgPath;
            File waterFile = new File(waterImgPath);
            Image waterImg = ImageIO.read(waterFile);

            int w_wideth = waterImg.getWidth(null);
            int w_height = waterImg.getHeight(null);
            g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP, 0.5f));
            g.drawImage(waterImg, (wideth - w_wideth) / 2, (height - w_height) / 2, w_wideth, w_height, null);
            // 水印文件结束

            g.dispose();
            FileOutputStream out = new FileOutputStream(imgFile);
            JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
            encoder.encode(image);
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getTextTitle() {
        return textTitle;
    }

    public void setTextTitle(String textTitle) {
        this.textTitle = textTitle;
    }

    public String getWaterImgPath() {
        return waterImgPath;
    }

    public void setWaterImgPath(String waterImgPath) {
        this.waterImgPath = waterImgPath;
    }

    public File getFile() {
        return file;
    }

    public void setFile(File file) {
        this.file = file;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getContentType() {
        return contentType;
    }

    public void setContentType(String contentType) {
        this.contentType = contentType;
    }

    public String getImageFileName() {
        return imageFileName;
    }

    public void setImageFileName(String imageFileName) {
        this.imageFileName = imageFileName;
    }

    public String getIpath() {
        return ipath;
    }

    public void setIpath(String ipath) {
        this.ipath = ipath;
    }

    public String getImgPath() {
        return imgPath;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }

    public String getJson() {
        return json;
    }

    public void setJson(String json) {
        this.json = json;
    }

    public int getZoomWidth() {
        return zoomWidth;
    }

    public void setZoomWidth(int zoomWidth) {
        this.zoomWidth = zoomWidth;
    }

    public int getZoomHeight() {
        return zoomHeight;
    }

    public void setZoomHeight(int zoomHeight) {
        this.zoomHeight = zoomHeight;
    }

    public int getBufferSize() {
        return bufferSize;
    }

    public void setBufferSize(int bufferSize) {
        this.bufferSize = bufferSize;
    }
}
