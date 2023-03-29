require("@nomiclabs/hardhat-waffle");
require("@openzeppelin/hardhat-upgrades");
require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-etherscan");
require("dotenv").config();

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
    const accounts = await hre.ethers.getSigners();

    for (const account of accounts) {
        console.log(account.address);
    }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
    solidity: {
        compilers: [
            {
                version: "0.8.4",
                settings: {
                    optimizer: {
                        enabled: true,
                        runs: 5,
                    },
                },
            },
        ],
    },
    networks: {
        hardhat: {},
        // ropsten: {
        //     accounts: {
        //         mnemonic: process.env.TESTNET_MNEMONIC,
        //     },
        //     chainId: 3,
        //     url: "https://eth-ropsten.alchemyapi.io/v2/5DO6C_sQpiiY1Y40YBJR9E8gS-SpriCJ",
        // },
        //         "okt_testnet": {
        //     accounts:  [process.env.TESTNET_PRIVATE_KEY],
        //     chainId: 65,
        //     url: "https://exchaintestrpc.okex.org",
        // },

        // "AVAX_testnet": {
        //     accounts:  [process.env.TESTNET_PRIVATE_KEY],
        //     chainId: 43113,
        //     url: "https://api.avax-test.network/ext/bc/C/rpc",
        // },
        // "Moonbeam_testnet": {
        //     accounts:  [process.env.TESTNET_PRIVATE_KEY],
        //     chainId: 1287,
        //     url: "https://rpc.testnet.moonbeam.network",
        // },
        // "OP_testnet": {
        //     accounts:  [process.env.TESTNET_PRIVATE_KEY],
        //     chainId: 420,
        //     url: "https://goerli.optimism.io/",
        // },
        // bsc_testnet: {
        //     // accounts: 
        //     //     mnemonic: process.env.TESTNET_MNEMONIC,
        //     // },
        //     accounts: [process.env.TESTNET_PRIVATE_KEY],
        //     chainId: 97,
        //     url: "https://data-seed-prebsc-1-s1.binance.org:8545/",
        //     gas: 2100000,
        //     gasPrice: 10000000000
        // },
        // bsc: {
        //   accounts: [process.env.MAINNET_PRIVATE_KEY],
        //   chainId: 56,
        //   url: "https://bsc-dataseed.binance.org/",
        // },
        ETH_Goerli: {
            accounts:  [process.env.TESTNET_PRIVATE_KEY],
            chainId: 5,
            url: "https://rpc.ankr.com/eth_goerli",
        },
    },
    etherscan: {
        // Your API key for Etherscan
        // Obtain one at https://etherscan.io/
        apiKey: '9WJHP9AKPV4BCIMPUHJUIFRAU42GCBJUMX',
        // OKLinkPIKEY: "QMVD1SGWXCKTS63I9E69GKUVV41K41F2DU",
    },
};