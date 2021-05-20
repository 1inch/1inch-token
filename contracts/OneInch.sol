// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./ERC20Permit.sol";
import "./Manageable.sol";


contract OneInch is ERC20Permit, ERC20Burnable, Ownable, Manageable {
    using SafeERC20 for IERC20;

    constructor(address _owner, address _childChainManager)
        public
        ERC20("1INCH Token", "1INCH")
        EIP712("1INCH Token", "1")
        Manageable(_childChainManager)
    {
        transferOwnership(_owner);
    }

    function rescueFunds(IERC20 token, uint256 amount) external onlyOwner {
        if (address(token) == address(0)) {
            _msgSender().transfer(amount);
        } else {
            token.safeTransfer(msg.sender, amount);
        }
    }

    function deposit(address user, bytes calldata depositData) external onlyManager {
        uint256 amount = abi.decode(depositData, (uint256));
        _mint(user, amount);
    }

    function withdraw(uint256 amount) external {
        _burn(_msgSender(), amount);
    }
}
