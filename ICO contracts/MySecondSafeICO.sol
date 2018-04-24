pragma solidity ^0.4.11;

interface TomilClassic {
    function transfer(address _receiver, uint256 _amount) public;
}

contract MySecondSafeICO {

    uint public buyPrice;
    TomilClassic public token;

    function MySecondSafeICO(TomilClassic _token) public {
        token = _token;
        buyPrice = 10000;
    }

    function () payable public {
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

//0x217A689065A3978C420B3B55EAd9926F4E814Ae4