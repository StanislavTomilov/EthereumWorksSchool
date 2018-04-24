pragma solidity ^0.4.11;

contract LessSimpleContract {

    address public owner; // переменная для хранения адресата задеплоившего контракт
    address public donator; // переменная для хранения адреса с которого пришли эфиры
    uint public value; // переменная для хранения покупаемого значения
    uint public lastTimeForDonate; // переменая для хранения времени доната
    uint public lastTimeForValue; // переменная для хранения времени установки купленного значения
    uint public lastTimeForTransaction; // переменная для хранения времени установки купленного значения
    uint timeOut = 120 seconds; // задержка во времени
    address public adr = 0x2CA394093FF1BAd341b6e5CFd074ad6Dd611BEf0; // переменная хранящая адрес второго аккаунта

    // функция инициализации
    function LessSimpleContract() public {
        owner = msg.sender; // записываем адресат деплоющий контракт
    }

    // функция первоначального приема эфиров
    function() public payable {
        require(lastTimeForDonate + timeOut < now);
        require(msg.value > 1 finney);
        setDonator(msg.sender);
    }

    // функция для покупки значения
    function buyValue(uint _value) public payable {
        require(lastTimeForValue + timeOut < now);
        require(msg.value > 1 finney);
        setValue(_value);
        sendProfit(msg.value);
    }

    // функция записи адреса с которого пришли эфиры
    function setDonator(address _donator) internal {
        lastTimeForDonate = now;
        donator = _donator;
    }

    // функция записи значения в переменную
    function setValue(uint _value) internal {
        lastTimeForValue = now;
        value = _value;
    }

    // функция для отправки прибыли на свой адрес
    function sendProfit(uint _value) internal {
        adr.send(_value);
        lastTimeForTransaction = now;
    }

    // проверяем возможность удаления
    function remove() public {
        if (msg.sender == owner){
            selfdestruct(owner);
        }
    }
}
