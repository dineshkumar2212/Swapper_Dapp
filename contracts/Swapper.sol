// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";
import "@uniswap/v3-periphery/contracts/libraries/TransferHelper.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// Uniswap V3 Documentation
// --> https://docs.uniswap.org/contracts/v3/guides/swaps/single-swaps

contract Swapper {
    address public owner;
    address public immutable SWAP_ROUTER;

    constructor(address _SWAP_ROUTER){
        SWAP_ROUTER=_SWAP_ROUTER;
        owner=msg.sender;
    }
    function swap(address[] memory _path,uint24 _fee, uint256 _amountIn) public {
        //build swap params
        ISwapRouter.ExactInputSingleParams memory params = ISwapRouter
            .ExactInputSingleParams({
                tokenIn:_path[0],
                tokenOut:_path[1],
                fee:_fee,
                recipient:address(this),
                deadline:block.timestamp,
                amountIn:_amountIn,
                amountOutMinimum:0,
                sqrtPriceLimitX96:0
            });
        //swap
        ISwapRouter(SWAP_ROUTER).exactInputSingle(params);
        //Transfer to Wallet

    }
}
