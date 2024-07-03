// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {

    struct TokenCards {
        uint A;
        uint B;
        uint C;
    }

 mapping(address => TokenCards) public userCards;
 
address public storeAddress;

event TokensRedeemed(address indexed redeemer, address indexed storeAddress, uint256 amount);

storeAddress = address(0x1234567890AbcdEF1234567890aBcdef12345678);
}
function setStoreAddress(address _storeAddress) external onlyOwner {
storeAddress = _storeAddress;
}
function mint(address to, uint256 amount) public onlyOwner {
   require(to != address(0), "Cannot mint to zero address");
   require(amount > 0, "Amount must be greater than zero");
   _mint(to, amount);
}
function decimals() public pure override returns (uint8) { 
   return 18; 
}
function getBalance() external view returns (uint256) {
    return balanceOf(msg.sender);
}
function transferTokens(address _receiver, uint256 _amount) external {
    require(balanceOf(msg.sender) >= _amount, "You do not have enough Degen tokens");
    _transfer( msg.sender,_receiver, _amount);
}
function burnTokens(uint256 _value) external {
    require(balanceOf(msg.sender) >= _value, "You do not have enough Degen Tokens");
    _burn(msg.sender, _value);
}    
function redeemTokens( uint input) external returns (string memory) {
    TokenCards storage userCard = userCards[msg.sender];

      uint price;
        if (input == 1) {
            price = 100;
            require(balanceOf(msg.sender) >= price, "You do not have enough tokens to redeem Item A");
            userCard.A++;
        } else if (input == 2) {
            price = 200;
            require(balanceOf(msg.sender) >= price, "You do not have enough tokens to redeem Item B");
            userCard.B++;
        } else if (input == 3) {
            price = 300;
            require(balanceOf(msg.sender) >= price, "You do not have enough tokens to redeem Item C");
            userCard.C++;
        } else {
            return "Unknown token card";
        }
        
        _burn(msg.sender, price);

        require(storeAddress != address(0), "Store address is not set");

        emit TokensRedeemed(msg.sender, storeAddress, price);

        return "Tokens redeemed successfully";
    }

    function checkBalance(address account) external view returns (uint256) {
        return balanceOf(account);
    }
}


               
