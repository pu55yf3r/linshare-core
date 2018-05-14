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
package org.linagora.linshare.webservice.delegationv2.impl;

import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import org.linagora.linshare.core.exception.BusinessException;
import org.linagora.linshare.core.facade.webservice.user.SharedSpacePermissionFacade;
import org.linagora.linshare.mongo.entities.SharedSpacePermission;
import org.linagora.linshare.webservice.delegationv2.SharedSpacePermissionRestService;
import com.wordnik.swagger.annotations.Api;
import com.wordnik.swagger.annotations.ApiOperation;
import com.wordnik.swagger.annotations.ApiParam;
import com.wordnik.swagger.annotations.ApiResponse;
import com.wordnik.swagger.annotations.ApiResponses;

@Path("/{actorUuid}/shared_space_permissions")
@Api(value = "/rest/delegation/v2/{actorUuid}/shared_space_permissions", description = "requests API")
@Produces({ MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON })
@Consumes({ MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON })
public class SharedSpacePermissionRestServiceImpl implements SharedSpacePermissionRestService {
	private final SharedSpacePermissionFacade sharedSpacePermissionFacade;

	public SharedSpacePermissionRestServiceImpl(SharedSpacePermissionFacade sharedSpacePermissionFacade) {
		super();
		this.sharedSpacePermissionFacade = sharedSpacePermissionFacade;
	}

	@Path("/{uuid}")
	@GET
	@ApiOperation(value = "Find a shared space permission.", response = SharedSpacePermission.class)
	@ApiResponses({ @ApiResponse(code = 403, message = "Current logged in account does not have the delegation role."),
			@ApiResponse(code = 404, message = "Not found."),
			@ApiResponse(code = 400, message = "Bad request : missing required fields."),
			@ApiResponse(code = 500, message = "Internal server error."), })
	@Override
	public SharedSpacePermission find(
			@ApiParam(value="The actor uuid.",required=true)
				@PathParam("actoruuid")String actorUuid,
			@ApiParam(value="The permission uuid.")
				@PathParam("uuid")String uuid)
						throws BusinessException {
		return sharedSpacePermissionFacade.find(actorUuid, uuid);
	}
	
	@Path("/role/{roleName}")
	@GET
	@ApiOperation(value = "Find a shared space permission with a related role name.", response = SharedSpacePermission.class)
	@ApiResponses({ @ApiResponse(code = 403, message = "Current logged in account does not have the delegation role."),
			@ApiResponse(code = 404, message = "Not found."),
			@ApiResponse(code = 400, message = "Bad request : missing required fields."),
			@ApiResponse(code = 500, message = "Internal server error."), })
	@Override
	public List<SharedSpacePermission> findByRole(
			@ApiParam(value="The actor uuid.",required=true)
				@PathParam("actoruuid")String actorUuid,
			@ApiParam(value="The permission role name.")
				@PathParam("roleName")String roleName) 
						throws BusinessException {
		return sharedSpacePermissionFacade.findByRole(actorUuid, roleName);
	}

	@Path("/")
	@GET
	@ApiOperation(value = "Find all shared space permission.", response = SharedSpacePermission.class)
	@ApiResponses({ @ApiResponse(code = 403, message = "Current logged in account does not have the delegation role."),
			@ApiResponse(code = 404, message = "Not found."),
			@ApiResponse(code = 400, message = "Bad request : missing required fields."),
			@ApiResponse(code = 500, message = "Internal server error."), })
	@Override
	public List<SharedSpacePermission> findAll(
			@ApiParam(value="the actor uuid")
				@PathParam("actorUuid")String actorUuid) 
						throws BusinessException {
		return sharedSpacePermissionFacade.findAll(actorUuid);
	}

}