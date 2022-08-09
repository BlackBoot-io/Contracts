require('dotenv').config();
const HDWalletProvider = require('@truffle/hdwallet-provider');

module.exports = {
  networks: {
    sokol: {
      provider: function () {
        if (!process.env.MNEMONIC) {
          console.error('SOKOL_MNEMONIC env variable is needed');
          process.abort();
        }
        return new HDWalletProvider(
          process.env.MNEMONIC,
          "https://sokol.poa.network"
        );
      },
      gas: 5000000,
      gasPrice: 5e9,
      network_id: "77",
    },
    goerli: {
      provider: () => {
        if (!process.env.MNEMONIC) {
          console.error('goerli_MNEMONIC env variable is needed');
          process.abort();
        }
        return new HDWalletProvider(process.env.MNEMONIC, 'https://goerli.infura.io/v3/' + process.env.INFURA_API_KEY)
      },
      network_id: "5",
      gas: 4465030,
      gasPrice: 10000000000,
    },
    xdai: {
      provider: function () {
        if (!process.env.MNEMONIC) {
          console.error('XDAI_MNEMONIC env variable is needed');
          process.abort();
        }
        return new HDWalletProvider(
          process.env.MNEMONIC,
          "https://dai.poa.network"
        );
      },
      gas: 5000000,
      gasPrice: 5e9,
      network_id: 100,
    },
  },

  compilers: {
    solc: {
      version: "0.8.15",
    }
  },
};
