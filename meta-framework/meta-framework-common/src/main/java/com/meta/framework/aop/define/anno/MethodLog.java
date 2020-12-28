/**   
* @title LogToPscAnn.java 
* @package com.valueplus.invent.system.common.com.valueplue.express.common.anno
* @describe TODO
* @author M.simple 
* @datetime 2017年7月12日 下午1:29:26 
* @version v1.0   
*/ 
package com.meta.framework.aop.define.anno;



import com.meta.framework.aop.define.MethodLogLevel;

import java.lang.annotation.*;

/**
 * 方法级别日志注解
 * @Title:      MethodLog
 * @Package:    com.metafnt.aladdin.common.mq.define.anno.MethodLog
 * @Author:     M.simple
 * @Remark:     The modified content
 * @CreateDate: 2019-04-26 15:54
 * @Version:    v2.0
 */
@Target(value = {ElementType.METHOD})
@Retention(value = RetentionPolicy.RUNTIME)
@Documented
public @interface MethodLog {

	/** 
	* 操作类型
	* @return 代码
	* @author M.simple
	* @version 1.0
	*/ 
	MethodLogLevel methodLogLevel();
}
