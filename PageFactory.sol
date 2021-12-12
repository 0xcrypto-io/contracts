// SPDX-License-Identifier: MIT
pragma solidity >=0.4.20;

import "./Page.sol";

contract PageFactory {
    
    mapping(address => bool) public supported_pages;
    mapping(address => address) public get_page;
    address payable contract_owner = payable(msg.sender);
    
    function create_page(uint membership_fees) external {
        address new_page = address(new Page(msg.sender, membership_fees));
        supported_pages[new_page] = true;
        get_page[msg.sender] = new_page;
    }
    
    receive() external payable {
        // used to pay developers, servers, marketing etc
        contract_owner.transfer(msg.value);
    }
    
    fallback() external payable { 
        // used to pay developers, servers, marketing etc
        contract_owner.transfer(msg.value);
    }
}

