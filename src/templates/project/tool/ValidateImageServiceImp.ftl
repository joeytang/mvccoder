package ${project.org}.tool.validateimg;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.imageio.stream.ImageOutputStream;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * To change this template use File | Settings | File Templates.
 */
public class ValidateImageServiceImp implements ValidateImageService{
/**
	 * Logger for this class
	 */
	private static final Log logger = LogFactory.getLog(ValidateImageServiceImp.class);

	private static final int MIN_FONT_SIZE = 14;
	private static final int DEFAULT_WIDTH = 85;
	private static final int DEFAULT_HEIGHT = 20;
	private static final int DEFAULT_CODE_LENGTH = 4;

	private int disturbType = disturb_Type_Simple;
	private int codeLength = DEFAULT_CODE_LENGTH;
	private int width = DEFAULT_WIDTH;
	private int height = DEFAULT_HEIGHT;

	private Color bgColor;
	private Color borderColor;

	private int[] fontStyles;
	private int[] fontSizes;
	private String[] fontNames;
	private String[] chineseFontNames;
	private Color[] fontColors;

	private Random random = new Random();

	String validateCode;


	private String code;
	private ByteArrayInputStream image;

	public ValidateImageServiceImp() {
	}

	public void set(int disturbType, int width, int height, int codeLength) {
		this.disturbType = disturbType;
		this.width = width;
		this.height = height;
		this.codeLength = codeLength;
	}


	public void create() {
		checkParam();
		//在内存中创建图象
		BufferedImage iamge = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		//获取图形上下文
		Graphics g = iamge.getGraphics();

        //绘制边框
        drawOutline(g, width, height);

        //绘制干扰线
        switch (disturbType) {
	        case disturb_Type_Simple:
	            drawSimpleDisturb(g, random, width, height);
	            break;
	        case disturb_Type_Complex:
	            drawDisturb(g, random, width, height);
	            break;
	        case disturb_Type_Star:
	        	drawDisturbStar(g, random);
	        	break;
	        default:
	            break;
	    }

        drawCode(g, codeLength, width, height);

        g.dispose();
        ByteArrayOutputStream output = new ByteArrayOutputStream();
        try {
            ImageOutputStream imOut = ImageIO.createImageOutputStream(output);
            ImageIO.write(iamge, "JPEG", imOut);
            imOut.close();
            image = new ByteArrayInputStream(output.toByteArray());
        } catch (IOException e) {
        	logger.error("error when make image: " + e.toString());
        } finally {
        	try {
				output.close();
			} catch (IOException e) {
				logger.error(e.getMessage());
			}
        }

	}



	private void checkParam() {
		if(width <= 0) {
			width = DEFAULT_WIDTH;
		}
		if(height <= 0) {
			height = DEFAULT_HEIGHT;
		}
		if(codeLength <= 0) {
			codeLength = DEFAULT_CODE_LENGTH;
		}
		if(disturbType < 0 || disturbType > 2) {
			disturbType = disturb_Type_Simple;
		}
	}

	/**
     * 绘制边框
     * @param g
     * @param width
     * @param height
     */
    private void drawOutline(Graphics g, int width, int height){
        //设定背景色
    	if(bgColor == null) {
    		bgColor = getRandomColor(random, 200,250);
    	}
    	g.setColor(bgColor);

    	g.fillRect(0, 0, width, height);

    	if(logger.isDebugEnabled()) {
    		logger.debug("bgColor: " + bgColor);
    		logger.debug("width: " + width);
    		logger.debug("height: " + height);
    	}

    	//设定边框颜色
    	if(borderColor == null) {
    		borderColor = Color.BLACK;
    	}
    	g.setColor(borderColor);

        g.drawRect(0, 0, width-1, height-1);
    	if(logger.isDebugEnabled()) {
    		logger.debug("borderColor: " + borderColor);
    	}
    }

	/**
	 * 在图片背景上增加噪点
	 * @param g
	 * @param random2
	 */
	private void drawDisturbStar(Graphics g, Random random2) {
		g.setColor(getRandomColor(random, 160, 200));
		g.setFont(new Font("Times New Roman", Font.PLAIN, 14));
		for (int i = 0; i < 6; i++) {
			g.drawString("*********************************************", 0,
					5 * (i + 2));
		}
	}

    /**
     * 绘制比较复杂的干扰线
     * @param g
     * @param random
     * @param width
     * @param height
     */
    private static void drawDisturb(Graphics g, Random random, int width, int height){
        int x,y,x1,y1;
        for(int i=0;i<width;i++){
            x = random.nextInt(width);
            y = random.nextInt(height);
            x1 = random.nextInt(12);
            y1 = random.nextInt(12);
            g.setColor(getRandomColor(random,120,255));
            g.drawLine(x,y,x+x1,y+y1);
            g.fillArc(x,y,x1,y1,random.nextInt(360),random.nextInt(360));
        }
    }

    /**
     * 绘制简单的干扰线
     * @param g
     * @param random
     * @param width
     * @param height
     */
    private static void drawSimpleDisturb(Graphics g, Random random, int width, int height){
        g.setColor(getRandomColor(random,160,200));
        for (int i=0;i<155;i++)
        {
            int x = random.nextInt(width);
            int y = random.nextInt(height);
                int xl = random.nextInt(12);
                int yl = random.nextInt(12);
            g.drawLine(x,y,x+xl,y+yl);
        }
    }

