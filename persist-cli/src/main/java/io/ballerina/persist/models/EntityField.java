/*
 * Copyright (c) 2022, WSO2 LLC. (http://www.wso2.org) All Rights Reserved.
 *
 * WSO2 Inc. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package io.ballerina.persist.models;

import io.ballerina.compiler.syntax.tree.AnnotationNode;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import static io.ballerina.persist.nodegenerator.syntax.constants.BalSyntaxConstants.COLON;
import static io.ballerina.persist.nodegenerator.syntax.constants.BalSyntaxConstants.SINGLE_QUOTE;
import static io.ballerina.persist.nodegenerator.syntax.utils.BalSyntaxUtils.stripEscapeCharacter;
import static io.ballerina.persist.utils.StubUtils.isLiteralName;

/**
 * Client Entity fieldMetaData class.
 *
 * @since 0.1.0
 *
 */
public class EntityField {
    private final String fieldName;
    private final String fieldColumnName;
    private final String fieldType;
    private final SqlType sqlType;
    private final boolean arrayType;
    private final boolean optionalType;
    private final boolean isDbGenerated;
    private final boolean optionalField;
    private Relation relation;
    private Enum enumValue;
    private final List<AnnotationNode> annotationNodes;
    private final List<String> relationRefs;

    EntityField(String fieldName, String fieldColumnName, String fieldType, boolean arrayType, boolean optionalType,
                boolean optionalField, List<AnnotationNode> annotationNodes, SqlType sqlType, List<String> relationRefs,
                boolean isDbGenerated) {
        this.fieldName = fieldName;
        this.fieldColumnName = fieldColumnName;
        this.fieldType = fieldType;
        this.arrayType = arrayType;
        this.optionalType = optionalType;
        this.optionalField = optionalField;
        this.annotationNodes =
                Collections.unmodifiableList(annotationNodes != null ? annotationNodes : new ArrayList<>());
        this.sqlType = sqlType;
        this.relationRefs = Collections.unmodifiableList(relationRefs != null ? relationRefs : new ArrayList<>());
        this.isDbGenerated = isDbGenerated;
    }

    public String getFieldName() {
        return fieldName;
    }

    public String getFieldColumnName() {
        return fieldColumnName;
    }

    public String getFieldType() {
        return fieldType;
    }

    public Relation getRelation() {
        return relation;
    }

    public SqlType getSqlType() {
        return sqlType;
    }

    public List<AnnotationNode> getAnnotation() {
        return annotationNodes;
    }

    public boolean isDbGenerated() {
        return isDbGenerated;
    }

    public boolean shouldColumnMappingGenerated() {
        if (fieldColumnName == null ||  fieldColumnName.isBlank()) {
            return false;
        }

        return !fieldColumnName.equals(stripEscapeCharacter(fieldName));
    }

    public List<String> getRelationRefs() {
        return relationRefs;
    }

    public void setRelation(Relation relation) {
        this.relation = relation;
    }

    public void setEnum(Enum enumValue) {
        this.enumValue = enumValue;
    }

    public Enum getEnum() {
        return enumValue;
    }

    public boolean isArrayType() {
        return arrayType;
    }

    public boolean isOptionalType() {
        return optionalType;
    }

    public boolean isOptionalField() {
        return optionalField;
    }

    public static EntityField.Builder newBuilder(String fieldName) {
        return new EntityField.Builder(fieldName);
    }

    /**
     * Entity Field Definition.Builder.
     */
    public static class Builder {
        String fieldName;
        String fieldColumnName;
        String fieldType;

        private boolean arrayType = false;
        private boolean optionalType = false;
        boolean optionalField = false;

        SqlType sqlType;
        private List<AnnotationNode> annotationNodes = null;

        private List<String> relationRefs;

        private boolean isDbGenerated = false;

        Builder(String fieldName) {
            if (isLiteralName(fieldName)) {
                this.fieldName = SINGLE_QUOTE + fieldName;
                return;
            }
            this.fieldName = fieldName;
        }

        public void setType(String fieldType) {
            if (fieldType.contains(COLON) && !fieldType.startsWith("time:")) {
                fieldType = fieldType.split(COLON, 2)[1];
            }
            this.fieldType = fieldType;
        }

        public void setSqlType(SqlType sqlType) {
            this.sqlType = sqlType;
        }
        public void setFieldColumnName(String fieldColumnName) {
            this.fieldColumnName = fieldColumnName;
        }

        public void setRelationRefs(List<String> relationRefs) {
            this.relationRefs = relationRefs;
        }

        public void setIsDbGenerated(boolean isDbGenerated) {
            this.isDbGenerated = isDbGenerated;
        }


        public void setArrayType(boolean arrayType) {
            this.arrayType = arrayType;
        }

        public void setOptionalType(boolean optionalType) {
            this.optionalType = optionalType;
        }
        public void setOptionalField(boolean optionalField) {
            this.optionalField = optionalField;
        }
        public void setAnnotations(List<AnnotationNode> annotationNodes) {
            this.annotationNodes = annotationNodes;
        }

        public EntityField build() {
            return new EntityField(fieldName, fieldColumnName, fieldType, arrayType, optionalType, optionalField, 
            annotationNodes, sqlType, relationRefs, isDbGenerated);
        }

        public String getFieldName() {
            return fieldName;
        }
    }
}
