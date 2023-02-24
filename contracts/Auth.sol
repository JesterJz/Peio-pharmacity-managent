// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Auth{
    
    uint public userCount=0;

    mapping(string => user) public usersList;

     struct user{
      string username;
      string accountid;
      string email;
      string password;
  }

   // events

   event userCreated(
      string username,
      string accountid,
      string email,
      string password
    );

  function createUser(string memory _username,string memory _accountid,string memory _email,string memory _password ) public {
      
        userCount++;

        usersList[_email] = user(_username, _accountid, _email,_password);
      
        emit userCreated(_username,_accountid,_email,_password);
    }


}