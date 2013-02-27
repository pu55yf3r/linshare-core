/*
 * LinShare is an open source filesharing software, part of the LinPKI software
 * suite, developed by Linagora.
 * 
 * Copyright (C) 2013 LINAGORA
 * 
 * This program is free software: you can redistribute it and/or modify it under
 * the terms of the GNU Affero General Public License as published by the Free
 * Software Foundation, either version 3 of the License, or (at your option) any
 * later version, provided you comply with the Additional Terms applicable for
 * LinShare software by Linagora pursuant to Section 7 of the GNU Affero General
 * Public License, subsections (b), (c), and (e), pursuant to which you must
 * notably (i) retain the display of the “LinShare™” trademark/logo at the top
 * of the interface window, the display of the “You are using the Open Source
 * and free version of LinShare™, powered by Linagora © 2009–2013. Contribute to
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
package org.linagora.linshare.core.domain.entities;

import org.linagora.linshare.core.domain.constants.FunctionalityType;
import org.linagora.linshare.core.domain.vo.FunctionalityVo;
import org.linagora.linshare.core.domain.vo.TimeValueBooleanFunctionalityVo;

public class UnitBooleanValueFunctionality extends UnitValueFunctionality {

	protected boolean bool;
	
	public UnitBooleanValueFunctionality() {
		super();
	}

	public boolean isBool() {
		return bool;
	}

	public void setBool(boolean bool) {
		this.bool = bool;
	}

	@Override
	public FunctionalityType getType() {
		return FunctionalityType.UNIT_BOOLEAN;
	}
	
	@Override
	public boolean businessEquals(Functionality obj, boolean checkPolicies) {
		if(super.businessEquals(obj, checkPolicies)) {
			UnitBooleanValueFunctionality o = (UnitBooleanValueFunctionality)obj;
			if(bool == o.isBool()) {
				logger.debug("UnitBooleanValueFunctionality : " + this.toString() + " is equal to UnitBooleanValueFunctionality " + obj.toString());
				return true;
			}
		}
		logger.debug("UnitBooleanValueFunctionality : " + this.toString() + " is not equal to UnitBooleanValueFunctionality " + obj.toString());
		return false;
	}
	
	public Object clone() {
		UnitBooleanValueFunctionality func = null;
      	func = (UnitBooleanValueFunctionality) super.clone();
	    return func;
  	}
	
	@Override
	public void updateFunctionalityValuesOnlyFrom(Functionality functionality) {
		super.updateFunctionalityValuesOnlyFrom(functionality);
		UnitBooleanValueFunctionality f = (UnitBooleanValueFunctionality)functionality;
		this.bool = f.isBool();
	}
	
	@Override
	public void updateFunctionalityValuesOnlyFromVo(FunctionalityVo functionality) {
		
		if(functionality.getType().equals(FunctionalityType.UNIT_BOOLEAN_TIME)) {
			TimeValueBooleanFunctionalityVo f = (TimeValueBooleanFunctionalityVo)functionality;
			if(f.getTime() != null) {
				this.value = f.getTime();
				this.bool = f.isBool();
				TimeUnitClass timeUnit = (TimeUnitClass)getUnit();
				timeUnit.setUnitValue(f.getUnit());
			}
		} 
	}
}
