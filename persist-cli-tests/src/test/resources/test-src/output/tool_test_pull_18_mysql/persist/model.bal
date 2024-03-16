import ballerina/persist as _;
import ballerinax/persist.sql;

public type Employee record {|
    readonly int id;
    string? name;
    string? email;
    int? age;
    @sql:Decimal {precision: [10, 2]}
    decimal? salary;
    @sql:Mapping {name: "managed_by"}
    @sql:Index {names: ["managed_by"]}
    int? managedBy;
    Employee[] employees;
    @sql:Relation {refs: ["managedBy"]}
    Employee employee;
|};
