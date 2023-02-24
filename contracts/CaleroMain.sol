// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./Ownable.sol";

/**
* @title CaleroMain
* @dev Calero platform main smart contract.
*/
contract CaleroMain is Ownable {
    struct Invoice {
        address seller;
        address buyer;
        uint user_id;
        uint order_id;
        uint total_price;
        string message;
        string created_at;
        bool paid;
    }
    
    Invoice[] internal invoices;
    
    mapping (address => uint[]) internal sellers;
    mapping (address => uint[]) internal buyers;
    mapping (address => uint) public balances;
    
    function addInvoice(address fromAddress, uint user_id, uint order_id, uint total_price, string memory message, string memory created_at) public {
        Invoice memory inv = Invoice({
            buyer: fromAddress,
            seller: msg.sender, 
            user_id: user_id,
            order_id: order_id,
            total_price:total_price,
            message: message,
            created_at: created_at,
            paid: false
        });
        

        invoices.push(inv);
        sellers[inv.seller].push(invoices.length - 1);
        buyers[inv.buyer].push(invoices.length - 1);
    }
    
    function viewInvoice(uint id) public view returns(address, address, uint, uint, uint, string memory, string memory, bool) {
        Invoice memory inv = invoices[id];
        return (inv.seller, inv.buyer, inv.user_id, inv.order_id, inv.total_price, inv.message, inv.created_at, inv.paid);
    }
    
    
    function getIncomingInvoices(address buyerAddress, uint idx) public view returns (uint, address, uint, uint, uint, string memory, string memory, bool) {
        Invoice memory inv = invoices[ buyers[buyerAddress][idx] ];
        return (buyers[buyerAddress][idx], inv.buyer, inv.user_id, inv.order_id, inv.total_price, inv.message, inv.created_at, inv.paid);
    }
    
    function numberOfIncomingInvoices(address buyerAddress) public view returns (uint) {
        return buyers[buyerAddress].length;
    }


    function getOutgoingInvoice(address sellerAddress, uint idx) public view returns (uint, address, uint, uint, uint, string memory, string memory, bool) {
        Invoice memory inv = invoices[ sellers[sellerAddress][idx] ];
        return (sellers[sellerAddress][idx], inv.buyer,  inv.user_id, inv.order_id, inv.total_price, inv.message, inv.created_at, inv.paid);
    }
    
    function numberOfOutgoingInvoices(address sellerAddress) public view returns (uint) {
        return sellers[sellerAddress].length;
    }
    
    
    // function pay(uint id) public payable {
    //     Invoice storage inv = invoices[id];
        
    //     require(inv.paid == false);
    //     require(inv.buyer == msg.sender);
    //     require(msg.value == inv.amount);
        
    //     inv.paid = true;
    //     balances[inv.seller] += msg.value;
    // }
    
    // function withdraw() public {
    //     require(balances[msg.sender] != 0);
        
    //     uint toWithdraw = balances[msg.sender];
    //     balances[msg.sender] = 0;
    //     msg.sender.transfer(toWithdraw);
    //     payable(request.recipient).transfer(toWithdraw);
    // }

}