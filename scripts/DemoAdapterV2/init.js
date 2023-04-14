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
        fromToken:  "0x5b144894dfcc99F8F32372f31e310Cb7d9F54deF", //USDC 
        toToken: "0xA84C91E100a8B5AB94f6825adb0e767596A66b9E", //A
        targetExchange: "0xc506C040d9F1266c30BDC9560F582E95e4528E85", //Pair A/USDC
        payload: "0x",
        //networkFee: 11,
    });
   // console.log(swapparam1);
   var amountIn  = Web3.utils.toWei('10', 'ether');
   var amountOut  = Web3.utils.toWei('5', 'ether');

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


 // Swap 2 //Kyber
    var payload2 = Web3EthAbi.encodeParameter({
        KyberSwapClassicStaticData:{
            to: "address",
            data:"bytes",
        },
    },
    {
        to:"0xCfb07cf20d338474deA4073439592792786e2b91",
        data:"0x",
    });
   var swapparam2 = Web3EthAbi.encodeParameter({
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
    fromToken: "0xA84C91E100a8B5AB94f6825adb0e767596A66b9E", //A
    toToken: "0x5b144894dfcc99F8F32372f31e310Cb7d9F54deF", //USDC
    targetExchange: "0x757644fF8A9bB5358Ab7A156B4BC4204ae187C0A", // Pair USDC/A
    payload: payload2,
    //networkFee: 11,
});
// console.log(swapparam1);
    var amountIn  = Web3.utils.toWei('5', 'ether');
    var amountOut  = Web3.utils.toWei('5', 'ether');

    var element2 = Web3EthAbi.encodeParameter({
    ElementSwap:{
        adapters :"address[]",
        amountIns :"uint256[]",
        amountOuts :"uint256[]",
        // fromToken: "address",
        payloads: "bytes[]",
    },
},
{
    adapters:["0xFd85d3B650da2F698304964E84314F59681C9134"], //Adapter Kyber
    amountIns:[amountIn],
    amountOuts:[amountOut],
    // fromToken: fromToken1,
    payloads: [swapparam2],
});


// Swap 3
var payload3 = Web3EthAbi.encodeParameter({
    UniswapV3Data:{
        fee: "uint256",
        deadline:"uint256",
        sqrtPriceLimitX96:"uint256",
    },
},
{
    fee:500,
    deadline:9999999999,
    sqrtPriceLimitX96:0
});
var swapparam3 = Web3EthAbi.encodeParameter({
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
    fromToken: "0xA84C91E100a8B5AB94f6825adb0e767596A66b9E", //A
    toToken: "0x5b144894dfcc99F8F32372f31e310Cb7d9F54deF", //USDC
    targetExchange: "0xE592427A0AEce92De3Edee1F18E0157C05861564", //Router
    payload: payload3,
    //networkFee: 11,
    });
// console.log(swapparam1);
var amountIn  = Web3.utils.toWei('100', 'ether');
var amountOut  = Web3.utils.toWei('0', 'ether');

