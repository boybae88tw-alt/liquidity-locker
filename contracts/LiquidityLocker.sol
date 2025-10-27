// contracts/LiquidityLocker.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC20TransferFrom {
    function transferFrom(address from, address to, uint256 value) external returns (bool);
}

contract LiquidityLocker {
    struct Lock {
        uint256 amount;
        uint256 unlock;
    }

    mapping(address => Lock) public locks;

    function lock(address token, uint256 amt, uint256 duration) external {
        require(amt > 0, "amt=0");
        IERC20TransferFrom(token).transferFrom(msg.sender, address(this), amt);
        locks[msg.sender] = Lock(amt, block.timestamp + duration);
    }
}
