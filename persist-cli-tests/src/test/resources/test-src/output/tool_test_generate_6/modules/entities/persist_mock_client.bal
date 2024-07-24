// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.

import ballerina/jballerina.java;
import ballerina/persist;
import ballerina/sql;
import ballerinax/h2.driver as _;
import ballerinax/java.jdbc;
import ballerinax/persist.sql as psql;

const DATA_TYPE = "datatypes";

public isolated client class MockClient {
    *persist:AbstractPersistClient;

    private final jdbc:Client dbClient;

    private final map<psql:SQLClient> persistClients;

    private final record {|psql:SQLMetadata...;|} & readonly metadata = {
        [DATA_TYPE]: {
            entityName: "DataType",
            tableName: "DataType",
            fieldMetadata: {
                a: {columnName: "a"},
                b1: {columnName: "b1"},
                c1: {columnName: "c1"},
                d1: {columnName: "d1"},
                bA: {columnName: "bA"},
                e1: {columnName: "e1"},
                f1: {columnName: "f1"},
                j1: {columnName: "j1"},
                k1: {columnName: "k1"},
                l1: {columnName: "l1"},
                m1: {columnName: "m1"}
            },
            keyFields: ["a"]
        }
    };

    public isolated function init(string url, string? user = (), string? password = (), jdbc:Options? connectionOptions = ()) returns persist:Error? {
        jdbc:Client|error dbClient = new (url = url, user = user, password = password, options = connectionOptions);
        if dbClient is error {
            return <persist:Error>error(dbClient.message());
        }
        self.dbClient = dbClient;
        self.persistClients = {[DATA_TYPE]: check new (dbClient, self.metadata.get(DATA_TYPE), psql:H2_SPECIFICS)};
    }

    isolated resource function get datatypes(DataTypeTargetType targetType = <>, sql:ParameterizedQuery whereClause = ``, sql:ParameterizedQuery orderByClause = ``, sql:ParameterizedQuery limitClause = ``, sql:ParameterizedQuery groupByClause = ``) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.H2Processor",
        name: "query"
    } external;

    isolated resource function get datatypes/[int a](DataTypeTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.H2Processor",
        name: "queryOne"
    } external;

    isolated resource function post datatypes(DataTypeInsert[] data) returns int[]|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(DATA_TYPE);
        }
        _ = check sqlClient.runBatchInsertQuery(data);
        return from DataTypeInsert inserted in data
            select inserted.a;
    }

    isolated resource function put datatypes/[int a](DataTypeUpdate value) returns DataType|persist:Error {
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(DATA_TYPE);
        }
        _ = check sqlClient.runUpdateQuery(a, value);
        return self->/datatypes/[a].get();
    }

    isolated resource function delete datatypes/[int a]() returns DataType|persist:Error {
        DataType result = check self->/datatypes/[a].get();
        psql:SQLClient sqlClient;
        lock {
            sqlClient = self.persistClients.get(DATA_TYPE);
        }
        _ = check sqlClient.runDeleteQuery(a);
        return result;
    }

    remote isolated function queryNativeSQL(sql:ParameterizedQuery sqlQuery, typedesc<record {}> rowType = <>) returns stream<rowType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.H2Processor"
    } external;

    remote isolated function executeNativeSQL(sql:ParameterizedQuery sqlQuery) returns psql:ExecutionResult|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.sql.datastore.H2Processor"
    } external;

    public isolated function close() returns persist:Error? {
        error? result = self.dbClient.close();
        if result is error {
            return <persist:Error>error(result.message());
        }
        return result;
    }
}

