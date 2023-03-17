// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.

import ballerina/persist;
import ballerina/jballerina.java;
import ballerinax/mysql;

const BYTE_TEST = "bytetests";

public client class Client {
    *persist:AbstractPersistClient;

    private final mysql:Client dbClient;

    private final map<persist:SQLClient> persistClients;

    private final record {|persist:Metadata...;|} metadata = {
        "bytetests": {
            entityName: "ByteTest",
            tableName: `ByteTest`,
            fieldMetadata: {
                id: {columnName: "id"},
                binary1: {columnName: "binary1"},
                binaryOptional: {columnName: "binaryOptional"}
            },
            keyFields: ["id"]
        }
    };

    public function init() returns persist:Error? {
        mysql:Client|error dbClient = new (host = host, user = user, password = password, database = database, port = port);
        if dbClient is error {
            return <persist:Error>error(dbClient.message());
        }
        self.dbClient = dbClient;
        self.persistClients = {bytetests: check new (self.dbClient, self.metadata.get(BYTE_TEST))};
    }

    isolated resource function get bytetests(ByteTestTargetType targetType = <>) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.QueryProcessor",
        name: "query"
    } external;

    isolated resource function get bytetests/[int id](ByteTestTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.QueryProcessor",
        name: "queryOne"
    } external;

    isolated resource function post bytetests(ByteTestInsert[] data) returns int[]|persist:Error {
        _ = check self.persistClients.get(BYTE_TEST).runBatchInsertQuery(data);
        return from ByteTestInsert inserted in data
            select inserted.id;
    }

    isolated resource function put bytetests/[int id](ByteTestUpdate value) returns ByteTest|persist:Error {
        _ = check self.persistClients.get(BYTE_TEST).runUpdateQuery(id, value);
        return self->/bytetests/[id].get();
    }

    isolated resource function delete bytetests/[int id]() returns ByteTest|persist:Error {
        ByteTest result = check self->/bytetests/[id].get();
        _ = check self.persistClients.get(BYTE_TEST).runDeleteQuery(id);
        return result;
    }

    public function close() returns persist:Error? {
        error? result = self.dbClient.close();
        if result is error {
            return <persist:Error>error(result.message());
        }
        return result;
    }
}
