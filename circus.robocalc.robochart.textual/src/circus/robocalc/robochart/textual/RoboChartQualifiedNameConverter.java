/********************************************************************************
 * Copyright (c) 2019 University of York and others
 *
 * This program and the accompanying materials are made available under the
 * terms of the Eclipse Public License 2.0 which is available at
 * http://www.eclipse.org/legal/epl-2.0.
 *
 * SPDX-License-Identifier: EPL-2.0
 *
 * Contributors:
 *   Alvaro Miyazawa - initial definition
 ********************************************************************************/

package circus.robocalc.robochart.textual;

import org.eclipse.xtext.naming.IQualifiedNameConverter;

public class RoboChartQualifiedNameConverter extends IQualifiedNameConverter.DefaultImpl {
	@Override
	public String getDelimiter() {
		return "::";
	}
}