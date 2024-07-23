// Copyright (c) 2024 WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/persist as _;
import ballerina/time;

public enum Gender {
    MALE,
    FEMALE
}

public enum WorkspaceType {
    CUBICLE = "C",
    OFFICE,
    MEETING_ROOM = "MR"
}

type Employee record {|
    readonly string empNo;
    string firstName;
    string lastName;
    time:Date hireDate;
    Gender gender;
    time:Civil dateOfBirth;

    Department department;
    Workspace? workspace;
|};

type Workspace record {|
    readonly string workspaceId;
    WorkspaceType workspaceType;

    Building location;
    Employee employee;
|};

public enum State {
    NY,
    CA,
    WY
}

type Building record {|
    readonly string buildingCode;
    string city;
    State state;
    string country;
    string postalCode;

    Workspace[] workspaces;
|};

type Department record {|
    readonly string deptNo;
    string deptName;

    Employee[] employees;
|};
