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

package org.linagora.linshare.auth;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.linagora.linshare.auth.exceptions.LinShareAuthenticationException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.www.BasicAuthenticationEntryPoint;

public class LinShareBasicAuthenticationEntryPoint extends BasicAuthenticationEntryPoint {

	@Override
	public void commence(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException authException) throws IOException, ServletException {
		String authenticationHeader = request.getHeader("WWW-No-Authenticate");
		int errorCode = 1000;
		if (authException instanceof LinShareAuthenticationException) {
			errorCode = ((LinShareAuthenticationException) authException).getErrorCode();
		} else if (authException instanceof BadCredentialsException) {
			errorCode = 1001;
		}
		if (authenticationHeader == null) {
			/**
			 *  1002 and 1003 error codes are related to the 2FA.
			 *  It means login/password authentication succeeded but TOTP was invalid or not provided.
			 *  So we inform the client of the supported authentication process.
			 */
			if (errorCode == 1002 || errorCode == 1003) {
				response.addHeader("WWW-Authenticate-", "Basic+TOTP realm=\"" + this.getRealmName() + "\"");
			} else {
				response.addHeader("WWW-Authenticate", "Basic realm=\"" + this.getRealmName() + "\"");
			}
		}
		response.addIntHeader("X-LinShare-Auth-error-code", errorCode);
		response.addHeader("X-LinShare-Auth-error-msg", authException.getMessage());
		response.sendError(HttpServletResponse.SC_UNAUTHORIZED, authException.getMessage());
	}
}
