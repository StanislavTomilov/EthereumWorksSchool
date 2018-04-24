pragma solidity ^0.4.11;
//


contract MySecondERC20Coin {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;

    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowance;

    event Transfer(address from, address to, uint256 value);
    event Approval(address from, address to, uint256 value);

    // Функция инициализации контракта
    function MySecondERC20Coin() public {
        decimals = 8;
        totalSupply = 10000000 * (10 ** uint256(decimals));
        balanceOf[msg.sender] = totalSupply;
        name = "TomilClassic";
        symbol = "TMC";
    }

    function _transfer(address _from, address _to, uint256 _value) internal {
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
}