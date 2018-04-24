pragma solidity ^0.4.11;

contract OwnableWithDAO {
    address public owner; // владелец контракта
    address public daoContract; // адрес DAO

    //функция инициализации
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

    function transferOwnership(address _newOwner) onlyOwner public {
        require(_newOwner != address(0));
        owner = _newOwner;
    }

    function setDAOcontract(address _newDAO) onlyOwner public {
        require(_newDAO != address(0));
        daoContract = _newDAO;
    }
}

contract Stoppable is OwnableWithDAO {
    bool public stopped;

    modifier stoppable() {
        require(!stopped);
        _;
    }

    function stop() onlyDAO public {
        stopped = true;
    }

    function start() onlyDAO public {
        stopped = false;
    }
}


contract DAOToken is Stoppable {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;

    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowance;

    event Transfer(address from, address to, uint256 value);
    event Approval(address from, address to, uint256 value);

    // Функция инициализации контракта
    function DAOToken() public {
        decimals = 0;
        totalSupply = 10 * (10 ** uint256(decimals));
        balanceOf[msg.sender] = totalSupply;
        name = "SberTech";
        symbol = "SBT";
    }

    function _transfer(address _from, address _to, uint256 _value) stoppable internal {
        require(_to != 0x0);
        require(balanceOf[_from] >= _value);
        require(balanceOf[_to] + _value >= balanceOf[_to]);

        balanceOf[_to] += _value;
        balanceOf[_from] -= _value;

        Transfer(_from, _to, _value);
    }

    // Функция для перевода токенов
    function transfer(address _to, uint256 _value) public {
        _transfer(msg.sender, _to, _value);
    }

    // Функция для перевода "одобренных" токенов
    function transferFrom(address _from, address _to, uint256 _value) public {
        require(_value <= allowance[_from][_to]);
        allowance[_from][_to] -= _value;
        _transfer(_from, _to, _value);
    }

    // Функция для "одобрения" перевода токенов
    function approve(address _to, uint256 _value) public {


        allowance[msg.sender][_to] = _value;
        Approval(msg.sender, _to, _value);
    }

    //функция для смены наименования токена
    function changeSymbol(string _newSymbol) onlyDAO public {
        symbol = _newSymbol;
    }
}