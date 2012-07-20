//注释不影响javascript的，当使编辑器时，有些不支持javascript的编辑器不会影响绵编辑
//去掉左边的空格
function lTrim(str) {
    var i;
    for (i = 0; i < str.length; i++) {
        if (str.charAt(i) != " ") break;
    }
    str = str.substring(i, str.length);
    return str;
    var j;
    for (j = 0; j < str.length; j++) {
        if (str.charAt(j) != " ") {
            break;
        }
    }
    str = str.substring(j, str.length);
    return str;
}
//去掉右边的空格
function rTrim(str) {
    var i;
    for (i = str.length - 1; i >= 0; i--) {
        if (str.charAt(i) != " ") {
            break;
        }
    }
    str = str.substring(0, i + 1);
    return str;
}
//去掉两边的空格
function Trim(str) {
    return lTrim(rTrim(str));
}

/**
 *javascript公用函数文件。
 */


/**
 *判断字符串str是否为空或全为空格。如果为空字符串或全由空格组成，返回true,否则返回false.
 */
function isBlank(str)
{
    for (var i = 0; i < str.length; i++)
        if (str.charAt(i) != " ")
            return false;
    return true;
}

/**
 *返回字符串的长度
 */
function stringLength(str)
{
    return str.length;
}
/**
 *返回中英文混排的字符串的长度
 */
function stringComplexLength(str)
{
    return str.replace(/[^\x00-\xff]/g, "**").length;
}

/**
 *判断字符串的长度是不是合适,大于等于mixLen,小于等于maxLen
 */
function isStringLengthValidated(str, mixLen, maxLen)
{
    var len = stringLength(str);
    if (len < mixLen || len > maxLen)
        return false;
    return true;

}
/**
 *判断中英文的长度是不是合适,大于等于mixLen,小于等于maxLen
 */
function isStrComplexLengthValidated(str, mixLen, maxLen)
{
    var len = stringComplexLength(str);
    if (len < mixLen || len > maxLen)
        return false;
    return true;

}

/**
 *判断表单theForm中是否有复选框被选中。如果有，返回true,否则返回false.
 *请慎用！建议使用isAnyNamedBoxSelected()方法
 */
function isAnyBoxSelected(theForm)
{
    for (var i = 0; i < theForm.length; i++)
        if (theForm.elements[i].type == "checkbox" && theForm.elements[i].checked)
            return true;
    return false;
}

/**
 *判断表单theForm中是否有名为Name的复选框被选中。如果有，返回true,否则返回false.
 */

function isAnyNamedBoxSelected(theForm, Name)
{
    for (var i = 0; i < theForm.length; i++)
        if (theForm.elements[i].type == "checkbox" && theForm.elements[i].name == Name && theForm.elements[i].checked)
            return true;
    return false;
}

/**
 *判断表单theForm中是否有名为Name的控件被选中。如果有，返回true,否则返回false.
 */

function isAnyNamedElementSelected(theForm, Name)
{
    for (var i = 0; i < theForm.length; i++)
        if (theForm.elements[i].type == "checkbox" && theForm.elements[i].name == Name && theForm.elements[i].checked)
            return true;
        else if (theForm.elements[i].type == "hidden" && theForm.elements[i].name == Name)
            return true;
        else if (theForm.elements[i].type.indexOf("select") >= 0 && theForm.elements[i].name == Name && theForm.elements[i].value != "")
                return true;
    return false;
}

/**
 *将theBox所在表单中所有的复选框的选中状态与theBox一致。
 */
function selAllBoxes(theBox)
{
    var theForm = theBox.form;
    for (var i = 0; i < theForm.length; i++)
    {
        if (theForm.elements[i].type == "checkbox" && theForm.elements[i].disabled == false)
        {
            theForm.elements[i].checked = theBox.checked;
        }
    }
}

/**
 *将theBox所在表单中所有名为Name的复选框的选中状态与theBox一致。
 */
function selectAllBoxes(theBox, Name)
{
    var theForm = theBox.form;
    for (var i = 0; i < theForm.length; i++)
        if (theForm.elements[i].type == "checkbox" && theForm.elements[i].name == Name)
            theForm.elements[i].checked = theBox.checked;
}

/**
 *删除下拉列表框theSel中选中的选项。
 */
