pragma solidity ^0.4.11;

//Объявляем контракт
contract simpleContract {

    address public donator; //Объявляем переменную donator, в которой будет содержаться значение типа адрес
    string public report; //Объявляем переменную repFromSender, в которой будет содержаться сообщение из транзакции

    //Функция для приема эфиров
    function () public payable {
        donator = msg.sender; //Присваиваем переменной donator значение адреса того, кто отправил эфиры
    }

    //Функция приема report
    function getReport(string _recRep) public {
        report = _recRep; //Присваиваем переменной report значение входящего параметра
    }
}
