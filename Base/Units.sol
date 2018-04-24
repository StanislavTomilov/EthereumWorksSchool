pragma solidity ^0.4.0;

contract Units {
    //Ethers
    uint public oneWei = 1 wei;
    uint public oneFinney = 1 finney;
    uint public oneSzabo = 1 szabo;
    uint public oneEther = 1 ether;

    //Message
    bytes public msgData;
    address public msgSender;
    bytes4 public msgSig;
    uint public msgGas;
    uint public msgValue;
    uint public value;

    function setMessageValue(uint _value) public payable {
        value = _value;
        msgData = msg.data;
        msgSender = msg.sender;
        msgSig = msg.sig;
        msgGas = msg.gas;
        msgValue = msg.value;
    }

    //Time
    function getSecond(uint _a) public view returns(uint) {
        return _a * 1 seconds;
    }

    function getMinutes(uint _a) public view returns(uint) {
        return _a * 1 minutes;
    }

    function getHours(uint _a) public view returns(uint) {
        return _a * 1 hours;
    }

    function getDays(uint _a) public view returns(uint) {
        return _a * 1 days;
    }

    function getWeeks(uint _a) public view returns(uint) {
        return _a * 1 weeks;
    }

    function getYears(uint _a) public view returns(uint) {
        return _a * 1 years;
    }
}
