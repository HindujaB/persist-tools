/*
 *  Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 *  WSO2 Inc. licenses this file to you under the Apache License,
 *  Version 2.0 (the "License"); you may not use this file except
 *  in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing,
 *  software distributed under the License is distributed on an
 *  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 *  KIND, either express or implied.  See the License for the
 *  specific language governing permissions and limitations
 *  under the License.
 */
package io.ballerina.persist.objects;
/**
 * Client Entity fieldMetaData class.
 *
 * @since 0.1.0
 */

public class FieldMetaData {
    private final String fieldName;
    private final String fieldType;
    private final boolean autoGenerated;

    public FieldMetaData(String fieldName, String fieldType, boolean autoGenerated) {
        this.fieldName = fieldName;
        this.fieldType = fieldType;
        this.autoGenerated = autoGenerated;
    }

    public String getFieldName() {
        return fieldName;
    }

    public String getFieldType() {
        return fieldType;
    }

    public boolean isAutoGenerated() {
        return autoGenerated;
    }
}
