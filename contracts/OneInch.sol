// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import "./ERC20Permit.sol";


contract OneInch is ERC20Burnable, ERC20Permit, AccessControl {
    using SafeERC20 for IERC20;

    bytes32 public constant DEPOSITOR_ROLE = keccak256("DEPOSITOR_ROLE");

    modifier only(bytes32 role) {
        require(
            hasRole(role, _msgSender()),
            "INSUFFICIENT_PERMISSIONS"
        );
        _;
    }

    constructor(address owner, address childChainManager) public ERC20("1INCH Token", "1INCH") EIP712("1INCH Token", "1") {
        _setupRole(DEFAULT_ADMIN_ROLE, owner);
        _setupRole(DEPOSITOR_ROLE, childChainManager);
    }

    function deposit(address user, bytes calldata depositData) external only(DEPOSITOR_ROLE) {
        uint256 amount = abi.decode(depositData, (uint256));
        _mint(user, amount);
    }

    function withdraw(uint256 amount) external {
        _burn(_msgSender(), amount);
    }

    function rescueFunds(IERC20 token, uint256 amount) external only(DEFAULT_ADMIN_ROLE) {
        if (address(token) == address(0)) {
            _msgSender().transfer(amount);
        } else {
            token.safeTransfer(msg.sender, amount);
        }
    }
}