var element3 = Web3EthAbi.encodeParameter({
ElementSwap:{
    adapters :"address[]",
    amountIns :"uint256[]",
    amountOuts :"uint256[]",
    // fromToken: "address",
    payloads: "bytes[]",
    },
},
{
    adapters:["0x0C37cBc30EB246056D48537de97047D18be3Bdf7"], //Adapter UniV3
    amountIns:[amountIn],
    amountOuts:[amountOut],
    // fromToken: fromToken1,
    payloads: [swapparam3],
});

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

    var payload4 = Web3EthAbi.encodeParameter({
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

    const swapparam4 = Web3EthAbi.encodeParameter({
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
        payload: payload4,
        //networkFee: 11,
    });
    var amountIn  = Web3.utils.toWei('5', 'ether');
    var amountOut  = Web3.utils.toWei('0', 'ether');

    const element4 = Web3EthAbi.encodeParameter({
        ElementSwap:{
            adapters :"address[]",
            amountIns :"uint256[]",
            amountOuts :"uint256[]",
            // fromToken: "address",
            payloads: "bytes[]",
        },
    },
    {
        adapters:["0x8cfe82eEAeA8bDc75C2570803dD50A9AE959330a"],
        amountIns:[amountIn],
        amountOuts:[amountOut],
        // fromToken: fromToken1,
        payloads: [swapparam4],
    });

    //DodoV2
    var payload5 = Web3EthAbi.encodeParameter({
        SwapDoDoV2 :{
            dodoPairs :"address[]",
            directions : "uint256",
            dodoErc20Approve : "address",
            dodoV2SwapLimitOverhead : "uint256",
        }
    },
    {
        dodoPairs : ["0xcc33d346De4A7c3b1E0F8a6047200F2D6bdA9138"],
        directions:0,
        dodoErc20Approve: "0xC9143e54021f4a6d33b9b89DBB9F458AaEdd56FB",
        dodoV2SwapLimitOverhead : 99999999999,
    });
    const swapparam5 = Web3EthAbi.encodeParameter({
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
        fromToken:"0x05a4e4F59B4779fC3FB4959a3CFC4FA8d248Edc2", //USDT
        toToken: "0xb26b66a8eB78867Fa1cC57f6273Bb7E6a6708352", //BUSD
        targetExchange: "0xbce44767af0a53a108b3b7ba4f740e03d228ec0a",  // Adapter Proxy Dodo
        payload: payload5,
        //networkFee: 11,
    });
    var amountIn  = Web3.utils.toWei('2', 'ether');
    var amountOut  = Web3.utils.toWei('0', 'ether');

    const element5 = Web3EthAbi.encodeParameter({
        ElementSwap:{
            adapters :"address[]",
            amountIns :"uint256[]",
            amountOuts :"uint256[]",
            // fromToken: "address",
            payloads: "bytes[]",
        },
    },
    {
        adapters:["0x32493e030836Ee4F118C1f5Ec87C78d40aE4D11d"], //Adapter Dodo
        amountIns:[amountIn],
        amountOuts:[amountOut],
        // fromToken: fromToken1,
        payloads: [swapparam5],
    });

        //Maverick
        var payload6 = Web3EthAbi.encodeParameter({
            MaverickData :{
                pool :"address",
                deadline : "uint256",
            }
        },
        {
            pool : "0x24e063B8F0f09440500DCFD78C68D16ceB3Fe2Ff", // Pair WETH/USDC
            deadline:99999999999,

        });
        const swapparam6 = Web3EthAbi.encodeParameter({
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
            toToken: "0xEEa85fdf0b05D1E0107A61b4b4DB1f345854B952", //USDC Test
            targetExchange: "0x612e39c3564094cf799e8ffac96eb1a913e2acf9",  // Router
            payload: payload6,
            //networkFee: 11,
        });
        var amountIn  = Web3.utils.toWei('0.00000001', 'ether');
        var amountOut  = Web3.utils.toWei('0', 'ether');
    
        const element6 = Web3EthAbi.encodeParameter({
            ElementSwap:{
                adapters :"address[]",
                amountIns :"uint256[]",
                amountOuts :"uint256[]",
                // fromToken: "address",
                payloads: "bytes[]",
            },
        },
        {
            adapters:["0x80E713834bff9fC644F9B8BacE3907643FFdB69C"], //Adapter Maverick
            amountIns:[amountIn],
            amountOuts:[amountOut],
            // fromToken: fromToken1,
            payloads: [swapparam6],
        });


    const chain1 =  Web3EthAbi.encodeParameters(
        ['bytes[]'],[[element6]]
    );

    const total = Web3EthAbi.encodeParameters(
        ['bytes[]'],[[chain1]]
    );
    // console.log(total);
    //const dataChain1 = Web3EthAbi.decodeParameters(['bytes[]'],total)[0];

    var fromToAmount  = [Web3.utils.toWei('0.00000001', 'ether'),0];  
    // var fromToken = "0x05a4e4F59B4779fC3FB4959a3CFC4FA8d248Edc2"; //USDT
    var fromToken =    "0x0000000000000000000000000000000000000000"; //ETH
    var toToken =  "0xEEa85fdf0b05D1E0107A61b4b4DB1f345854B952"; //USDC Test
    var data = total;
    // var executor = "0x49A78c310652799B2710B40b046DED213981Ecef"; //BSC Testnet
    var executor = "0xCfb07cf20d338474deA4073439592792786e2b91"; //Goerli Testnet

    //var payloads = [swapparam2,swapparam1];
    var routers = ["0x2DD4Aa80b9197FdfFF4F15b6a1a35633437cd398","0xD448BbE015Cd829e2Ad0E7b31f84f55C359aECbf"];
    var amountOut = [0,Web3.utils.toWei('50', 'ether')]
    await demoAdapter.swapRoutes(fromToAmount, fromToken, toToken, data, executor,{value: fromToAmount[0]});
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