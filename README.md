# DEGEN TOKEN

In this, we have to create a degen token and also use ``` minting function```, ```transfer function```, ```burn functions``` and ```checkbalance functions```.

## Description

In this, it is ethereum based ERC2o token that will implement all above functions like  minting tokens means where we have to mint new tokens and give specific address , burning functions for users can burn their tokens,reducing the total supply of token ,transferring tokens to transfer another address.Redeeming tokens where updates user's token card balance.

## Getting Started

### Executing program

To run code, follow these steps:
1. open my project
2. copy DegenToken.sol into remix.
3. Compile it by setting in advanced configuration language to solidity and evm version to shanghai and then deploy.
4. In depoly, set environment to 'injected provider- Metamask ,and connect with avalanche fuji in metamask which has avax tokens.
5. 5. Then deploy and first mint function then transfertoken then redeem token and then burn and at last checkbalance. 
```javascript

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

    event TokensRedeemed(address indexed redeemer, address indexed storeAddress, uint256 amount, string item);

    constructor() ERC20("Degen", "DGN") Ownable() {
        storeAddress = address(0x1234567890AbcdEF1234567890aBcdef12345678); // Default store address
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
        _transfer(msg.sender, _receiver, _amount);
    }

    function burnTokens(uint256 _value) external {
        require(balanceOf(msg.sender) >= _value, "You do not have enough Degen Tokens");
        _burn(msg.sender, _value);
    }    
    
    function redeemTokens(uint input) external returns (string memory) {
        TokenCards storage userCard = userCards[msg.sender];

        uint price;
        string memory item;
        if (input == 1) {
            price = 100 * 10**decimals();
            require(balanceOf(msg.sender) >= price, "You do not have enough tokens to redeem Item A");
            userCard.A++;
            item = "Item A";
        } else if (input == 2) {
            price = 200 * 10**decimals();
            require(balanceOf(msg.sender) >= price, "You do not have enough tokens to redeem Item B");
            userCard.B++;
            item = "Item B";
        } else if (input == 3) {
            price = 300 * 10**decimals();
            require(balanceOf(msg.sender) >= price, "You do not have enough tokens to redeem Item C");
            userCard.C++;
            item = "Item C";
        } else {
            return "Unknown token card";
        }
        
        _burn(msg.sender, price);
        require(storeAddress != address(0), "Store address is not set");

        emit TokensRedeemed(msg.sender, storeAddress, price, item);

        return "Tokens redeemed successfully";
    }

    function checkBalance(address account) external view returns (uint256) {
        return balanceOf(account);
    }
}

        
```

## Authors

TANU PAL
@Tanu


## License

This project is licensed under the [Metacrafters] License - see the LICENSE.md file for details
