//const { getProxyAdminFactory } = require("@openzeppelin/hardhat-upgrades/dist/utils");
const hre = require("hardhat");
const Web3 = require("web3")
const Web3EthAbi = require('web3-eth-abi');


async function main() {

    const DemoAdapter = await hre.ethers.getContractFactory("DemoAdapter1");
    const demoAdapter = await DemoAdapter.attach("0xfaeb77a09b435cb899e58bb3ed00bf9dc72d49db");//BSC Testnet
    
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
        fromToken:"0xD67aC77AF1Aa020Ed3D169daB78Cf70aFe1f2498", //A
        toToken: "0xCA8eB2dec4Fe3a5abbFDc017dE48E461A936623D", //USDC
        targetExchange: "0x41E0f861EF8eCdb4d45aCf69e0f9B8ec8600c2e4", //Pair A/USDC
        payload: "0x",
        //networkFee: 11,
    });
   // console.log(swapparam1);
   var amountIn  = Web3.utils.toWei('100', 'ether');
   var amountOut  = Web3.utils.toWei('50', 'ether');

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
            adapters :"uint256[]",
            amountIns :"uint256[]",
            amountOuts :"uint256[]",
            // fromToken: "address",
            payloads: "bytes[]",
        },
    },
    {
        adapters:[1,1],
        amountIns:[amountIn,amountIn],
        amountOuts:[amountOut,amountOut],
        // fromToken: fromToken1,
        payloads: [swapparam1,swapparam1],
    });

    const payload2 = Web3EthAbi.encodeParameter({
        CurveV2Data:{
            i:"uint256",
            j:"uint256",
            underlyingSwap: "bool",
        },
    },
    {
        i:1,
        j:0,
        underlyingSwap: 0,
    });

    const swapparam2 = Web3EthAbi.encodeParameter({
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
        fromToken:"0xCA8eB2dec4Fe3a5abbFDc017dE48E461A936623D", //USDC
        toToken: "0x3304dd20f6Fe094Cb0134a6c8ae07EcE26c7b6A7", //BUSD
        targetExchange: "0xd5E56CD4c8111643a94Ee084df31F44055a1EC9F",  //StableSwap USDC/BUSD
        payload: payload2,
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
    const element2 = Web3EthAbi.encodeParameter({
        ElementSwap:{
            adapters :"uint256[]",
            amountIns :"uint256[]",
            amountOuts :"uint256[]",
            // fromToken: "address",
            payloads: "bytes[]",
        },
    },
    {
        adapters:[0],
        amountIns:[amountIn],
        amountOuts:[amountOut],
        // fromToken: fromToken1,
        payloads: [swapparam2],
    });

    const chain1 =  Web3EthAbi.encodeParameters(
        ['bytes[]'],[[element1,element2]]
    );

    const total = Web3EthAbi.encodeParameters(
        ['bytes[]'],[[chain1,chain1,chain1]]
    );
    // console.log(total);
    //const dataChain1 = Web3EthAbi.decodeParameters(['bytes[]'],total)[0];

    var fromToAmount  = [Web3.utils.toWei('600', 'ether'),0];  
    // var fromToken = "0xD67aC77AF1Aa020Ed3D169daB78Cf70aFe1f2498"; //A
    var fromToken =  "0xD67aC77AF1Aa020Ed3D169daB78Cf70aFe1f2498"; //A
    var toToken =  "0x3304dd20f6Fe094Cb0134a6c8ae07EcE26c7b6A7" //BUSD 
    var data = total;
    var executor = "0xc97B3BC075a1CC41264Ed8B94227C8595ae11274";
    var payloads = [swapparam2,swapparam1];
    var routers = ["0x2DD4Aa80b9197FdfFF4F15b6a1a35633437cd398","0xD448BbE015Cd829e2Ad0E7b31f84f55C359aECbf"];
    var amountOut = [0,Web3.utils.toWei('50', 'ether')]
    await demoAdapter.swapRoutes(fromToAmount, fromToken, toToken, data, executor);
    // await demoAdapter.swapStraight(fromToAmount,fromToken,toToken,routers,payloads,amountOut);


    
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
//npx hardhat run scripts/ReferralBonus/init_data.js --network bsc-mainnet