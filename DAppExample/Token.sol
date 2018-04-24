pragma solidity ^0.4.11;

contract Ownable {
    address public owner;
    event OwnershipTransfered(address indexed previousOwner, address indexed newOwner);

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function Ownable () public {
        owner = msg.sender;
    }

    function transferOwnership(address _newOwner) onlyOwner public {
        require(_newOwner != address(0));
        OwnershipTransfered(owner, _newOwner);
        owner = _newOwner;
    }
}

contract MyToken is Ownable {

    mapping(address => uint) public balanceOf;
    address public appContract;

    function MyToken() public {
        balanceOf[msg.sender] = 1000000;
    }

    function transfer(address _to, uint _value) public {
        require(balanceOf[msg.sender] >= _value);
        require(balanceOf[_to] + _value > balanceOf[_to]);
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
    }

    function setAppContract(address _app) public onlyOwner {
        appContract = _app;
    }

    function payment(address _from, uint _value) public returns(bool) {
        require(msg.sender == appContract);
        if (balanceOf[_from] >= _value) {
            balanceOf[_from] -= _value;
            balanceOf[appContract] += _value;
            return true;
        } else {
            return false;
        }
    }
}
