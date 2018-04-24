pragma solidity ^0.4.11;

interface MyToken{
    function transfer(address _receiver, uint256 _amount) public;
}

contract MyFirstSafeICO {

    uint public buyPrice;
    MyToken public token;

    function MyFirstSafeICO(MyToken _token) public{
        token = _token;
        buyPrice = 10000;
    }

    function() public payable {
        _buy(msg.sender, msg.value);
    }

    function buy() public payable returns (uint) {
        uint tokens = _buy(msg.sender, msg.value);
        return tokens;
    }

    function _buy(address _sender, uint256 _amount) internal returns (uint){
        uint tokens = _amount / buyPrice;
        token.transfer(_sender, tokens);
        return tokens;
    }
}
