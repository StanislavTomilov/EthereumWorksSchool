pragma solidity ^0.4.11;

interface MyToken {
    function transfer(address _receiver, uint256 _amount);
}

contract DAppICO {

    uint public buyPrice;
    MyToken public token;

    function DAppICO(MyToken _token){
        token = _token;
        buyPrice = 10000;
    }

    function () payable {
        _buy(msg.sender, msg.value);
    }

    function buy() payable returns (uint){
        uint tokens = _buy(msg.sender, msg.value);
        return tokens;
    }

    function _buy(address _sender, uint256 _amount) internal returns (uint){
        uint tokens = _amount / buyPrice;
        token.transfer(_sender, tokens);
        return tokens;
    }
}