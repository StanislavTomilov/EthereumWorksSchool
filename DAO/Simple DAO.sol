pragma solidity ^0.4.11;

contract SimpleDAO {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;

    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowance;

    uint public minVotes = 6; // минимальное кол-во глосов для смены имени
    string public proposalName; // предлагаемое имя токена
    bool public voteActive; // флаг активности голосования
    // структура для хранения результатов голосования
    struct Votes{
        int current;
        uint numberOfVotes;
    }
    Votes public elections;
    mapping (address => uint) public votesControl;

    event Transfer(address from, address to, uint256 value);
    event Approval(address from, address to, uint256 value);

    // Функция инициализации контракта
    function SimpleDAO() public {
        decimals = 0;
        totalSupply = 10 * (10 ** uint256(decimals));
        balanceOf[msg.sender] = totalSupply;
        name = "Ok Token";
        symbol = "OKT";
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

    function newName(string _proposalName) public {
        require(!voteActive);
        proposalName = _proposalName;
        voteActive = true;
    }

    function vote (bool _vote) public {
        require(voteActive);
        require(votesControl[msg.sender] == 0);
        if (_vote) {
            elections.current += int(balanceOf[msg.sender]);
        }
        else {
            elections.current -= int(balanceOf[msg.sender]);
        }
        elections.numberOfVotes += balanceOf[msg.sender];
        votesControl[msg.sender] = 1;
    }

    function changeName() public {
        require(voteActive);
        require(elections.numberOfVotes >= minVotes);

        if (elections.current > 0) {
            name = proposalName;
        }

        elections.current = 0;
        elections.numberOfVotes = 0;
        voteActive = false;
    }
}