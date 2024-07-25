//author- E/18/147 Saadia Jameel
//note  -   Disable browser CORS before running as the server and client make requests 
//          from different host addresses. Modern browsers block such javascript requests.
//      -   In code storage is used for the database.

import ballerina/http;
import ballerina/time;
import ballerina/random;


type User record{
    readonly int id;
    string firstName;
    string lastName;
    string regNo;
};

type NewUser record{
    string firstName;
    string lastName;
    string regNo;
};

table<User> key(id) users = table [
    {id:1, firstName:"Saadia", lastName: "Jameel", regNo: "E/18/147"},
    {id:2, firstName:"Ummu", lastName: "Hassen", regNo: "E/18/678"}
    // {id:3, name:"Beck", birthDate: {year: 1980, month: 2, day: 3}, mobileNumber: "0896745563"}
];


type ErrorDetails record {
    string message;
    string details;
    time:Utc timeStamp;
};

type UserNotFound record {|
    *http:NotFound;         //type intrusion
    ErrorDetails body;
|};


service /social\-media on new http:Listener(9090) {

    // get all users
    resource function get users() returns User[]|error {
        return users.toArray();
    }


    // Get a particular user
    resource function get users/[int id]() returns User|UserNotFound|error{
        User? user = users[id];
        if user is (){
            UserNotFound userNotFound = {
                body: {message: string `id: ${id}`, details: string `user/${id}`, timeStamp: time:utcNow()}
            };
            return userNotFound;
        }
        return user;
    }

    // Add a new user
    resource function post users(NewUser newUser) returns User[]|error{
        // users.add({id: users.length() + 1, ...newUser});
        // return http:CREATED;

        User newUserWithId = {
            
            id: users.length() + check random:createIntInRange(1, 100),
            firstName: newUser.firstName,
            lastName: newUser.lastName,
            regNo: newUser.regNo
        };
        users.add(newUserWithId);
        return users.toArray();
    }

    // delete a user
    resource function delete users/[int id]() returns User[]|UserNotFound|error {
        User? user = users[id];
        if user is () {
            UserNotFound userNotFound = {
                body: {message: string `id: ${id}`, details: string `user/${id} not found`, timeStamp: time:utcNow()}
            };
            return userNotFound;
        }
        User result = users.remove(id);
        return users.toArray();
    }

    // update a user
    resource function put users/[int id](NewUser updatedUser) returns User[]|UserNotFound|error {
        User? user = users[id];
        if user is () {
            UserNotFound userNotFound = {
                body: {message: string `id: ${id}`, details: string `user/${id} not found`, timeStamp: time:utcNow()}
            };
            return userNotFound;
        }
        User result = users.remove(id);
        User newUserWithId = {
            id: users.length() + check random:createIntInRange(1, 100),
            firstName: updatedUser.firstName,
            lastName: updatedUser.lastName,
            regNo: updatedUser.regNo
        };
        users.add(newUserWithId);
        return users.toArray();
        
    }

}
