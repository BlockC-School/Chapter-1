// SPDX-License-Identifier: MIT
import  "./OpenFund.sol";
// import "../@openzeppelin/contracts/access/Ownable.sol";
pragma experimental ABIEncoderV2;
pragma solidity >=0.8.3;

contract CampaignFactory is OpenFunds{
    address[] public deployedCampaigns;
    
    function CreateCampaign(
        string calldata _name,
        string calldata _description,
        address _from,
        uint256 _minimum,
        uint256 _fundGoal
    ) public OpenFund{
        address newCampaign = new OpenFunds(
            _name,
            _description,
            payable(msg.sender),
            0,
            _fundGoal
        );
        // Project Created and pushed 
        deployedCampaigns.push(newCampaign);
    }
    function getCampaign() public view returns (address[] memory) {
        return deployedCampaigns;
    }
}
