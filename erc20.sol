// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ICO is ERC20,Ownable(msg.sender){

    constructor() ERC20("IneuronCoin","INC"){
        _mint(msg.sender,1000000); 
    }

    function mint(address account, uint256 amount) public onlyOwner returns(bool){
        require(account != address(0) && amount != uint256(0),"ERC20 : function mint invalid input");
        _mint(account,amount);
        return true;
    }

    function burn(address account , uint256 amount) public onlyOwner returns(bool){
        require(account != address(this) && amount != uint(0),"ERC20 : function burn invalid input");
        _burn(account,amount);
    }

    function buy() public payable returns(bool){
        require(msg.sender.balance >= msg.value && msg.value != 0 ether, "ICO : function buy ");
        uint amount = msg.value*1000;
        _transfer(owner(),_msgSender(),amount);
    }

    function withdraw(uint amount) public onlyOwner returns(bool){
        require(amount <=address(this).balance,"ICO : function withdraw has invalid input");
        _transfer(owner(),_msgSender(),amount);
        return(true);
    }
}