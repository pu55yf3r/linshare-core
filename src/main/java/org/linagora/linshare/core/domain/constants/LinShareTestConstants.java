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
package org.linagora.linshare.core.domain.constants;

public class LinShareTestConstants {
	
	/**
	 * Default sentence to marked the begin of a test
	 */
	public static final String BEGIN_TEST = "running test ...";
	
	
	/**
	 * Default sentence to marked the begin of a test
	 */
	public static final String END_TEST = "end";
	
	/**
	 * Default sentence to marked the begin of a tearDown
	 */
	public static final String BEGIN_TEARDOWN = "Begin tearDown";
	
	/**
	 * Default sentence to marked the end of a tearDown
	 */
	public static final String END_TEARDOWN = "End tearDown";
	
	
	/**
	 * Default sentence to marked the begin of a setUp
	 */
	public static final String BEGIN_SETUP = "Begin setUp";
	
	/**
	 * Default sentence to marked the end of a setUp
	 */
	public static final String END_SETUP = "End setUp";

	/**
	 *  Root domain
	 */
	public static final String ROOT_DOMAIN = "LinShareRootDomain";

	/**
	 * Top domain
	 */
	public static final String TOP_DOMAIN = "MyDomain";

	/**
	 * Sub_domain
	 */
	public static final String SUB_DOMAIN = "MySubDomain";

	/**
	 * Guest domain
	 */
	public static final String GUEST_DOMAIN = "GuestDomain";

	/**
	 * Root account, on root domain
	 */
	public static final String ROOT_ACCOUNT = "root@localhost.localdomain";

	/**
	 * John Do account, on Top domain
	 */
	public static final String JOHN_ACCOUNT = "user1@linshare.org";

	/**
	 * Jane Simth account, on Top domain
	 */
	public static final String JANE_ACCOUNT = "user2@linshare.org";

	/**
	 * Foo Bar account, on Top domain
	 */
	public static final String FOO_ACCOUNT = "user3@linshare.org";

	/**
	 * Guest account, on guest domain
	 */
	public static final String GUEST_ACCOUNT = "guest@linshare.org";

}
