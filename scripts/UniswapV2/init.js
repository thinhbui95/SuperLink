//const { getProxyAdminFactory } = require("@openzeppelin/hardhat-upgrades/dist/utils");
const hre = require("hardhat");
const Web3 = require("web3")
const Web3EthAbi = require('web3-eth-abi');


async function main() {

    const Swap = await hre.ethers.getContractFactory("Coin98UniswapV2");
    const swapuni = await Swap.attach("0x07274Ae23322862c59177396F07DC36b82B8296f");//Goerli
    // const swapuni = await Swap.attach("0xD448BbE015Cd829e2Ad0E7b31f84f55C359aECbf"); //BSC testnet
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
        fromToken:"0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6", //WETH
        toToken: "0x07865c6E87B9F70255377e024ace6630C1Eaa37F", //USDC
        targetExchange: "0xb81bab847DDE2432F4df794dD36039550f4e2cAA", //Pair WETH/USDC
        payload: "0x",
        //networkFee: 11,
    });

    // console.log(swapparam);


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
        // console.log(swapele1);

    

    var amount0Out  = Web3.utils.toWei('0.000001', 'ether');  
    var amount1Out  = Web3.utils.toWei('0.00000000000001', 'ether'); 
    var fromToken = "0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6" //WETH
    var toToken = "0x07865c6E87B9F70255377e024ace6630C1Eaa37F" //USDC
    // var to = "0xf8D6cBd7c3bee733C0AF70171DBFf21d932c99c2"
    // var executor = "0xf687EE6987e5C75E9c3b784Cc42791F9B70FC5b5";
    // await swapuni.swap(amount0Out, amount1Out, to, swapparam);
    // await swapuni.withdrawStuckERC20(fromToken);
    await swapuni.swap(amount0Out,amount1Out,swapparam);



    
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
//npx hardhat run scripts/ReferralBonus/init_data.js --network bsc-mainnet