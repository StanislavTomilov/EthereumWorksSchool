pragma solidity ^0.4.11;
import 'github.com/oraclize/ethereum-api/oraclizeAPI.sol';


contract DollarCost is usingOraclize {
    uint public dollarCost; // переменная для хранения курса ETH/USD

    //функция вызываемая ораклайзом, в нее будет приходить курс ETH/USD
    function __callback(bytes32 myid, string result) public {
        if (msg.sender != oraclize_cbAddress()) throw;
        dollarCost = parseInt(result, 3);
    }

    //публичная функция для обновления курса
    function updatePrice () public payable {
        // проверяем хватает ли GAS для обновления курса
        if (oraclize_getPrice("URL") > this.balance) {
            //Если Gas не хватает, выходим из функции
            return;
        }
        else {
            //Иначе дергаем апишку биржи
            oraclize_query("URL", "json(https://api.kraken.com/0/public/Ticker?pair=ETHUSD).result.XETHZUSD.c[0]");
        }
    }
}