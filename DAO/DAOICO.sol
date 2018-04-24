pragma solidity ^0.4.0;

contract OwnableWithDAO {
    address owner;
    address daoContract;

    function OwnableWithDAO() public {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier onlyDAO() {
        require(msg.sender == daoContract);
        _;
    }

    function setOwner (address _newOwner) onlyOwner public {
        require(_newOwner != address(0));
        owner = _newOwner;
    }

    function setDAOContract(address _daoContract) public onlyOwner {
        require(_daoContract != address(0));
        daoContract = _daoContract;
    }

}

interface Token {
    function transfer(address _to, uint256 _value) public;
}

contract DAOICO is OwnableWithDAO {
    uint public buyPrice; // цена токена
    uint public tokenAmount; // кол-во токенов рассчитаное путем деления присланных эфиров на buyPrice
    Token token;
    address public tokenAddress;

    function DAOICO(Token _token) public {
        buyPrice = 1 finney;
        token = _token;
    }

    function () public payable {
        tokenAmount = msg.value / buyPrice;
        _buy(msg.sender, tokenAmount);
    }

    function buy() public payable {
        tokenAmount = msg.value / buyPrice;
        _buy(msg.sender, tokenAmount);
    }

    function _buy(address _to, uint _amount) internal {
        token.transfer(_to, _amount);
    }

    function changePrice(uint _newPrice) onlyDAO public  {
        buyPrice = _newPrice;
    }
}
