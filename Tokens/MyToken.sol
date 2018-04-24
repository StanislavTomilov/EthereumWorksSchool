pragma solidity ^0.4.11;

contract MyToken {
    // Мапа для хранения балансов кошельков-держателей токенов
    mapping(address => uint256) public balanceOf;

    // Функция инициализации, генерирует общее кол-во токенов
    function MyToken(uint256 _initialSupply) public {
        balanceOf[msg.sender] = _initialSupply;
    }

    //Функция для отправки токенов
    function transfer(address _to, uint256 _value) public {
        // проверяем достаточность средств у отправителя
        require(balanceOf[msg.sender] >= _value);
        // проверяем не произойдет ли переполнение
        require(balanceOf[msg.sender] + _value >= balanceOf[msg.sender]);
        // снимаем средства со счета отправителя
        balanceOf[msg.sender] -= _value;
        // зачисляем средства на счет получателя
        balanceOf[_to] += _value;
    }
}
