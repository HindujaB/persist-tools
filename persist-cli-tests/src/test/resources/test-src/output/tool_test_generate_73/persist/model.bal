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
import ballerinax/persist.sql;

public enum UserGender {
    MALE,
    FEMALE
}

public type User record {|
    readonly int id;
    string name;
    UserGender gender;
    string nic;
    decimal? salary;
    Car[] cars;
|};

@sql:Name {value: "cars"}
public type Car record {|
    readonly int id;
    string name;
    @sql:Name {value: "MODEL"}
    string model;
    @sql:Index {name: "ownerId"}
    int ownerId;
    @sql:Relation {keys: ["ownerId"]}
    User owner;
|};

# Description.
#
# + name - field description  
# + age - field description  
# + nic - field description  
# + salary - field description
public type Person record {|
    readonly string name;
    int age;
    string nic;
    decimal salary;
|};

# Description.
#
# + name - field description  
# + age - field description  
# + nic - field description  
# + salary - field description
@sql:Name {value: "people2"}
public type Person2 record {|
    readonly string name;
    int age;
    string nic;
    decimal salary;
|};
