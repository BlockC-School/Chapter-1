// SPDX-License-Identifier: MIT
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC1155/ERC1155.sol";
// import "./node_modules/@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "./ERC1155/ERC1155.sol";

pragma solidity 0.8.12;
// This contract have some extra features than ERC721 
contract MyProCon is ERC1155 {
    //{balanceOf functions} 1 balanceOf // 2 balanceOfBatch
    //{operator functions} 1 isApprovedForAll // 2 setApprovalForAll
    // {transfers functiom} 1 safeTransferFrom // 2 safeBatchTransferFrom
    // {interface functions} 1 supportsInterface

    // mapping tokenIds to balanceOf those ids
    // TokenId => Address => Amount
    mapping(uint256 => mapping(address => uint256)) private _balances;
    // this function returns balanceOf One account & id
    function balanceOf(address account, uint256 id) public returns ( uint256 ) {
        require(account != address(0), 'not valid account'); // Account have to be a Owned address
        return _balances[id][account];
    }
    // this function returns balanceOf multiple accounts  &  ids
    function balanceOfBatch(address[] memory account, uint256[] memory id) public returns (uint256[] memory) {
        require(account != address(0), 'not valid account');
        // created a Var to track accounts length
        uint256 memory batchBalances = new uint256[](accounts.length);
        for(uint256 i = 0; i < accounts.length; i++) {
            batchBalances[i] = balanceOf(accounts[i], ids[i]);
        }
        return batchBalances;
    }
    // Operators functions
    function isApprovedForAll(address account, address operator);
}


