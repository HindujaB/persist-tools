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


public type User record {|
    readonly int id;
    string name;
    string nic;
    decimal? salary;
    Car? drives;
|};

public type Car record {|
    readonly int id;
    string name;
    string model;
    @sql:UniqueIndex
    int driverId;
    @sql:Relation {keys: ["driverId"]}
    User driver;
|};

public type User2 record {|
    readonly int id;
    readonly string nic;
    string name;
    decimal? salary;
    Car2? drives;
|};

public type Car2 record {|
    readonly int id;
    string name;
    string model;
    @sql:UniqueIndex {name: "driver_idx"}
    int driverId;
    @sql:UniqueIndex {name: "driver_idx"}
    string driverNic;
    @sql:Relation {keys: ["driverId", "driverNic"]}
    User2 driver;
|};