    /**
     * 绘制验证码
     * @param g
     * @param codeLength
     * @param width
     * @param height
     * @return
     */
    private void drawCode(Graphics g, int codeLength, int width, int height) {

		// 如果没有设定验证字符串使用默认。
		if (null == validateCode) {
			validateCode = default_ValidateCode;
		}

		if (fontSizes != null && fontSizes.length > 0) {
			for (int i = 0; i < fontSizes.length; i++) {
				// 字体大小适应图片高度
				if (fontSizes[i] >= height) {
					fontSizes[i] = height - 1;
				}
			}
		}

		if (fontStyles == null || fontStyles.length == 0) {
			fontStyles = new int[] { Font.BOLD };
		}

		if (fontNames == null || fontNames.length == 0) {
			fontNames = new String[] { "Verdana", "serif" };
		}

		if (chineseFontNames == null || chineseFontNames.length == 0) {
			chineseFontNames = new String[] { "宋体"};
		}

		StringBuffer sb = new StringBuffer();
		int x, y;
		Font font;
		Font chFont;
		int fontSize;
		char randChar;
		Color fontColor;
		String fontName;
		String chFontName;
		int fontStyle;
		for (int i = 0; i < codeLength; i++) {
			fontSize = getFontSize();
			fontName = (String)getRandom(fontNames, random);
			chFontName = (String)getRandom(chineseFontNames, random);
			fontStyle = getRandom(fontStyles, random);
			font = new Font(fontName, fontStyle, fontSize);
			chFont = new Font(chFontName, fontStyle, fontSize);

			x = (width / codeLength - 1) * i + random.nextInt(width / (codeLength * 2));
			y = random.nextInt(height - fontSize) + fontSize;
			randChar = getRandomChar(validateCode, random);

			sb.append(randChar);

			if (fontColors == null || fontColors.length  == 0) {
				fontColor = getRandomColor(random, 70, 150);
			} else {
				fontColor = (Color)getRandom(fontColors, random);
			}
			g.setColor(fontColor);

			if(sb.substring(i).getBytes().length > 1) {
				g.setFont(chFont);
				g.drawString(sb.substring(i), x, y);
			} else {
				g.setFont(font);
				g.drawString(sb.substring(i), x, y);
			}

			if(logger.isDebugEnabled()) {
				logger.debug(sb.substring(i) + "(fontSize:" + fontSize + "; fontColor:" + fontColor + "; fontName:" + fontName + "; fontStyle:" + getFontStyle(fontStyle) + ";)");
			}
		}
		code = sb.toString();
		if(logger.isDebugEnabled()) {
			logger.debug("make code success: code = " + code);
		}
	}

    private String getFontStyle(int fontStyle) {
    	String font = null;
		switch (fontStyle) {
			case Font.BOLD:
				font = "BOLD";
				break;

			case Font.ITALIC:
				font = "ITALIC";
				break;

			case Font.PLAIN:
				font = "PLAIN";
				break;
			default:
				font = String.valueOf(fontStyle);
				break;
		}
		return font;
	}

	/**
     * 取得字体大小
     *
     * @return
     */
	private int getFontSize() {
		int fontSize;
		if (fontSizes == null || fontSizes.length == 0) {
			fontSize = MIN_FONT_SIZE + random.nextInt(height - MIN_FONT_SIZE - 1);
		} else {
			fontSize = getRandom(fontSizes, random);
		}
		return fontSize;
	}

	/**
     * 取得随机数组中的一个
     * @param na
     * @param random
     * @return
     */
    private int getRandom(int[] na, Random random) {
		return na[random.nextInt(na.length)];
	}

	/**
     * 取得随机数组中的一个
     * @param sa
     * @param random
     * @return
     */
	private Object getRandom(Object[] sa, Random random) {
		return sa[random.nextInt(sa.length)];
	}

	/**
     * 取得随机字符
     * @param validateCode
     * @param random
     * @return
     */
    private static char getRandomChar(String validateCode, Random random){
        return validateCode.charAt(random.nextInt(validateCode.length()));
    }

    /**
     * 取得随机颜色
     * @param random
     * @param pMin
     * @param pMax
     * @return
     */
    private static Color getRandomColor(Random random, int pMin,int pMax){
        pMax = (Math.abs(pMax) > 255 ? 255 : Math.abs(pMax));
        pMin = (Math.abs(pMin) > 255 ? 255 :Math.abs(pMin));

        int r = pMin + random.nextInt(Math.abs(pMax - pMin));
        int g = pMin + random.nextInt(Math.abs(pMax - pMin));
        int b = pMin + random.nextInt(Math.abs(pMax - pMin));

        return new Color(r,g,b);
    }

	public String getCode() {
		return code;
	}

	public ByteArrayInputStream getImage() {
		return image;
	}

	public void setValidateCode(String validateCode) {
		this.validateCode = validateCode;
	}

	public void setFontName(String fontName) {
		this.fontNames = new String[]{ fontName };
	}

	public void setFontNames(String[] fontNames) {
		this.fontNames = fontNames;
	}

	public void setChineseFontName(String chineseFontName) {
		this.chineseFontNames = new String[] { chineseFontName };

	}

	public void setChineseFontNames(String[] chineseFontNames) {
		this.chineseFontNames = chineseFontNames;
	}

	public void setFontSize(int fontSize) {
		this.fontSizes = new int[] { fontSize };
	}

	public void setFontSizes(int[] fontSizes) {
		this.fontSizes = fontSizes;
	}

	public void setFontStyle(int fontStyle) {
		this.fontStyles = new int[] { fontStyle };
	}

	public void setFontStyles(int[] fontStyles) {
		this.fontStyles = fontStyles;
	}

	public void setFontColor(Color fontColor) {
		this.fontColors = new Color[] { fontColor };
	}

	public void setFontColors(Color[] fontColors) {
		this.fontColors = fontColors;
	}
}
