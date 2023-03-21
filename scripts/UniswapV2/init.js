//const { getProxyAdminFactory } = require("@openzeppelin/hardhat-upgrades/dist/utils");
const hre = require("hardhat");
const Web3 = require("web3")
const Web3EthAbi = require('web3-eth-abi');


async function main() {

    const Swap = await hre.ethers.getContractFactory("Coin98UniswapV2");
    // const swapuni = await Swap.attach("0xd58B8c478aCaFe6059d1d927f87526ED8535e798");//Goerli
    const swapuni = await Swap.attach("0xD448BbE015Cd829e2Ad0E7b31f84f55C359aECbf"); //BSC testnet
    const swapparam = Web3EthAbi.encodeParameter({
        SwapParam:{
            //index:"uint256",
            fromToken:"address",
            toToken:"address",
            targetExchange: "address",
            payload: "bytes",
            //networkFee: "uint256"
        },
    },
    {
        //index:1,
        fromToken:"0x06cB12Ec2CACA47C83FF83cDD353029B465dB5bd",
        toToken: "0x5305C4935ea9ED29C97C966F99bffF3c783eF9Fa",
        targetExchange: "0xF9097cb4408Cb5FDCcb00b5d9a2839a64b6b2351",
        payload: "0x",
        //networkFee: 11,
    });

    console.log(swapparam);


    const swapele1 = Web3EthAbi.decodeParameter(
        {        
            "SwapParam":{
                //"index":"uint256",
                "fromToken":"address",
                "toToken":"address",
                "targetExchange": "address",
                "payload": "bytes",
                //"networkFee": "uint256"
            },
        },swapparam);
        console.log(swapele1);

    

    var amount0Out  = Web3.utils.toWei('100', 'ether');  
    var amount1Out  = Web3.utils.toWei('25', 'ether'); 
    var fromToken = "0x06cB12Ec2CACA47C83FF83cDD353029B465dB5bd";
    var toToken = "0x5305C4935ea9ED29C97C966F99bffF3c783eF9Fa";
    var to = "0xf8D6cBd7c3bee733C0AF70171DBFf21d932c99c2"
    var executor = "0xf687EE6987e5C75E9c3b784Cc42791F9B70FC5b5";
    await swapuni.swap(amount0Out, amount1Out, to, swapparam);


    
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
//npx hardhat run scripts/ReferralBonus/init_data.js --network bsc-mainnet