function deleteItem(theSel)
{
    var num = theSel.length;
    var i = 0,j = 0;
    while (i < num)
    {
        if (!theSel.options[i].selected)
        {
            theSel.options[j].text = theSel.options[i].text;
            theSel.options[j].value = theSel.options[i].value;
            theSel.options[j].selected = false;
            j++;
        }
        i++;
    }
    theSel.length = j;
}

/**
 *判断字符串ItemName是否在下拉列表框theSel的选项名字中，如果在，返回true,否则返回false。
 */
function isInSelect(ItemName, theSel)
{
    var num = theSel.length;
    for (var i = 0; i < num; i++)
    {
        if (theSel.options[i].text == ItemName)
        {
            return true;
        }
    }
    return false;
}

/**
 *判断字符串ItemValue是否在下拉列表框theSel的选项值中，如果在，返回true,否则返回false。
 */
function isValueInSelect(ItemValue, theSel)
{
    var num = theSel.length;
    for (var i = 0; i < num; i++)
    {
        if (theSel.options[i].value == ItemValue)
        {
            return true;
        }
    }
    return false;
}

/**
 *将一个新的选项（名字和值）加入下拉列表框中，如果该选项已在下拉列表框中，则弹出提示对话框。
 */
function addItemToSelect(ItemName, ItemValue, theSel)
{
    var num = theSel.length;
    if (!isValueInSelect(ItemValue, theSel))
    {
        theSel.length = num + 1;
        theSel.options[num].text = ItemName;
        theSel.options[num].value = ItemValue;
    }
    //else
    //alert("该项已在选项中！");
}

/**
 *将下拉列表框sSel中选中的选项加到下拉列表框dSel中。
 */
function addSelectToSelect(sSel, dSel)
{
    var snum = sSel.length;
    var dnum;
    var isExists = false;
    for (var i = 0; i < snum; i++)
    {
        if (sSel.options[i].selected && !isInSelect(sSel.options[i].text, dSel))
        {
            dnum = dSel.length;
            dSel.length = dnum + 1;
            dSel.options[dnum].text = sSel.options[i].text;
            dSel.options[dnum].value = sSel.options[i].value;
        }
    }
}

/**
 *将下拉列表框sSel中选中的选项移动到下拉列表框dSel中。
 */
function moveSelectToSelect(sSel, dSel)
{
    var snum = sSel.length;
    var dnum;
    var isExists = false;
    var j = 0;
    isExists = isAnyItemSelected(sSel);
    if (isExists)
    {
        for (var i = 0; i < snum; i++)
        {
            //通过名字判断是否被选择
            // if( sSel.options[i].selected && !isInSelect(sSel.options[i].text, dSel))
            //通过名字对应的值来判断是否被选择
            if (sSel.options[i].selected && !isValueInSelect(sSel.options[i].value, dSel))
            {
                dnum = dSel.length;
                dSel.length = dnum + 1;
                dSel.options[dnum].text = sSel.options[i].text;
                dSel.options[dnum].value = sSel.options[i].value;
            }
            if (!sSel.options[i].selected)
            {
                sSel.options[j].text = sSel.options[i].text;
                sSel.options[j].value = sSel.options[i].value;
                sSel.options[j].selected = false;
                j++;
            }
        }
        sSel.length = j;
    }
    else
    {
        alert("Please select the records you want to move");
    }
}


/**
 *下拉列表框拷贝（将下拉列表框sSel中的所有选项复制并覆盖到下拉列表框dSel中）。
 */
function copySelectToSelect(sSel, dSel)
{
    var snum = sSel.length;
    dSel.length = snum;
    for (var i = 0; i < snum; i++)
    {
        dSel.options[i].text = sSel.options[i].text;
        dSel.options[i].value = sSel.options[i].value;
    }
}

/**
 *下拉列表框拷贝（将下拉列表框sSel中的所有选项复制并加上相应的值，然后覆盖到下拉列表框dSel中）。
 */
function copySelectToSelect(sSel, dSel)
{
    var snum = sSel.length;
    dSel.length = snum;
    for (var i = 0; i < snum; i++)
    {
        dSel.options[i].text = sSel.options[i].text;
        dSel.options[i].value = sSel.options[i].value;
    }
}

/**
 *选中下拉列表框theSel中所有的选项。
 */
