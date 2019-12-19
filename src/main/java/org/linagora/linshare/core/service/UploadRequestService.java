/*
 * LinShare is an open source filesharing software, part of the LinPKI software
 * suite, developed by Linagora.
 * 
 * Copyright (C) 2015-2018 LINAGORA
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
package org.linagora.linshare.core.service;

import java.util.Date;
import java.util.List;
import java.util.Set;

import org.linagora.linshare.core.domain.constants.UploadRequestStatus;
import org.linagora.linshare.core.domain.entities.Account;
import org.linagora.linshare.core.domain.entities.UploadRequest;
import org.linagora.linshare.core.domain.entities.UploadRequestEntry;
import org.linagora.linshare.core.domain.entities.UploadRequestGroup;
import org.linagora.linshare.core.domain.entities.UploadRequestTemplate;
import org.linagora.linshare.core.domain.entities.UploadRequestUrl;
import org.linagora.linshare.core.domain.objects.UploadRequestContainer;
import org.linagora.linshare.core.exception.BusinessException;

public interface UploadRequestService {

	List<UploadRequest> findAll(Account actor, Account owner, UploadRequestGroup uploadRequestGroup, List<UploadRequestStatus> statusList);

	UploadRequest find(Account actor, Account owner, String uuid) throws BusinessException;

	UploadRequest updateRequest(Account actor, Account owner, UploadRequest req) throws BusinessException;

	UploadRequest updateStatus(Account actor, Account owner, String uuid, UploadRequestStatus status, boolean copy)
			throws BusinessException;

	UploadRequest update(Account actor, Account owner, String uuid, UploadRequest object) throws BusinessException;;

	UploadRequest closeRequestByRecipient(UploadRequestUrl url) throws BusinessException;

	UploadRequest deleteRequest(Account actor, Account owner, String uuid) throws BusinessException;

	UploadRequestTemplate findTemplateByUuid(Account actor, Account owner, String uuid) throws BusinessException;

	UploadRequestTemplate createTemplate(Account actor, Account owner, UploadRequestTemplate template)
			throws BusinessException;

	UploadRequestTemplate updateTemplate(Account actor, Account owner, String uuid, UploadRequestTemplate template)
			throws BusinessException;

	UploadRequestTemplate deleteTemplate(Account actor, Account owner, String uuid) throws BusinessException;

	Set<UploadRequest> findAll(Account actor, List<UploadRequestStatus> status, Date afterDate, Date beforeDate)
			throws BusinessException;

	List<String> findOutdatedRequests(Account actor);

	List<String> findUnabledRequests(Account actor);

	List<String> findAllRequestsToBeNotified(Account actor);

	UploadRequestContainer create(Account authUser, Account owner, UploadRequest uploadRequest,
			UploadRequestContainer container);

	List<UploadRequestEntry> findAllEntries(Account actor, Account owner, String uploadRequestUuid) throws BusinessException;

	List<UploadRequestEntry> findAllExtEntries(UploadRequestUrl requestUrl);
}
