// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./ERC20Permit.sol";


contract OneInch is ERC20Permit, ERC20Burnable, Ownable {
    using SafeERC20 for IERC20;

    constructor(address _owner) public ERC20("1INCH Token", "1INCH") EIP712("1INCH Token", "1") {
        transferOwnership(_owner);
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    /**
    * @dev Returns the bep token owner.
    */
    function getOwner() external view returns (address) {
        return owner();
    }

    function rescueFunds(IERC20 token, uint256 amount) external onlyOwner {
        token.safeTransfer(msg.sender, amount);
    }
}
