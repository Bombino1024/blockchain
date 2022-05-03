// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract dao {

    struct Election {
        uint256 id;
        string name;
        uint256 countFor;
        uint256 countAgainst;
        uint256 timeOfCreation;
    }

    constructor() {
        electionCounter = 0;
    }

    event ElectionCreated(string name, uint256 id, uint256 creationTime);
    event VoteFor(string name, uint256 id, address voter);
    event VoteAgianst(string name, uint256 id, address voter);

    uint256 electionCounter;
    mapping(uint256 => Election) public elections;

    mapping (address => mapping (uint256 => bool)) voteRegistry;

    function createElection(string memory name) public {
        uint256 creationTime = block.timestamp;
        Election memory election = Election(electionCounter, name, 0, 0, creationTime);
        elections[electionCounter] = election;
        emit ElectionCreated(name, electionCounter, creationTime);
        electionCounter++;
    }

    function voteFor(uint256 _electionId) public {
        address _voter = msg.sender;
        require (voteRegistry[_voter][_electionId] == false, "Sender already voted in this post");
        elections[_electionId].countFor++;
        voteRegistry[_voter][_electionId] = true;
        emit VoteFor(elections[_electionId].name, _electionId, _voter);
    }

    function voteAgainst(uint256 _electionId) public {
        address _voter = msg.sender;
        require (voteRegistry[_voter][_electionId] == false, "Sender already voted in this post");
        elections[_electionId].countAgainst++;
        voteRegistry[_voter][_electionId] = true;
        emit VoteAgianst(elections[_electionId].name, _electionId, _voter);
    }


}