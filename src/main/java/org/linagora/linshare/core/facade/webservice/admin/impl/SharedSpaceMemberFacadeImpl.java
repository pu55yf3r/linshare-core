/*
 * LinShare is an open source filesharing software, part of the LinPKI software
 * suite, developed by Linagora.
 * 
 * Copyright (C) 2018 LINAGORA
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
package org.linagora.linshare.core.facade.webservice.admin.impl;

import org.apache.commons.lang.Validate;
import org.linagora.linshare.core.domain.constants.Role;
import org.linagora.linshare.core.domain.entities.Account;
import org.linagora.linshare.core.exception.BusinessException;
import org.linagora.linshare.core.facade.webservice.admin.SharedSpaceMemberFacade;
import org.linagora.linshare.core.service.AccountService;
import org.linagora.linshare.core.service.SharedSpaceMemberService;
import org.linagora.linshare.mongo.entities.SharedSpaceMember;

public class SharedSpaceMemberFacadeImpl extends AdminGenericFacadeImpl implements SharedSpaceMemberFacade {

	private final SharedSpaceMemberService sharedSpaceMemberService;

	public SharedSpaceMemberFacadeImpl(SharedSpaceMemberService sharedSpaceMemberService,
			AccountService accountService) {
		super(accountService);
		this.sharedSpaceMemberService = sharedSpaceMemberService;
	}

	@Override
	public SharedSpaceMember create(SharedSpaceMember member) throws BusinessException {
		Validate.notNull(member, "Shared space member must be set.");
		Account authUser = checkAuthentication(Role.SUPERADMIN);
		SharedSpaceMember toAddMember = sharedSpaceMemberService.create(authUser, authUser,
				member.getAccount().getUuid(), member.getRole().getUuid(), member.getNode().getUuid());
		return toAddMember;
	}

	@Override
	public SharedSpaceMember find(String uuid) throws BusinessException {
		Validate.notEmpty(uuid, "Member must be set.");
		Account authUser = checkAuthentication(Role.SUPERADMIN);
		return sharedSpaceMemberService.find(authUser, authUser, uuid);
	}

}
