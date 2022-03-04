// SPDX-License-Identifier: MIT

pragma solidity >=0.8.6;

contract OpenFund{
    // Events of Crowdfund Logic
    event ProjectCreated(uint256 proposalId, string name, string description, uint256 fundsGoal);
    event ProjectFunded(uint256 proposalId, uint256 value);
    event ProjectState(uint256 id, CurrentState state);
    
    // States for the transaction
    enum CurrentState {
        Opened,
        Closed
    }
    // Contribution details
    struct Contribution{
        address contributer;
        uint256 value;
    }
    // Fund details Object
    struct Project {
        uint256 proposalId;
        string name;
        string desciption;
        address payable owner;
        CurrentState state;
        uint256 fund;
        uint256 fundGoal;
    }  
    Project[] public projects;

}