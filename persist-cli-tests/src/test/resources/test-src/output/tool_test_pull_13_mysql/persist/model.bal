import ballerina/persist as _;
import ballerinax/persist.sql;

public enum UserGender {
    MALE = "MALE",
    FEMALE = "FEMALE"
}

public type User record {|
    readonly int id;
    string name;
    UserGender gender;
    string nic;
    decimal salary;
    @sql:Index {names: ["favorite"]}
    string favColor;
    @sql:Index {names: ["favorite"]}
    string favCar;
|};
