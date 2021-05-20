// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/GSN/Context.sol";


contract Manageable is Context, Ownable {
    address private _manager;

    event ManagementTransferred(address indexed previousManager, address indexed newManager);

    /**
     * @dev Initializes the contract setting the manager as the initial owner.
     */
    constructor () internal {
        address msgSender = _msgSender();
        _manager = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Throws if called by any account other than the manager.
     */
    modifier onlyManager() {
        require(_manager == _msgSender(), "Caller is not the manager");
        _;
    }

    /**
     * @dev Transfers management of the contract to a new account (`newManager`).
     * Can only be called by the current owner.
     */
    function transferManagement(address newManager) public virtual onlyOwner {
        require(newManager != address(0), "New manager is zero address");
        emit ManagementTransferred(_manager, newManager);
        _manager = newManager;
    }
}
