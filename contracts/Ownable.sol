// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

/**
* @title Ownable
* @dev The Ownable contract has an owner address, and provides basic authorization control
* functions, this simplifies the implementation of "user permissions".
*/
contract Ownable {
  address public owner;
  address public backEnd;

  event OwnershipRenounced(address indexed previousOwner);
  event BackEndUserAdded(address indexed backEndAddress);
  event OwnershipTransferred(
    address indexed previousOwner,
    address indexed newOwner
  );


  /**
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender
   * account.
   */
  constructor() {
    owner = msg.sender;
  }

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }
  
   /**
   * @dev Throws if called by any account other than the backend User.
   */
  modifier onlyBackEnd() {
    require(msg.sender == backEnd);
    _;
  }


  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0));
    emit OwnershipTransferred(owner, newOwner);
    owner = newOwner;
  }

  function setBackEndUser(address backEndUser) public onlyOwner {
    require(backEndUser != address(0));
    emit BackEndUserAdded(backEndUser);
    backEnd = backEndUser;
  }

  /**
   * @dev Allows the current owner to relinquish control of the contract.
   */
  function renounceOwnership() public onlyOwner {
    emit OwnershipRenounced(owner);
    owner = address(0);
  }
}