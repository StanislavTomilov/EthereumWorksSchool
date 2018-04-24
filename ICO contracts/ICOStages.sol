pragma solidity ^0.4.11;


// Инициализация контракта
contract MyThirdERC20Coin {


    string public name; // Объявляем переменную в которой будет название токена
    string public symbol; // Объявляем переменную в которой будет символ токена
    uint8 public decimals; // Объявляем переменную в которой будет число нулей токена
    uint public buyPrice; // переменная для хранения стоимости токенов
    uint256 public totalSupply; // Объявляем переменную в которой будет храниться общее число токенов
    uint public startTime; // дата начала index

    mapping (address => uint256) public balanceOf; // Объявляем маппинг для хранения балансов пользователей
    mapping (address => mapping (address => uint256)) public allowance; // Объявляем маппинг для хранения одобренных транзакций

    event Transfer(address from, address to, uint256 value); // Объявляем эвент для логгирования события перевода токенов
    event Approval(address from, address to, uint256 value); // Объявляем эвент для логгирования события одобрения перевода токенов

    // Функция инициализации контракта
    function MyThirdERC20Coin() public {

        decimals = 18;  // Указываем число нулей
        totalSupply = 10000000 * (10 ** uint256(decimals)); // Объявляем общее число токенов, которое будет создано при инициализации
        balanceOf[this] = totalSupply; // "Отправляем" все токены на баланс того, кто инициализировал создание контракта токена
        name = "Tomil"; // Указываем название токена
        symbol = "TOM"; // Указываем символ токена
        startTime = now; // указываем дату начала index
        //buyPrice = 7000000;
    }

    // Внутренняя функция для перевода токенов
    function _transfer(address _from, address _to, uint256 _value) internal {
        require(_to != 0x0); // Проверка на пустой адрес
        require(balanceOf[_from] >= _value);  // Проверка того, что отправителю хватает токенов для перевода
        require(balanceOf[_to] + _value >= balanceOf[_to]); // проверка переполнения
        balanceOf[_from] -= _value;// Токены прибавляются получателю
        balanceOf[_to] += _value; // Токены списываются у отправителя
        Transfer(_from, _to, _value); // логируем
    }

    // Функция для перевода токенов
    function transfer(address _to, uint256 _value) public {
        _transfer(msg.sender, _to, _value); // Вызов внутренней функции перевода
    }

    // Функция для перевода "одобренных" токенов
    function transferFrom(address _from, address _to, uint256 _value) public {
        require(_value <= allowance[_from][_to]); // Проверка, что токены были выделены аккаунтом _from для аккаунта _to
        allowance[_from][_to] -= _value;
        _transfer(_from, _to, _value); // Отправка токенов
    }

    // Функция для "одобрения" перевода токенов
    function approve(address _to, uint256 _value) public {
        allowance[msg.sender][_to] = _value;
        Approval(msg.sender, _to, _value);  // Вызов эвента для логгирования события одобрения перевода токенов
    }

    // Функция для отправки эфиров на контракт
    function() payable public {
        _buy(msg.sender, msg.value); // Выполняем внутреннюю функцию контракта
    }

    // Функция для отправки эфиров на контракт (вызываемая)
    function buy() payable public {
        _buy(msg.sender, msg.value);
    }

    // Внутренняя функция покупки
    function _buy(address _from, uint _value) internal {
        _setBuyPrice;
        uint amount = _value / buyPrice; // Получаем количество возможных для покупки токенов по курсу
        _transfer(this, _from, amount); // Вызываем внутреннюю функцию перевода токенов
    }

    function _setBuyPrice() internal {
        if (now - startTime  <= 10 seconds ) {
            buyPrice = 7000000; // стоимость = за 1 эфир (10 ** 18) даем 115 TOM

        if (now - startTime  <= 15 seconds ) {
            buyPrice = 8500000; // стоимость = за 1 эфир (10 ** 18) даем 115 TOM
        }
        if (now - startTime <= 30 seconds ) {
            buyPrice = 10000000; // стоимость = за 1 эфир (10 ** 18) даем 110 TOM
        }
    }

    function getBuyPrice(uint _value) public view returns(uint, uint, uint, uint){
        if (now - startTime <= 1 minutes ) {
            return (7000000, _value * 7000000, startTime, now);// стоимость = за 1 эфир (10 ** 18) даем 115 TOM
        }

        if (now - startTime <= 2 minutes) {
            return (8500000,  _value * 8500000, startTime, now); // стоимость = за 1 эфир (10 ** 18) даем 115 TOM
        }
        if (now - startTime <= 3 minutes) {
            return (10000000,  _value * 10000000, startTime, now); // стоимость = за 1 эфир (10 ** 18) даем 110 TOM
        }
    }
}