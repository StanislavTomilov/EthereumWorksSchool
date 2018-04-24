pragma solidity ^0.4.0;

contract Types {

    //Integer и uint
    int public a = 4;
    uint public b = 4;

    function plus(int _x) public view returns(int) {
        return a + _x;
    }

    function plus_u(uint _x) public view returns(uint) {
        return b + _x;
    }

    function minus(int _x) public view returns(int) {
        return a - _x;
    }

    function minus_u(uint _x) public view returns(uint) {
        return b - _x;
    }

    function multiply(int _x) public view returns(int) {
        return a * _x;
    }

    function multiply_u(uint _x) public view returns(uint) {
        return b * _x;
    }

    function division(int _x) public view returns(int) {
        return a / _x;
    }

    function division(uint _x) public view returns(uint) {
        return b / _x;
    }

    //String
    string public simpleString = "Hello world";

    function changeString(string _newString) public {
        simpleString = _newString;
    }

    //Array
    uint[] public simpleArray;

    function push(uint _value) public {
        simpleArray.push(_value);
    }

    //Mapping
    mapping(uint => uint) public simpleMap;

    function addMap(uint _key, uint _value) public {
        simpleMap[_key] = _value;
    }

    //Structure
    struct Client{
        string name;
        string lastName;
        uint age;
    }

    Client[] public clients;

    mapping(uint => Client) public clientsMap;

    function addToArray(string _name, string _lastName, uint _age) public {
        clients.push(Client({name: _name, lastName: _lastName, age: _age}));
    }

    function addToMap(uint _nickname, string _name, string _lastName, uint _age) public {
        clientsMap[_nickname] = Client({name: _name, lastName: _lastName, age: _age});
    }

}
