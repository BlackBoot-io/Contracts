## Setup

Install dependencies:
    
    nvm use # Should install node 10.16.0
    npm install truffle
    npm install


### Truffle Commands

To run a console:

    npx truffle deploy --network goerli

To run tests:

    npx truffle test

## Useful Commands

### Working with ZeppelinOS

#### Session

Start by creating a session:

```bash
npx zos session --network 
```

This creates a "connection" that will be used for every zos command. We define which network to connect, which account to use by default
for all transaction and when it expires (3600 seconds after last used).

If no current session exists, or it its expired we need to create one.

#### Create or Upgrade Contracts

When we create a new contract run:

    npx zos add MyContract

To upgrade a current contract (change the code of it)

    npx zos update MyContract

After any change we need to **push** the changes:

    npx zos push

`add` and `update` only change the contract instance, but they don't actually release/create an instance of that contract.
To create an instance we do:

    npz zos create MyContract --init initialize --args 42,hitchhiker

### Contract addresses ###
#### Testnet ####
* Goerli: [0x63626Bec98043FCf1410083a590ac272a1C35d48](https://goerli.etherscan.io/address/0x63626bec98043fcf1410083a590ac272a1c35d48/transactions)

