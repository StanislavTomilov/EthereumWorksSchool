pragma solidity ^0.4.11;

interface MyToken {
    function payment(address _from, uint _value) public returns(bool);
}

contract Ownable {
    address public owner;
    event OwnershipTransfered(address indexed previousOwner, address indexed newOwner);

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function Ownable() public {
        owner = msg.sender;
    }

    function transferOwnership(address _newOwner) onlyOwner public {
        require(_newOwner != address(0));
        OwnershipTransfered(owner, _newOwner);
        owner = _newOwner;
    }
}

contract App is Ownable {
    string public message;
    address public lastDonator;
    MyToken public token;
    uint public price = 10;

    function App(MyToken _token){
        token = _token;
    }

    function setPrice(uint _newPrice) public onlyOwner {
        price = _newPrice;
    }

    function setMessage(string _message) public returns(bool) {
        if (token.payment(msg.sender, price)) {
            message = _message;
            lastDonator = msg.sender;
            return true;
        } else {
            return false;
        }
    }
}
