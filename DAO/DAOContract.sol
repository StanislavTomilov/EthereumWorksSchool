pragma solidity ^0.4.11;

interface ChangebleToken {
    function stop() public;
    function start() public;
    function changeSymbol(string newSymbol) public;
    function balanceOf(address user) public returns (uint);
}

interface DAOICO {
    function changePrice(uint _newPrice) public;
}

contract DAOContract {

    ChangebleToken public token;
    DAOICO ico;
    uint8 public minVotes;
    string public proposalName;
    uint public proposalPrice;
    bool public voteActive = false;
    struct Votes{
        int current;
        uint numberOfVotes;
    }

    Votes public election;

    function DAOContract(ChangebleToken _token, DAOICO _ico) public {
        token = _token;
        ico = _ico;
    }
    /*
    function newName(string _name) public {
        require(!voteActive);
        proposalName = _name;
        voteActive = true;

        token.stop;
    }
    */
    function newPrice(uint _price) public {
        require(!voteActive);
        proposalPrice = _price;
        voteActive = true;

        token.stop;
    }

    function vote(bool _vote) public {
        require(voteActive);

        if (_vote) {
            election.current += int(token.balanceOf(msg.sender));
        }
        else {
            election.current -= int(token.balanceOf(msg.sender));
        }
        election.numberOfVotes += token.balanceOf(msg.sender);
    }

    /*
    function changeSymbol() public {
        require(voteActive);
        //require(proposalName != null);
        require(election.numberOfVotes >=minVotes);

        if (election.current > 0) {
            token.changeSymbol(proposalName);
        }

        voteActive = false;
        election.current = 0;
        election.numberOfVotes = 0;
        proposalName = null;
        proposalPrice = null;

        token.start;
    }
    */
    function changePrice (uint _proposalPrice) public {
        require(voteActive);
        //require(proposalPrice != null);
        require(election.numberOfVotes >=minVotes);

        if (election.current > 0) {
            ico.changePrice(_proposalPrice);
        }

        voteActive = false;
        election.current = 0;
        election.numberOfVotes = 0;
        //proposalName = null;
        //proposalPrice = null;
        token.start;
    }
}
