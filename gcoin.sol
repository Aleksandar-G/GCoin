// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract GToken {

    uint totalSupplyTokens = 1000;
    address minter;
    mapping(address => uint) balances;
    mapping(address => mapping (address => uint256)) allowed;

    constructor(){
        minter= msg.sender;
        balances[msg.sender] = 1000;
    }

    event Approval(address indexed tokenOwner, address indexed spender,
    uint tokens);
    event Transfer(address indexed from, address indexed to,
    uint tokens);

    function totalSupply() public view returns (uint256){
        return totalSupplyTokens;
    }
    function balanceOf(address tokenOwner) public view returns (uint){
        return balances[tokenOwner];
    }
    function allowance(address tokenOwner, address spender)
    public view returns (uint){
        return allowed[tokenOwner][spender];
    }
    function transfer(address to, uint tokens) public returns (bool){
        require(balances[msg.sender] >= tokens);
        balances[msg.sender] -=tokens;
        balances[to] = balances[to] + tokens;

        emit Transfer(msg.sender, to, tokens);
        return true;
    }
    function approve(address spender, uint tokens)  public returns (bool){
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }
    function transferFrom(address from, address to, uint tokens) public returns (bool){
        require (balances[from] >= tokens);
        require (allowed[from][to] >= tokens);

        allowed[from][to] -= tokens;

        balances[from]-=tokens;
        balances[to]+=tokens;

        //event Transfer
        emit Transfer(from, to, tokens);

        return true;
    }
}
