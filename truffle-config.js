const HDWalletProvider = require('@truffle/hdwallet-provider');
const privateKey = '';
const mainnetEndpointUrl = 'https://mainnet.infura.io/v3/9e4cfe82e43c48e2afc547c40145dab8';

module.exports = {
    networks: {
        mainnet: {
            provider: function() {
                return new HDWalletProvider({
                    privateKeys: [privateKey],
                    provider: mainnetEndpointUrl
                });
            },
            gas: 2000000,
            gasPrice: 130000000000,
            network_id: 1
        }
    },
    compilers: {
        solc: {
            version: '0.6.12',
            settings: {
                optimizer: {
                    enabled: true,
                    runs: 10000
                }
            }
        }
    },
    plugins: ['solidity-coverage'],

};
