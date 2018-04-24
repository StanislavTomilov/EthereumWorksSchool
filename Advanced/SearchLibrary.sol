pragma solidity ^0.4.16;

// Объявляем библиотеку
library SearchLibrary {
    // функция поиска элемента в массиве
    function searchFor (uint[] storage self, uint _value) returns(uint) {
        for (uint i = 0; i < self.length; i++) {
            // если найден элемент массива, возвращаем номер позиции
            if (self[i] == _value) return i;
        }
        // если элемент массива не найден, возвращаем -1
        return uint(-1);
    }
}

// контракт использующий тестовую библиотеку
contract ContractWithBigArrays  {
    //Расширяем тип uint нашей библиотекой
    using SearchLibrary for uint[];

    uint[] public bigArrayOfNumbers;

    //Функция для наполнения массива
    function push(uint _value) public {
        bigArrayOfNumbers.push(_value);
    }

    //Функция для замены элемента массива
    function replace(uint _old, uint _new) public {
        uint position = bigArrayOfNumbers.searchFor(_old);

        if (position == uint(-1)){
            bigArrayOfNumbers.push(_new);
        }
        else {
            bigArrayOfNumbers[position] = (_new);
        }

    }


}