function selectAllItems(theSel)
{
    var num = theSel.length;
    for (var i = 0; i < num; i++)
    {
        theSel.options[i].selected = true;
    }
}

/**
 *判断下拉列表框theSel中是否有选项被选中，如果有返回true,否则返回false。
 */
function isAnyItemSelected(theSel)
{
    var num = theSel.length;
    for (var i = 0; i < num; i++)
        if (theSel.options[i].selected)
            return true;
    return false;
}

/**
 *找出表单theForm中第一个被选中的名为Name的复选框的位置。如果有，返回在表单中的位置,否则返回0.
 */
function findFirstSelectedNamedBox(theForm, Name)
{
    for (var i = 0; i < theForm.length; i++)
        if (theForm.elements[i].type == "checkbox" && theForm.elements[i].name == Name && theForm.elements[i].checked)
            return i;
    return 0;
}

/**
 *判断表单theForm中是否有名为Name的单选框被选中。如果有，返回true,否则返回false.
 */
function isAnyNamedRadioSelected(theForm, Name)
{
    for (var i = 0; i < theForm.length; i++)
        if (theForm.elements[i].type == "radio" && theForm.elements[i].name == Name && theForm.elements[i].checked)
            return true;
    return false;
}

/**
 *找出表单theForm中第一个被选中的名为Name的单选框的位置。如果有，返回在表单中的位置,否则返回0.
 */
function findFirstSelectedNamedRadio(theForm, Name)
{
    for (var i = 0; i < theForm.length; i++)
        if (theForm.elements[i].type == "radio" && theForm.elements[i].name == Name && theForm.elements[i].checked)
            return i;
    return 0;
}

/**
 *判断表单theForm中是否有名子中包含Name的文本域有内容。如果有，返回true,否则返回false.
 */
function isAnyNamedTextFilled(theForm, Name)
{
    for (var i = 0; i < theForm.length; i++)
        if ((theForm.elements[i].type == "text" || theForm.elements[i].type == "textarea") && theForm.elements[i].name.indexOf(Name) >= 0 && !isBlank(theForm.elements[i].value))
            return true;
    return false;
}

/**
 *得到文件类型
 */
function getFileType(FilePath)
{
    var i = FilePath.lastIndexOf(".");
    if (i < 0) return "";
    return FilePath.substring(i + 1, FilePath.length);
}

/*
 *判断某个值是否为合法的数
 */
function isDigitValue(value)
{
    if (value == null)
        return false;

    var flag = true;
    var spot = 0;
    var objValue = trim(value);
    for (var i = 0; i < objValue.length; i++)
    {
        var pstr = objValue.substring(i, i + 1);
        if (pstr >= 0 && pstr <= 9 || pstr == ".")
        {
            if (pstr == ".")
                spot++;
            continue;
        }
        else {
            flag = false;
            break;
        }
    }

    if (spot > 1)
    {
        flag = false;

    }
    return flag;
}

/*
 *判断某个控件的值是否为合法的数
 */
function isDigitObj(obj)
{
    if (obj == null)
        return false;

    return isDigitValue(obj.value);

}

/*
 *判断某个值是否为正整数
 */
function isNumberValue(value)
{

    if (value == null)
        return false;

    var flag = true;
    var objValue = trim(value);

    for (var i = 0; i < objValue.length; i++)
    {
        var pstr = objValue.substring(i, i + 1);
        if (pstr >= 0 && pstr <= 9)
        {
            continue;
        }
        else
        {
            flag = false;
            break;
        }
    }


    return flag;

}


/*
 *判断某个控件的值是否为正整数
 */
function isNumberObj(obj)
{

    if (obj == null)
        return false;

    return isNumberValue(obj.value);

}

/**
 *去掉字串两边的空格
 */
function trim(str)
{
    return lTrim(rTrim(str));
}

function isNumber(s) {
    var regu = /^[0-9|-][0-9]{0,}$/;
    return regu.test(s);
}
/**
 *检查email是否合法
 */
