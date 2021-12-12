// SPDX-License-Identifier: MIT
pragma solidity >=0.4.20;

contract Page {
    
    address payable page_address;
    uint current_membership_fees;
    mapping(address => bool) public is_member;
    mapping(address => uint256) public valid_till;
    
    constructor (address page_address_provided, uint membership_fees) {
        page_address = payable(page_address_provided);
        current_membership_fees = membership_fees;
    }

    function become_member() external payable {
        assert(msg.value >= current_membership_fees);
        is_member[msg.sender] = true;
        valid_till[msg.sender] = block.timestamp+2592000;
        page_address.transfer(msg.value);
    }

    function check_is_member(address to_check_address) public view returns(bool)  {
        return is_member[to_check_address] && valid_till[to_check_address]>block.timestamp;
    }
    
    receive() external payable {
        page_address.transfer(msg.value);
    }
    
    fallback() external payable {
        page_address.transfer(msg.value);
    }
}

