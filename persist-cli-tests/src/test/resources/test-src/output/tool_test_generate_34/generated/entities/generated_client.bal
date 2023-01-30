// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for entities.
// It should not be modified by hand.

import ballerina/persist;
import ballerina/sql;
import ballerinax/mysql;

const PROFILE = "profile";
const USER = "user";

public client class EntitiesClient {
    *persist:AbstractPersistClient;

    private final mysql:Client dbClient;

    private final map<persist:SQLClient> persistClients;

    private final record {|persist:Metadata...;|} metadata = {
        "profile": {
            entityName: "Profile",
            tableName: `Profile`,
            fieldMetadata: {
                id: {columnName: "id", 'type: int},
                name: {columnName: "name", 'type: string},
                gender: {columnName: "gender", 'type: string},
                userId: {columnName: "userId", 'type: int}
            },
            keyFields: ["id"]
        },
        "user": {
            entityName: "User",
            tableName: `User`,
            fieldMetadata: {id: {columnName: "id", 'type: int}},
            keyFields: ["id"]
        }
    };

    public function init() returns persist:Error? {
        mysql:Client|error dbClient = new (host = host, user = user, password = password, database = database, port = port);
        if dbClient is error {
            return <persist:Error>error(dbClient.message());
        }
        self.dbClient = dbClient;
        self.persistClients = {
            profile: check new (self.dbClient, self.metadata.get(PROFILE)),
            user: check new (self.dbClient, self.metadata.get(USER))
        };
    }

    isolated resource function get profile() returns stream<Profile, persist:Error?> {
        stream<record {}, sql:Error?>|persist:Error result = self.persistClients.get(PROFILE).runReadQuery(Profile);
        if result is persist:Error {
            return new stream<Profile, persist:Error?>(new ProfileStream((), result));
        } else {
            return new stream<Profile, persist:Error?>(new ProfileStream(result));
        }
    }

    isolated resource function get profile/[int id]() returns Profile|persist:Error {
        Profile|error result = (check self.persistClients.get(PROFILE).runReadByKeyQuery(Profile, id)).cloneWithType(Profile);
        if result is error {
            return <persist:Error>error(result.message());
        }
        return result;
    }

    isolated resource function post profile(ProfileInsert[] data) returns int[]|persist:Error {
        _ = check self.persistClients.get(PROFILE).runBatchInsertQuery(data);
        return from ProfileInsert inserted in data
            select inserted.id;
    }

    isolated resource function put profile/[int id](ProfileUpdate value) returns Profile|persist:Error {
        _ = check self.persistClients.get(PROFILE).runUpdateQuery(id, value);
        return self->/profile/[id].get();
    }

    isolated resource function delete profile/[int id]() returns Profile|persist:Error {
        Profile result = check self->/profile/[id].get();
        _ = check self.persistClients.get(PROFILE).runDeleteQuery(id);
        return result;
    }

    isolated resource function get user() returns stream<User, persist:Error?> {
        stream<record {}, sql:Error?>|persist:Error result = self.persistClients.get(USER).runReadQuery(User);
        if result is persist:Error {
            return new stream<User, persist:Error?>(new UserStream((), result));
        } else {
            return new stream<User, persist:Error?>(new UserStream(result));
        }
    }

    isolated resource function get user/[int id]() returns User|persist:Error {
        User|error result = (check self.persistClients.get(USER).runReadByKeyQuery(User, id)).cloneWithType(User);
        if result is error {
            return <persist:Error>error(result.message());
        }
        return result;
    }

    isolated resource function post user(UserInsert[] data) returns int[]|persist:Error {
        _ = check self.persistClients.get(USER).runBatchInsertQuery(data);
        return from UserInsert inserted in data
            select inserted.id;
    }

    isolated resource function put user/[int id](UserUpdate value) returns User|persist:Error {
        _ = check self.persistClients.get(USER).runUpdateQuery(id, value);
        return self->/user/[id].get();
    }

    isolated resource function delete user/[int id]() returns User|persist:Error {
        User result = check self->/user/[id].get();
        _ = check self.persistClients.get(USER).runDeleteQuery(id);
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

public class ProfileStream {

    private stream<anydata, sql:Error?>? anydataStream;
    private persist:Error? err;

    public isolated function init(stream<anydata, sql:Error?>? anydataStream, persist:Error? err = ()) {
        self.anydataStream = anydataStream;
        self.err = err;
    }

    public isolated function next() returns record {|Profile value;|}|persist:Error? {
        if self.err is persist:Error {
            return <persist:Error>self.err;
        } else if self.anydataStream is stream<anydata, sql:Error?> {
            var anydataStream = <stream<anydata, sql:Error?>>self.anydataStream;
            var streamValue = anydataStream.next();
            if streamValue is () {
                return streamValue;
            } else if (streamValue is sql:Error) {
                return <persist:Error>error(streamValue.message());
            } else {
                Profile|error value = streamValue.value.cloneWithType(Profile);
                if value is error {
                    return <persist:Error>error(value.message());
                }
                record {|Profile value;|} nextRecord = {value: value};
                return nextRecord;
            }
        } else {
            return ();
        }
    }

    public isolated function close() returns persist:Error? {
        check persist:closeEntityStream(self.anydataStream);
    }
}

public class UserStream {

    private stream<anydata, sql:Error?>? anydataStream;
    private persist:Error? err;

    public isolated function init(stream<anydata, sql:Error?>? anydataStream, persist:Error? err = ()) {
        self.anydataStream = anydataStream;
        self.err = err;
    }

    public isolated function next() returns record {|User value;|}|persist:Error? {
        if self.err is persist:Error {
            return <persist:Error>self.err;
        } else if self.anydataStream is stream<anydata, sql:Error?> {
            var anydataStream = <stream<anydata, sql:Error?>>self.anydataStream;
            var streamValue = anydataStream.next();
            if streamValue is () {
                return streamValue;
            } else if (streamValue is sql:Error) {
                return <persist:Error>error(streamValue.message());
            } else {
                User|error value = streamValue.value.cloneWithType(User);
                if value is error {
                    return <persist:Error>error(value.message());
                }
                record {|User value;|} nextRecord = {value: value};
                return nextRecord;
            }
        } else {
            return ();
        }
    }

    public isolated function close() returns persist:Error? {
        check persist:closeEntityStream(self.anydataStream);
    }
}