function validateEmail(j) {
    var emailReg = /^([a-zA-Z0-9_\-\.\+]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
    return emailReg.test(j);
}


function isEmail(s) {
    //验证Email
    var regu = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
    return regu.test(s);
}
function checkeURL(str_url){
	var str=str_url;
	//在JavaScript中，正则表达式只能使用"/"开头和结束，不能使用双引号
	//判断URL地址的正则表达式为:http(s)?://([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)?
	//下面的代码中应用了转义字符"\"输出一个字符"/"
	var Expression=/^((https|http|ftp|rtsp|mms)?:\/\/)([\w-]+\.)+[\w-]+(\/[\w- .\/?%&=]*)?/;
	var objExp=new RegExp(Expression);
	if(objExp.test(str)==true){
		return true;
	}else{
		return false;
	}
}
//包含子域名和端口的验证
function isURL(str_url) {
    var strRegex = "^((https|http|ftp|rtsp|mms)?://)"
            + "?(([0-9a-z_!~*'().&=+$%-]+: )?[0-9a-z_!~*'().&=+$%-]+@)?" //ftp的user@
            + "(([0-9]{1,3}\.){3}[0-9]{1,3}" // IP形式的URL- 199.194.52.184
            + "|" // 允许IP和DOMAIN（域名）
            + "([0-9a-z_!~*'()-]+\.)*" // 域名- www.
            + "([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\." // 二级域名
            + "[a-z]{2,6})" // first level domain- .com or .museum
            + "(:[0-9]{1,4})?" // 端口- :80
            + "((/?)|" // a slash isn't required if there is no file name
            + "(/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+/?)$";
    var re = new RegExp(strRegex);
    return re.test(str_url);

}
function isPhone(s) {
    var regu = /(^[0-9]{3,4}\-[0-9]{7,8}$)|(^[0-9]{7,8}$)|(^\([0-9]{3,4}\)[0-9]{3,8}$)|(^0{0,1}1[0-9]{10}$)/;
    return regu.test(s);
}
 //校验(国内)邮政编码
function isZipcode(s){
 	var pattern =/^[0-9]{6}$/;
 	return pattern.exec(s);
}
//判断文件上传的后缀名
//p为文件路径，ext为需要的后缀名
function checkFile(p,ext){
	 //获取欲上传的文件路径
	var filepath = p; 
	//为了避免转义反斜杠出问题，这里将对其进行转换
	var re = /(\\+)/g;  
	var filename=filepath.replace(re,"#"); 
	//对路径字符串进行剪切截取
	var one=filename.split("#"); 
	//获取数组中最后一个，即文件名
	var two=one[one.length-1]; 
	//再对文件名进行截取，以取得后缀名
	var three=two.split("."); 
	 //获取截取的最后一个字符串，即为后缀名
	var last=three[three.length-1];
	if(last.toLowerCase() == ext.toLowerCase()){
		return true;
	}else{
		alert("您输入文件格式只能是“"+ext+"”");
		return false;
	}
}

//判断文件上传的后缀名在给定的后缀名中,多个后缀名使用“,”隔开
//p为文件路径，ext为需要的后缀名
function checkFiles(p,ext){
	if(!p){
		return false;
	}
	if(!ext){
		return true;
	}
	if(ext.lastIndexOf(",") != ext.length - 1){
		ext = ext + ",";
	}
	 //获取欲上传的文件路径
	var filepath = p; 
	//为了避免转义反斜杠出问题，这里将对其进行转换
	var re = /(\\+)/g;  
	var filename=filepath.replace(re,"#"); 
	//对路径字符串进行剪切截取
	var one=filename.split("#"); 
	//获取数组中最后一个，即文件名
	var two=one[one.length-1]; 
	//再对文件名进行截取，以取得后缀名
	var three=two.split("."); 
	 //获取截取的最后一个字符串，即为后缀名
	var last=three[three.length-1];
	if(-1 != ext.toLowerCase().indexOf(last.toLowerCase()+",")){
		return true;
	}else{
		alert("您输入文件格式只能是“"+ext+"”");
		return false;
	}
}
/*是否包含系统禁用的字符*/ 
function invalidStrInSys(s) { 
	var valid=/[\'\"\,\<\>\+\-\*\/\%\^\=\\\!\&\|\(\)\[\]\{\}\:\;\~\`\#\$\‘\’\“\”]+/; 
	return (valid.test(s));
}
/*是否包含禁用字符*/
function hasInvalidChar(s) { 
	var iu, iuu, regArray=new Array("◎","■","●","№","↑","→","↓"+
       "!","@","#","$","%","^","&","*","(",")","_","-","+","=","|","'","[","]","？","~","`"+
       "!","<",">","‰","→","←","↑","↓","¤","§","＃","＆","＆","＼","≡","≠"+
       "≈","∈","∪","∏","∑","∧","∨","⊥","∥","∥","∠","⊙","≌","≌","√","∝","∞","∮"+
       "∫","≯","≮","＞","≥","≤","≠","±","＋","÷","×","／","Ⅱ","Ⅰ","Ⅲ","Ⅳ","Ⅴ","Ⅵ","Ⅶ","Ⅷ","Ⅹ","Ⅻ","㈠","㈡"+
       "╄","╅","╇","┻","┻","┇","┭","┷","┦","┣","┝","┤","┷","┷","┹","╉","╇","【","】"+
       "㈢","㈣","㈤","㈥","㈦","㈧","㈨","㈩","①","②","③","④","⑤","⑥","⑦","⑧","⑨","⑩","┌","├","┬","┼","┍","┕","┗","┏","┅","─"+
       "〖","〗","←","〓","☆","§","□","‰","◇","︿","＠","△","▲","＃","℃","※",".","≈","￠"); 
       iuu=regArray.length;
       for(iu=1;iu<=iuu;iu++){
              if (s.indexOf(regArray[iu])!=-1){
                     return true;
              }
       }
       return false;
}
/*将url中的特殊字符进行替换*/
function urlStrEncode(s) {
	if(isBlank(s)){
		return "";
	}
	var u = s;
	u = u.replace(/\%/g,"%25");//必须放在第一个
	u = u.replace(/\+/g,"%2B");
	u = u.replace(/ /g,"%20");
	u = u.replace(/\//g,"%2F");
	u = u.replace(/\?/g,"%3F");
	u = u.replace(/\#/g,"%23");
	u = u.replace(/\&/g,"%26");
	u = u.replace(/\=/g,"%3D");
	return u;
}
/**
 * 验证是否合理的数字，整数位数小于intField,小数位数小于decField
 * @returns {Boolean}
 */
function validateDeci(objValue,intField,decField,min,max,canNull){
	if(!objValue){
		if(canNull){
			return true;
		}else{
			return false;
		}
	}
	var reg = new RegExp("^\\d{1,"+intField+"}(\\.)?\\d{0,"+decField+"}$");
	if(!reg.test(objValue)){
		return false;
	}
	var num = eval(objValue);
	if(num < min || num > max){
		return false;
	}
	return true;
}
/**
 * 验证是否合理的数字，可以包含小数，并且在min，max之间
 * @param objValue 需要验证的值
 * @param min 最小值
 * @param max 最大值
 * @param canNull 该值是否允许为空，如果允许为空，同时objValue为空则不验证，并返回true，
 * 如果不允许为空，则进行验证
 * @returns {Boolean}
 */
function validateNum(objValue,min,max,canNull){
	if(!objValue){
		if(canNull){
			return true;
		}else{
			return false;
		}
	}
		if(!/^\d*(\.)?\d*$/.test(objValue)){
			return false;
		}else{
			var num = eval(objValue);
			if(num < min || num > max){
				return false;
			}
		}
		return true;
}
/**
 * 验证是否是合理的整数包含整数或负数，在min,max之间，如果canNull为true，则当该值是空时，不做验证，否则验证。
 * @param objValue
 * @param min
 * @param max
 * @param canNull
 * @returns {Boolean}
 */
function isValidateNumber(objValue,min,max,canNull) {
	if(!objValue){
		if(canNull){
			return true;
		}else{
			return false;
		}
	}
		if(!/^[0-9|-][0-9]{0,}$/.test(objValue)){
			return false;
		}else{
			var num = eval(objValue);
			if(num < min || num > max){
				return false;
			}
		}
		return true;
}

/**
 * 验证select是否选中。如果有headValue，当前选项不能等于headValue并且不能为空；若没有headValue，当前选项不能为空
 * @param objValue
 * @param headValue 默认选项的值
 * @returns {Boolean}
 */
function isValidateSelect(objValue,headValue) {
	if((headValue || headValue=="0") && objValue == headValue){
		return false;
	}
	if(!objValue){
		return false;
	}
	return true;
}
