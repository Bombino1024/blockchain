pragma solidity >=0.6.2 <0.9.0;

// https://remix.ethereum.org/
	// Download all Files as a backup zip
	// Restore files from backup zip
// https://github.com/smartcontractkit/full-blockchain-solidity-course-py
// https://www.youtube.com/watch?v=M576WGiDBdQ
// 1:59:43

contract SimpleStorage {
    
    // this will be initialized to 0
    uint256 public favNumber;
    
    // public -> can be called anywhere, both internally and externally
    // private -> only callable from other functions inside the contract
    // external -> can only be called outside the contract
    // internal -> like private but can also be called by contracts that inherit from the current one (protected)
    function store(uint256 _favNumber) public {
        favNumber = _favNumber;
    }
    
    // view -> showing something
    // pure -> doing some calculation, but not storing a state
    function getFavNumber() public view returns(uint256) {
        return favNumber;
    }
    
    // a way to defined new types in solidity
    struct Person {
        uint256 favNumber;
        string name;
    }
    
    // a way to define list of objects (dynamic array)
    // Person[1] public people; (static array)
    Person[] public people;
    
    // initializing new person
    Person public person = Person({favNumber: 7, name: "Martin"});
    
    // defining how to store object during execution:
    // memory -> only stored during execution of the function
    // storage -> will persist in memory even after the execution of the function
    function addPersopn(string memory _name, uint256 _favNumber) public {
        people.push(Person(_favNumber, _name));
    }
    
}