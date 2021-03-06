/*
 * LinShare is an open source filesharing software developed by LINAGORA.
 * 
 * Copyright (C) 2015-2020 LINAGORA
 * 
 * This program is free software: you can redistribute it and/or modify it under
 * the terms of the GNU Affero General Public License as published by the Free
 * Software Foundation, either version 3 of the License, or (at your option) any
 * later version, provided you comply with the Additional Terms applicable for
 * LinShare software by Linagora pursuant to Section 7 of the GNU Affero General
 * Public License, subsections (b), (c), and (e), pursuant to which you must
 * notably (i) retain the display in the interface of the “LinShare™”
 * trademark/logo, the "Libre & Free" mention, the words “You are using the Free
 * and Open Source version of LinShare™, powered by Linagora © 2009–2020.
 * Contribute to Linshare R&D by subscribing to an Enterprise offer!”. You must
 * also retain the latter notice in all asynchronous messages such as e-mails
 * sent with the Program, (ii) retain all hypertext links between LinShare and
 * http://www.linshare.org, between linagora.com and Linagora, and (iii) refrain
 * from infringing Linagora intellectual property rights over its trademarks and
 * commercial brands. Other Additional Terms apply, see
 * <http://www.linshare.org/licenses/LinShare-License_AfferoGPL-v3.pdf> for more
 * details.
 * 
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
 * details.
 * 
 * You should have received a copy of the GNU Affero General Public License and
 * its applicable Additional Terms for LinShare along with this program. If not,
 * see <http://www.gnu.org/licenses/> for the GNU Affero General Public License
 * version 3 and
 * <http://www.linshare.org/licenses/LinShare-License_AfferoGPL-v3.pdf> for the
 * Additional Terms applicable to LinShare software.
 */

package org.linagora.linshare.webservice.userv1.task.context;

import java.io.File;

import org.linagora.linshare.core.facade.webservice.common.dto.AccountDto;

public class DocumentTaskContext extends TaskContext {

	protected File file;

	protected final String fileName;

	protected final String metaData;

	protected final String description;

	/**
	 * uuid of the updated document entry.
	 */
	protected String docEntryUuid;

	public DocumentTaskContext(AccountDto authUserDto, String actorUuid,
			File file, String fileName, String metaData, String description) {
		super(authUserDto, actorUuid);
		this.file = file;
		this.fileName = fileName;
		this.metaData = metaData;
		this.description = description;
	}

	public DocumentTaskContext(AccountDto authUserDto, String actorUuid,
			File file, String fileName) {
		super(authUserDto, actorUuid);
		this.file = file;
		this.fileName = fileName;
		this.metaData = null;
		this.description = null;
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

	public String getMetaData() {
		return metaData;
	}

	public String getDescription() {
		return description;
	}

	public String getDocEntryUuid() {
		return docEntryUuid;
	}

	public void setDocEntryUuid(String docEntryUuid) {
		this.docEntryUuid = docEntryUuid;
	}

	@Override
	public String toString() {
		return "DocumentTaskContext [fileName=" + fileName + ", docEntryUuid="
				+ docEntryUuid + ", actorUuid=" + actorUuid + "]";
	}

}
