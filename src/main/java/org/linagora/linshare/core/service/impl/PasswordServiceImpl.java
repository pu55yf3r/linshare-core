/*
 * LinShare is an open source filesharing software, part of the LinPKI software
 * suite, developed by Linagora.
 * 
 * Copyright (C) 2015-2020 LINAGORA
 * 
 * This program is free software: you can redistribute it and/or modify it under
 * the terms of the GNU Affero General Public License as published by the Free
 * Software Foundation, either version 3 of the License, or (at your option) any
 * later version, provided you comply with the Additional Terms applicable for
 * LinShare software by Linagora pursuant to Section 7 of the GNU Affero General
 * Public License, subsections (b), (c), and (e), pursuant to which you must
 * notably (i) retain the display of the “LinShare™” trademark/logo at the top
 * of the interface window, the display of the “You are using the Open Source
 * and free version of LinShare™, powered by Linagora © 2009–2020. Contribute to
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

import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Arrays;

import org.linagora.linshare.core.exception.BusinessErrorCode;
import org.linagora.linshare.core.exception.BusinessException;
import org.linagora.linshare.core.exception.TechnicalException;
import org.linagora.linshare.core.service.PasswordService;
import org.passay.CharacterRule;
import org.passay.EnglishCharacterData;
import org.passay.LengthRule;
import org.passay.PasswordData;
import org.passay.PasswordValidator;
import org.passay.RuleResult;
import org.passay.WhitespaceRule;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.password.PasswordEncoder;

public class PasswordServiceImpl implements PasswordService {

	final private static Logger logger = LoggerFactory.getLogger(PasswordServiceImpl.class);

	private final PasswordEncoder passwordEncoder;

	protected Integer numberUpperCaseCharacters;
	
	protected Integer numberLowerCaseCharacters;

	protected Integer numberDicgitsCharacters;

	protected Integer numberSpecialCharacters;

	protected Integer passwordMinLength;

	protected Integer passwordMaxLength;

	public PasswordServiceImpl(PasswordEncoder passwordEncoder,
			Integer numberUpperCaseCharacters,
			Integer numberLowerCaseCharacters,
			Integer numberDicgitsCharacters,
			Integer numberSpecialCharacters,
			Integer passwordMinLength,
			Integer passwordMaxLength) {
		super();
		this.passwordEncoder = passwordEncoder;
		this.numberUpperCaseCharacters = numberUpperCaseCharacters;
		this.numberLowerCaseCharacters = numberLowerCaseCharacters;
		this.numberDicgitsCharacters = numberDicgitsCharacters;
		this.numberSpecialCharacters = numberSpecialCharacters;
		this.passwordMinLength = passwordMinLength;
		this.passwordMaxLength = passwordMaxLength;
	}

	@Override
	public String encode(CharSequence rawPassword) {
		return passwordEncoder.encode(rawPassword);
	}

	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
		return passwordEncoder.matches(rawPassword, encodedPassword);
	}

	@Override
	public String generatePassword() {
		SecureRandom sr = null;
		try {
			sr = SecureRandom.getInstance("SHA1PRNG");
		} catch (NoSuchAlgorithmException e) {
			logger.error("Algorithm \"SHA1PRNG\" not supported");
			throw new TechnicalException("Algorithm \"SHA1PRNG\" not supported");
		}
		return Long.toString(sr.nextLong() & Long.MAX_VALUE, 36);
	}

	@Override
	public void validatePassword(String password) {
		PasswordValidator validator = new PasswordValidator(Arrays.asList(
				new LengthRule(passwordMinLength, passwordMaxLength),
				new CharacterRule(EnglishCharacterData.UpperCase, numberUpperCaseCharacters),
				new CharacterRule(EnglishCharacterData.LowerCase, numberLowerCaseCharacters),
				new CharacterRule(EnglishCharacterData.Digit, numberDicgitsCharacters),
				new CharacterRule(EnglishCharacterData.Special, numberSpecialCharacters),
				new WhitespaceRule()));
		RuleResult result = validator.validate(new PasswordData(password));
		if (!result.isValid()) {
			throw new BusinessException(BusinessErrorCode.RESET_ACCOUNT_PASSWORD_INVALID_PASSWORD,
					validator.getMessages(result).toString());
		}
	}
}
