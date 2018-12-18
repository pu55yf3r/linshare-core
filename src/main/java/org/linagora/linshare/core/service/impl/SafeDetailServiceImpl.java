/*
 * LinShare is an open source filesharing software, part of the LinPKI software
 * suite, developed by Linagora.
 * 
 * Copyright (C) 2017-2018 LINAGORA
 * 
 * This program is free software: you can redistribute it and/or modify it under
 * the terms of the GNU Affero General Public License as published by the Free
 * Software Foundation, either version 3 of the License, or (at your option) any
 * later version, provided you comply with the Additional Terms applicable for
 * LinShare software by Linagora pursuant to Section 7 of the GNU Affero General
 * Public License, subsections (b), (c), and (e), pursuant to which you must
 * notably (i) retain the display of the “LinShare™” trademark/logo at the top
 * of the interface window, the display of the “You are using the Open Source
 * and free version of LinShare™, powered by Linagora © 2009–2018. Contribute to
 * Linshare R&D by subscribing to an Enterprise offer!” infobox and in the
 * e-mails sent with the Program, (ii) retain all hypertext links between
 * LinShare and linshare.org, between linagora.com and Linagora, and (iii)
 * refrain from infringing Linagora intellectual property rights over its
 * trademarks and commercial brands. Other Additional Terms apply, see
 * <http://www.linagora.com/licenses/> for more details.
 * 
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
 * details.
 * 
 * You should have received a copy of the GNU Affero General Public License and
 * its applicable Additional Terms for LinShare along with this program. If not,
 * see <http://www.gnu.org/licenses/> for the GNU Affero General Public License
 * version 3 and <http://www.linagora.com/licenses/> for the Additional Terms
 * applicable to LinShare software.
 */
package org.linagora.linshare.core.service.impl;

import java.util.List;

import org.apache.commons.lang.Validate;
import org.linagora.linshare.core.domain.constants.AuditLogEntryType;
import org.linagora.linshare.core.domain.constants.LogAction;
import org.linagora.linshare.core.domain.entities.Account;
import org.linagora.linshare.core.exception.BusinessErrorCode;
import org.linagora.linshare.core.exception.BusinessException;
import org.linagora.linshare.core.service.LogEntryService;
import org.linagora.linshare.core.service.SafeDetailService;
import org.linagora.linshare.mongo.entities.SafeDetail;
import org.linagora.linshare.mongo.entities.logs.SafeDetailAuditLogEntry;
import org.linagora.linshare.mongo.repository.SafeDetailMongoRepository;
import org.linagora.linshare.core.rac.SafeDetailResourceAccessControl;

public class SafeDetailServiceImpl extends GenericServiceImpl<Account, SafeDetail> implements SafeDetailService {

	protected SafeDetailMongoRepository safeDetailMongoRepository;

	protected LogEntryService logEntryService;

	protected String countryCode;

	protected String controlKey;

	protected String iufsc;

	public SafeDetailServiceImpl(SafeDetailMongoRepository safeDetailMongoRepository,
			LogEntryService logEntryService,
			SafeDetailResourceAccessControl rac,
			String countryCode,
			String controlKey,
			String iufsc) {
		super(rac);
		this.safeDetailMongoRepository = safeDetailMongoRepository;
		this.logEntryService = logEntryService;
		if (countryCode.length() != 2 || controlKey.length() != 2 || iufsc.length() != 8) {
			throw new IllegalArgumentException("SafeDetail Invalid arguments");
		}
		this.countryCode = countryCode;
		this.controlKey = controlKey;
		this.iufsc = iufsc;
	}

	@Override
	public SafeDetail create(Account authUser, Account actor, SafeDetail safeDetail) {
		safeDetail.setAccountUuid(actor.getLsUuid());
		safeDetail.setControlKey(controlKey);
		safeDetail.setCountryCode(countryCode);
		safeDetail.setIufsc(iufsc);
		SafeDetail safeDetailToPersist = new SafeDetail(safeDetail);
		checkCreatePermission(authUser, actor, SafeDetail.class,
				BusinessErrorCode.SAFE_DETAIL_CAN_NOT_CREATE, safeDetailToPersist);
		List<SafeDetail> existing = safeDetailMongoRepository.findByAccountUuid(actor.getLsUuid());
		if (existing.isEmpty()) {
			safeDetail = safeDetailMongoRepository.insert(safeDetailToPersist);
			SafeDetailAuditLogEntry safeDetailAuditLogEntry = new SafeDetailAuditLogEntry(authUser, actor,
					LogAction.CREATE, AuditLogEntryType.SAFE_DETAIL, safeDetailToPersist);
			logEntryService.insert(safeDetailAuditLogEntry);
		} else {
			throw new BusinessException(BusinessErrorCode.SAFE_DETAIL_ALREADY_EXIST,
					"the account with uuid: " + safeDetailToPersist.getAccountUuid() + " has already a safe detail");
		}
		return safeDetail;
	}

	@Override
	public SafeDetail delete(Account authUser, Account actor, String uuid) throws BusinessException {
		Validate.notNull(uuid);
		SafeDetail safeDetail = safeDetailMongoRepository.findByUuid(uuid);
		checkDeletePermission(authUser, actor, SafeDetail.class,
				BusinessErrorCode.SAFE_DETAIL_CAN_NOT_DELETE, safeDetail);
		safeDetailMongoRepository.delete(safeDetail);
		SafeDetailAuditLogEntry safeDetailAuditLogEntry = new SafeDetailAuditLogEntry(authUser, actor, LogAction.DELETE,
				AuditLogEntryType.SAFE_DETAIL, safeDetail);
		logEntryService.insert(safeDetailAuditLogEntry);
		return safeDetail;
	}

	@Override
	public SafeDetail delete(Account authUser, Account actor, SafeDetail safeDetail) throws BusinessException {
		checkDeletePermission(authUser, actor, SafeDetail.class,
				BusinessErrorCode.SAFE_DETAIL_CAN_NOT_DELETE, safeDetail);
		safeDetailMongoRepository.delete(safeDetail);
		SafeDetailAuditLogEntry safeDetailAuditLogEntry = new SafeDetailAuditLogEntry(authUser, actor, LogAction.DELETE,
				AuditLogEntryType.SAFE_DETAIL, safeDetail);
		logEntryService.insert(safeDetailAuditLogEntry);
		return safeDetail;
	}

	@Override
	public SafeDetail find(Account authUser, Account actor, String uuid) throws BusinessException {
		Validate.notNull(uuid);
		SafeDetail safeDetail = safeDetailMongoRepository.findByUuid(uuid);
		checkReadPermission(authUser, actor, SafeDetail.class,
				BusinessErrorCode.SAFE_DETAIL_CAN_NOT_READ, safeDetail);
		if (safeDetail == null) {
			throw new BusinessException(BusinessErrorCode.SAFE_DETAIL_NOT_FOUND,
					"the safeDetail with uuid: " + uuid + " does not exist");
		}
		return safeDetail;
	}

	@Override
	public List<SafeDetail> findAll(Account authUser, Account actor) throws BusinessException {
		checkListPermission(authUser, actor, SafeDetail.class,
				BusinessErrorCode.SAFE_DETAIL_CAN_NOT_LIST, null);
		return safeDetailMongoRepository.findByAccountUuid(actor.getLsUuid());
	}
}