pragma solidity ^0.4.11;

contract WrongICO {
    string public name; // имя токена
    string public symbol; // короткое имя токена
    uint8 public decimals; // разрядность токена, т.е. число нулей для токена
    uint256 public totalSupply; // общее кол-во выпущенных токенов

    mapping(address => uint256) public balanceOf; // мапа для хранения балансов пользователей
    mapping(address => mapping(address => uint256)) allowance; // мапа для хранения одобренных транзакций

    uint public buyPrice; //переменная для хранения стоимости токена

    event Transfer(address _from, address _to, uint256 _value); // логирование транзакций
    event Approval(address _from, address _to, uint256 _value); // логирование одобренных к переводу токенов

    // функция инициализации
    function WrongICO() public {
        decimals = 6;
        totalSupply = 1000000 * (10 ** uint256(decimals));
        balanceOf[this] = totalSupply;

        name = "Tomil";
        symbol = "TOM";

        buyPrice = 1000; // 1 токен стоит 1000 Wei
    }

    // внутренняя Функция для осуществления транзакций
    function _transfer(address _from, address _to, uint256 _value) internal {
        require(_to != 0x0); // проверяем что адрес получатель не пусто
        require(balanceOf[_from] >= _value); //проверяем достаточность средств
        require(balanceOf[_to] + _value >= balanceOf[_to]); // проверка на переполнение

        balanceOf[_from] -= _value; // снимаем средства с адреса отправителя
        balanceOf[_to] += _value; // зачисляем средства на адрес получателя

        Transfer(_from, _to, _value); // записали в лог операцию перевода средств
    }

    //внешняя функция для осуществления транзакций
    function transfer(address _to, uint256 _value) public {
        _transfer(msg.sender, _to, _value); // вызываем внутреннюю функцию
    }

    // функция осуществления одобренных переводов
    function transferFrom(address _from, address _to, uint256 _value) public {
        require(allowance[_from][_to] >= _value);
        allowance[_from][_to] -= _value;
        _transfer(_from, _to, _value);
    }

    // функция для одобрения переводов токенов
    function approve(address _to, uint256 _value) public {
        //require(_to != 0x0);
        //require(balanceOf[msg.sender] >= _value);
        allowance[msg.sender][_to] = _value;
        Approval(msg.sender, _to, _value); // записали в лог операцию одобрения перевода токенов
    }

    //Функция приема эфира на контракт
    function() public payable  {
        _buy(msg.sender, msg.value);
    }

    //Вызываемая функция для покупки токенов
    function buy() public payable  {
        _buy(msg.sender, msg.value);
    }

    //Внутренняя функция для продажи токенов
    function _buy(address _from, uint _value) internal {
        uint amount = _value / buyPrice;
        _transfer(this, _from, amount);
    }
}
