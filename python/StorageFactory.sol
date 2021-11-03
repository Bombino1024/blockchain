// SPDX-Licence-Identifier: MIT

pragma solidity >=0.6.2 <0.9.0;

import "./SimpleStorage.sol";

// Factory Pattern
// - StorageFactory needs to be in the same folder with SimpleStorage
// - StorageFactory then can deploy SimpleStorage
contract StorageFactory {
// contract StorageFactory is SimpleStorage { // inheritance
    
    SimpleStorage[] public simpleStorageArray;
    
    // deploying SimpleStorage contract
    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }
    
    // When you wanna interact with smart contract you need:
    // - Address
    // - ABI (application binary interface)
    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        // This will return the address of contract that we wanna interact with
        SimpleStorage simpleStorage = 
            SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]));
        simpleStorage.storeFavNumber(_simpleStorageNumber);
    }
    
    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256) {
        SimpleStorage simpleStorage = 
            SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]));
        return simpleStorage.getFavNumber();
    }
}