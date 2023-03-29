//const { getProxyAdminFactory } = require("@openzeppelin/hardhat-upgrades/dist/utils");
const hre = require("hardhat");
const Web3 = require("web3")
const Web3EthAbi = require('web3-eth-abi');


async function main() {

    const DemoAdapter = await hre.ethers.getContractFactory("DemoAdapter1");
    const demoAdapter = await DemoAdapter.attach("0x4414F2b5D37F62D650ee50e9f57bC2C1f3ffc39e");//Goerli Testnet
    // const demoAdapter = await DemoAdapter.attach("0xfaeb77a09b435cb899e58bb3ed00bf9dc72d49db");//BSC Testnet
    
    var swapparam1 = Web3EthAbi.encodeParameter({
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
        fromToken:"0xA84C91E100a8B5AB94f6825adb0e767596A66b9E", //A
        toToken: "0x5b144894dfcc99F8F32372f31e310Cb7d9F54deF", //USDC
        targetExchange: "0xc506C040d9F1266c30BDC9560F582E95e4528E85", //Pair A/USDC
        payload: "0x",
        //networkFee: 11,
    });
   // console.log(swapparam1);
   var amountIn  = Web3.utils.toWei('200', 'ether');
   var amountOut  = Web3.utils.toWei('100', 'ether');

//    const encodeAmountIn1 = Web3EthAbi.encodeParameters(
//         ['uint256[]'],[[amountIn,amountIn]]
//     );
//     const encodeAmountOut1 = Web3EthAbi.encodeParameters(
//         ['uint256[]'],[[amountOut,amountOut]]
//     );
//     const encodeRouters1 = Web3EthAbi.encodeParameters(
//         ['uint256[]'],[[1,1]]
//     );
//     const encodePayload1 = Web3EthAbi.encodeParameters(
//         ['bytes[]'],[[swapparam1,swapparam1]]
//     );
    // var fromToken1 = "0xD67aC77AF1Aa020Ed3D169daB78Cf70aFe1f2498" //A
    const element1 = Web3EthAbi.encodeParameter({
        ElementSwap:{
            adapters :"address[]",
            amountIns :"uint256[]",
            amountOuts :"uint256[]",
            // fromToken: "address",
            payloads: "bytes[]",
        },
    },
    {
        adapters:["0x07274Ae23322862c59177396F07DC36b82B8296f"],
        amountIns:[amountIn],
        amountOuts:[amountOut],
        // fromToken: fromToken1,
        payloads: [swapparam1],
    });

    // const payload2 = Web3EthAbi.encodeParameter({
    //     CurveV2Data:{
    //         i:"uint256",
    //         j:"uint256",
    //         underlyingSwap: "bool",
    //     },
    // },
    // {
    //     i:0,
    //     j:1,
    //     underlyingSwap: 0,
    // });

    // const swapparam2 = Web3EthAbi.encodeParameter({
    //     SwapParam:{
    //         //index:"uint256",
    //         fromToken:"address",
    //         toToken:"address",
    //         targetExchange: "address",
    //         payload: "bytes",
    //         //networkFee: "uint256"
    //     },
    // },
    // {
    //     //index:1,
    //     fromToken:"0x5b144894dfcc99F8F32372f31e310Cb7d9F54deF", //USDC
    //     toToken: "0xb26b66a8eB78867Fa1cC57f6273Bb7E6a6708352", //BUSD
    //     targetExchange: "0xfF8Aa4033fD7AB63BeC8927D0a4a5B494aD2A7a8",  //StableSwap USDC/BUSD
    //     payload: payload2,
    //     //networkFee: 11,
    // });
    // var amountIn  = Web3.utils.toWei('100', 'ether');
    // var amountOut  = Web3.utils.toWei('0', 'ether');
    // // const encodeAmountIn2 = Web3EthAbi.encodeParameters(
    // //     ['uint256[]'],[[amountIn,amountIn,amountIn]]
    // // );
    // // const encodeAmountOut2 = Web3EthAbi.encodeParameters(
    // //     ['uint256[]'],[[amountOut,amountOut,amountOut]]
    // // );
    // // const encodeRouters2 = Web3EthAbi.encodeParameters(
    // //     ['uint256[]'],[[0,0,0]]
    // // );
    // // const encodePayload2 = Web3EthAbi.encodeParameters(
    // //     ['bytes[]'],[[swapparam2,swapparam2,swapparam2]]
    // // );
    // // var fromToken2 = "0xCA8eB2dec4Fe3a5abbFDc017dE48E461A936623D" //USDC
    // const element2 = Web3EthAbi.encodeParameter({
    //     ElementSwap:{
    //         adapters :"address[]",
    //         amountIns :"uint256[]",
    //         amountOuts :"uint256[]",
    //         // fromToken: "address",
    //         payloads: "bytes[]",
    //     },
    // },
    // {
    //     adapters:["0x2Ed211318C9740f30345C586414f25A41C2fFC4E"],
    //     amountIns:[amountIn],
    //     amountOuts:[amountOut],
    //     // fromToken: fromToken1,
    //     payloads: [swapparam2],
    // });

    const payload3 = Web3EthAbi.encodeParameter({
        BalancerDataV2 :{
            poolId :"bytes32",
            kind : "uint256",
            userData : "bytes",
            fromInternalBalance : "bool",
            toInternalBalance : "bool",
            limit : "uint256",
            deadline : "uint256"
        }
    },
    {
        poolId : "0x05a10321f859b6e0c89b01c27c2a8fdaaa7769a8000100000000000000000713",
        kind:0,
        userData: "0x",
        fromInternalBalance : "",
        toInternalBalance : "",
        limit : 0,
        deadline : 99999999999
    });

    const swapparam3 = Web3EthAbi.encodeParameter({
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
        fromToken:"0x5b144894dfcc99F8F32372f31e310Cb7d9F54deF", //USDC 
        toToken: "0x05a4e4F59B4779fC3FB4959a3CFC4FA8d248Edc2", //USDT
        targetExchange: "0xba12222222228d8ba445958a75a0704d566bf2c8",  // Vaut BalancerV2
        payload: payload3,
        //networkFee: 11,
    });
    var amountIn  = Web3.utils.toWei('100', 'ether');
    var amountOut  = Web3.utils.toWei('0', 'ether');
    // const encodeAmountIn2 = Web3EthAbi.encodeParameters(
    //     ['uint256[]'],[[amountIn,amountIn,amountIn]]
    // );
    // const encodeAmountOut2 = Web3EthAbi.encodeParameters(
    //     ['uint256[]'],[[amountOut,amountOut,amountOut]]
    // );
    // const encodeRouters2 = Web3EthAbi.encodeParameters(
    //     ['uint256[]'],[[0,0,0]]
    // );
    // const encodePayload2 = Web3EthAbi.encodeParameters(
    //     ['bytes[]'],[[swapparam2,swapparam2,swapparam2]]
    // );
    // var fromToken2 = "0xCA8eB2dec4Fe3a5abbFDc017dE48E461A936623D" //USDC
    const element3 = Web3EthAbi.encodeParameter({
        ElementSwap:{
            adapters :"address[]",
            amountIns :"uint256[]",
            amountOuts :"uint256[]",
            // fromToken: "address",
            payloads: "bytes[]",
        },
    },
    {
        adapters:["0x809049174A9825a451D45163608365323a9d6Bfc"],
        amountIns:[amountIn],
        amountOuts:[amountOut],
        // fromToken: fromToken1,
        payloads: [swapparam3],
    });


    const chain1 =  Web3EthAbi.encodeParameters(
        ['bytes[]'],[[element1,element3]]
    );

    const total = Web3EthAbi.encodeParameters(
        ['bytes[]'],[[chain1]]
    );
    // console.log(total);
    //const dataChain1 = Web3EthAbi.decodeParameters(['bytes[]'],total)[0];

    var fromToAmount  = [Web3.utils.toWei('200', 'ether'),0];  
    var fromToken = "0xA84C91E100a8B5AB94f6825adb0e767596A66b9E"; //A
    // var fromToken =    "0x5b144894dfcc99F8F32372f31e310Cb7d9F54deF"; //USDC
    var toToken =  "0x05a4e4F59B4779fC3FB4959a3CFC4FA8d248Edc2" //USDT
    var data = total;
    // var executor = "0x49A78c310652799B2710B40b046DED213981Ecef"; //BSC Testnet
    var executor = "0x15441E21f4E862Aa61b1eeE97FDd00670C915e96"; //Goerli Testnet

    //var payloads = [swapparam2,swapparam1];
    var routers = ["0x2DD4Aa80b9197FdfFF4F15b6a1a35633437cd398","0xD448BbE015Cd829e2Ad0E7b31f84f55C359aECbf"];
    var amountOut = [0,Web3.utils.toWei('50', 'ether')]
    await demoAdapter.swapRoutes(fromToAmount, fromToken, toToken, data, executor);
    // await demoAdapter.swapStraight(fromToAmount,fromToken,toToken,routers,payloads,amountOut);
    // var ow = await demoAdapter.owner();
    // console.log(ow)


    
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
//npx hardhat run scripts/ReferralBonus/init_data.js --network bsc-mainnet