// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

abstract contract ERC20Interface {
    function totalSupply() public view virtual returns (uint256 totalSupply);

    function balanceOf(address tokenOwner)
        public
        virtual
        returns (uint256 balance);

    function transfer(address to, uint256 tokens)
        public
        virtual
        returns (bool success);

    function transferFrom(
        address tokenOwner,
        address to,
        uint256 tokens
    ) public virtual returns (bool success);

    function approve(address spender, uint256 tokens)
        public
        virtual
        returns (bool success);

    function allowance(address tokenOwner, address spender)
        public
        virtual
        returns (uint256 remaining);

    event Transfer(address indexed from, address indexed to, uint256 tokens);
    event Approval(
        address indexed tokenOwner,
        address indexed spender,
        uint256 tokens
    );
}

contract BBO_Token is ERC20Interface {
    string public constant name = "BlackBoot Coin";
    string public constant symbol = "BBO";
    uint8 public constant decimals = 18;

    //mapping is a key-value data structure
    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;

    //This stores the number of tokens that are available in our contract.
    uint256 totalSupply_;

    //This method called when this contract deployed to network
    constructor(uint256 total) {
        totalSupply_ = total;
        balances[msg.sender] = totalSupply_;
    }

    function totalSupply() public view override returns (uint256) {
        return totalSupply_;
    }

    //Get the balance of an owner
    function balanceOf(address tokenOwner)
        public
        view
        override
        returns (uint256)
    {
        return balances[tokenOwner];
    }

    //transfer token to an account
    function transfer(address to, uint256 tokens)
        public
        override
        returns (bool)
    {
        require(tokens <= balances[msg.sender]);

        balances[msg.sender] -= tokens;
        balances[to] += tokens;

        emit Transfer(msg.sender, to, tokens);
        return true;
    }

    //This method allow to spender to transfer tokens just like (وکالت)
    function approve(address spender, uint256 tokens)
        public
        override
        returns (bool)
    {
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }

    //Get the allowance status of an account
    function allowance(address tokenOwner, address spender)
        public
        view
        override
        returns (uint256)
    {
        return allowed[tokenOwner][spender];
    }

    //Transfer tokens from an account to another account
    function transferFrom(
        address tokenOwner,
        address to,
        uint256 tokens
    ) public override returns (bool) {
        require(balances[tokenOwner] >= tokens);
        require(allowed[tokenOwner][msg.sender] >= tokens);

        balances[tokenOwner] -= tokens;
        allowed[tokenOwner][msg.sender] -= tokens;
        balances[to] += tokens;

        emit Transfer(tokenOwner, to, tokens);
        return true;
    }
}