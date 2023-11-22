package com.meta.crm.web.rest;

import com.meta.framework.common.annotation.Log;
import com.meta.framework.common.core.controller.BaseController;
import com.meta.framework.act.entity.SysUser;
import com.meta.framework.common.core.page.TableDataInfo;
import com.meta.framework.common.enums.BusinessType;
import com.meta.crm.intf.enums.OperateTypeEnum;
import com.meta.framework.common.utils.DateUtils;
import com.meta.platform.oplog.entity.OperateLog;
import com.meta.platform.oplog.req.ro.OperateLogRo;
import com.meta.platform.oplog.res.OperateLogVo;
import com.meta.platform.oplog.service.OpLogQryService;
import com.meta.act.app.service.ISysUserService;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.*;
import java.util.stream.Collectors;


@RestController
@RequestMapping("/opLog")
public class OpLogController extends BaseController {

	@Resource
	private OpLogQryService opLogQryService;

	@Resource
	private ISysUserService userService;

	@Log(title = "查询日志", businessType = BusinessType.QUERY)
	@GetMapping("/listOperateLog")
	public TableDataInfo listOperateLog(OperateLogRo req)
	{
		startPage();
		List<OperateLog>  logList = opLogQryService.listOperateLog(req);
		List<OperateLogVo> list = convertLogVoList(logList);
		return getDataTable(list);
	}

	public List<OperateLogVo> convertLogVoList(List<OperateLog>  logList) {
		List<OperateLogVo> list = new ArrayList<>();
		if (CollectionUtils.isNotEmpty(logList)) {
			// 批量根据ids获取用户体系接口用户信息map
			Map<Long, SysUser> userInfoMap = new HashMap<>();
			List<Long> userIds = logList.stream().map(v -> v.getCreateUserId()).collect(Collectors.toList());
			if (!CollectionUtils.isEmpty(userIds)) {
				List<SysUser> userInfos = userService.selectUserByIds(userIds);
				if (!CollectionUtils.isEmpty(userInfos)) {
					for (SysUser userInfo : userInfos) {
						userInfoMap.put(userInfo.getUserId(), userInfo);
					}
				}
			}
			// 循环设置操作日志VO
			logList.stream().forEach(operateLog -> {
				OperateLogVo vo = makeOpLogVo(operateLog, userInfoMap);
				list.add(vo);
			});
		}
		return list;
	}

	public OperateLogVo makeOpLogVo(OperateLog opLog, Map<Long, SysUser> userInfoMap) {
		OperateLogVo vo = new OperateLogVo();
		vo.setCreateTimeStr(DateUtils.dateToStr(opLog.getCreateTime()));
		vo.setContent(opLog.getContent());
		vo.setOperateType(opLog.getOperateType());
		vo.setCreateUserId(opLog.getCreateUserId());
		vo.setBusinessKey(opLog.getBusinessKey());
		vo.setBusinessType(opLog.getBusinessType());
		for(OperateTypeEnum typeEnum:OperateTypeEnum.values()){
			if(opLog.getOperateType().equals(typeEnum.getCode())){
				vo.setOperateTypeDesc(typeEnum.getDesc());
				break;
			}
		}
		// 设置操作人姓名
		vo.setCreateUserName("未知");
		if(opLog.getCreateUserId() != null){
			SysUser userInfo = userInfoMap.get(opLog.getCreateUserId());
			if (null != userInfo && null != userInfo.getNickName()) {
				vo.setCreateUserName(userInfo.getNickName());
			}
		}
		return vo;
	}
}
