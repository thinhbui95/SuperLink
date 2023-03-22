const Web3 = require("web3");
const Web3EthAbi = require('web3-eth-abi');


async function main() {

//     const payload1 = Web3EthAbi.encodeParameter({
//         CurveV2Data:{
//             i:"uint256",
//             j:"uint256",
//             underlyingSwap: "bool",
//         },
//     },
//     {
//         i:1,
//         j:1,
//         underlyingSwap: 1,
//     });

  

//     const swapparam1 = Web3EthAbi.encodeParameter({
//         SwapParam:{
//             //index:"uint256",
//             fromToken:"address",
//             toToken:"address",
//             targetExchange: "address",
//             payload: "bytes",
//             //networkFee: "uint256"
//         },
//     },
//     {
//         //index:1,
//         fromToken:"0x5B38Da6a701c568545dCfcB03FcB875f56beddC4",
//         toToken: "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4",
//         targetExchange: "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4",
//         payload: payload1,
//         //networkFee: 11,
//     });
//    // console.log(swapparam1);

//     const payload2 = Web3EthAbi.encodeParameter({
//         CurveV2Data:{
//             i:"uint256",
//             j:"uint256",
//             underlyingSwap: "bool",
//         },
//     },
//     {
//         i:12,
//         j:1,
//         underlyingSwap: 0,
//     });

  

//     const swapparam2 = Web3EthAbi.encodeParameter({
//         SwapParam:{
//             //index:"uint256",
//             fromToken:"address",
//             toToken:"address",
//             targetExchange: "address",
//             payload: "bytes",
//             //networkFee: "uint256"
//         },
//     },
//     {
//         //index:2,
//         fromToken:"0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB",
//         toToken: "0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB",
//         targetExchange: "0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB",
//         payload: payload2,
//         //networkFee: 13,
//     });
//     //console.log(swapparam2);

//     const encodeAmountIn1 = Web3EthAbi.encodeParameters(
//         ['uint256[]'],[['11','22']]
//     );
//     const encodeAmountOut1 = Web3EthAbi.encodeParameters(
//         ['uint256[]'],[['111','22']]
//     );
//     const encodeRouters1 = Web3EthAbi.encodeParameters(
//         ['address[]'],[["0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c","0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c"]]
//     );
//     const encodePayload1 = Web3EthAbi.encodeParameters(
//         ['bytes[]'],[[swapparam1,swapparam2]]
//     );
//     var fromToken1 = "0x583031D1113aD414F02576BD6afaBfb302140225";
//     const element1 = Web3EthAbi.encodeParameter({
//         ElementSwap:{
//             encodeRouters :"bytes",
//             encodeAmountIn :"bytes",
//             encodeAmountOut :"bytes",
//             fromToken: "address",
//             encodePayload: "bytes",
//         },
//     },
//     {
//         encodeRouters:encodeRouters1,
//         encodeAmountIn:encodeAmountIn1,
//         encodeAmountOut:encodeAmountOut1,
//         fromToken: fromToken1,
//         encodePayload: encodePayload1,
//     });

//     //console.log("element1: ",element1);
    



//     const payload3 = Web3EthAbi.encodeParameter({
//         CurveV2Data:{
//             i:"uint256",
//             j:"uint256",
//             underlyingSwap: "bool",
//         },
//     },
//     {
//         i:14,
//         j:15,
//         underlyingSwap: 1,
//     });

  

//     const swapparam3 = Web3EthAbi.encodeParameter({
//         SwapParam:{
//             //index:"uint256",
//             fromToken:"address",
//             toToken:"address",
//             targetExchange: "address",
//             payload: "bytes",
//             //networkFee: "uint256"
//         },
//     },
//     {
//         //index:1,
//         fromToken:"0x1aE0EA34a72D944a8C7603FfB3eC30a6669E454C",
//         toToken: "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4",
//         targetExchange: "0x1aE0EA34a72D944a8C7603FfB3eC30a6669E454C",
//         payload: payload3,
//         //networkFee: 111,
//     });
//    // console.log(swapparam1);

  



//     const encodeAmountIn2 = Web3EthAbi.encodeParameters(
//         ['uint256[]'],[['111']]
//     );
//     const encodeAmountOut2 = Web3EthAbi.encodeParameters(
//         ['uint256[]'],[['1111']]
//     );
//     const encodeRouters2 = Web3EthAbi.encodeParameters(
//         ['address[]'],[["0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c"]]
//     );
//     const encodePayload2 = Web3EthAbi.encodeParameters(
//         ['bytes[]'],[[swapparam3]]
//     );
//     var fromToken2 = "0x583031D1113aD414F02576BD6afaBfb302140225";
//     const element2 = Web3EthAbi.encodeParameter({
//         ElementSwap:{
//             encodeRouters :"bytes",
//             encodeAmountIn :"bytes",
//             fromToken: "address",
//             encodePayload: "bytes",
//         },
//     },
//     {
//         encodeRouters:encodeRouters2,
//         encodeAmountIn:encodeAmountIn2,
//         encodeAmountOut:encodeAmountOut2,
//         fromToken: fromToken2,
//         encodePayload: encodePayload2,
//     });
//     //console.log(Adapter3)
//     const chain1 =  Web3EthAbi.encodeParameters(
//         ['bytes[]'],[[element1,element2]]
//     );
//     //console.log(chain1);




//     const payload4 = Web3EthAbi.encodeParameter({
//         CurveV2Data:{
//             i:"uint256",
//             j:"uint256",
//             underlyingSwap: "bool",
//         },
//     },
//     {
//         i:111,
//         j:1222,
//         underlyingSwap: 1,
//     });

  

//     const swapparam4 = Web3EthAbi.encodeParameter({
//         SwapParam:{
//             //index:"uint256",
//             fromToken:"address",
//             toToken:"address",
//             targetExchange: "address",
//             payload: "bytes",
//             //networkFee: "uint256"
//         },
//     },
//     {
//         //index:1,
//         fromToken:"0x5B38Da6a701c568545dCfcB03FcB875f56beddC4",
//         toToken: "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4",
//         targetExchange: "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4",
//         payload: payload4,
//         //networkFee: 1111,
//     });
//    // console.log(swapparam1);

//     const payload5 = Web3EthAbi.encodeParameter({
//         CurveV2Data:{
//             i:"uint256",
//             j:"uint256",
//             underlyingSwap: "bool",
//         },
//     },
//     {
//         i:12222,
//         j:13,
//         underlyingSwap: 0,
//     });

  

//     const swapparam5 = Web3EthAbi.encodeParameter({
//         SwapParam:{
//             //index:"uint256",
//             fromToken:"address",
//             toToken:"address",
//             targetExchange: "address",
//             payload: "bytes",
//             //networkFee: "uint256"
//         },
//     },
//     {
//         //index:2,
//         fromToken:"0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB",
//         toToken: "0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB",
//         targetExchange: "0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB",
//         payload: payload5,
//         //networkFee: 13,
//     });
//     //console.log(swapparam2);

//     const encodeAmountIn3 = Web3EthAbi.encodeParameters(
//         ['uint256[]'],[['11','22']]
//     );
//     const encodeAmountOut3 = Web3EthAbi.encodeParameters(
//         ['uint256[]'],[['11','22']]
//     );
//     const encodeRouters3 = Web3EthAbi.encodeParameters(
//         ['address[]'],[["0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c","0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c"]]
//     );
//     const encodePayload3 = Web3EthAbi.encodeParameters(
//         ['bytes[]'],[[swapparam4,swapparam5]]
//     );
//     var fromToken3 = "0x583031D1113aD414F02576BD6afaBfb302140225";
//     const element3 = Web3EthAbi.encodeParameter({
//         ElementSwap:{
//             encodeRouters :"bytes",
//             encodeAmountIn :"bytes",
//             encodeAmountOut :"bytes",
//             fromToken: "address",
//             encodePayload: "bytes",
//         },
//     },
//     {
//         encodeRouters:encodeRouters3,
//         encodeAmountIn:encodeAmountIn3,
//         encodeAmountOut:encodeAmountOut3,
//         fromToken: fromToken3,
//         encodePayload: encodePayload3,
//     });
    



//     const payload6 = Web3EthAbi.encodeParameter({
//         CurveV2Data:{
//             i:"uint256",
//             j:"uint256",
//             underlyingSwap: "bool",
//         },
//     },
//     {
//         i:141,
//         j:15,
//         underlyingSwap: 1,
//     });

  

//     const swapparam6 = Web3EthAbi.encodeParameter({
//         SwapParam:{
//             //index:"uint256",
//             fromToken:"address",
//             toToken:"address",
//             targetExchange: "address",
//             payload: "bytes",
//             //networkFee: "uint256"
//         },
//     },
//     {
//         //index:1,
//         fromToken:"0x1aE0EA34a72D944a8C7603FfB3eC30a6669E454C",
//         toToken: "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4",
//         targetExchange: "0x1aE0EA34a72D944a8C7603FfB3eC30a6669E454C",
//         payload: payload6,
//         //networkFee: 111,
//     });
//    // console.log(swapparam1);

  



//     const encodeAmountIn4 = Web3EthAbi.encodeParameters(
//         ['uint256[]'],[['111']]
//     );
//     const encodeAmountOut4 = Web3EthAbi.encodeParameters(
//         ['uint256[]'],[['111']]
//     );
//     const encodeRouters4 = Web3EthAbi.encodeParameters(
//         ['address[]'],[["0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c"]]
//     );
//     const encodePayload4 = Web3EthAbi.encodeParameters(
//         ['bytes[]'],[[swapparam6]]
//     );
//     var fromToken4 = "0x583031D1113aD414F02576BD6afaBfb302140225";
//     const element4 = Web3EthAbi.encodeParameter({
//         ElementSwap:{
//             encodeRouters :"bytes",
//             encodeAmountIn :"bytes",
//             fromToken: "address",
//             encodePayload: "bytes",
//         },
//     },
//     {
//         encodeRouters:encodeRouters4,
//         encodeAmountIn:encodeAmountIn4,
//         encodeAmountOut:encodeAmountOut4,
//         fromToken: fromToken4,
//         encodePayload: encodePayload4,
//     });
//     //console.log(Adapter3)
//     const chain2 =  Web3EthAbi.encodeParameters(
//         ['bytes[]'],[[element3]]
//     );
//     //console.log(chain2);

//     const total = Web3EthAbi.encodeParameters(
//         ['bytes[]'],[[chain1,chain2]]
//     );
//     console.log(total)
//     const dataChain1 = Web3EthAbi.decodeParameters(['bytes[]'],total)[0][1];
//     const adaptor1 = Web3EthAbi.decodeParameters(['bytes[]'],dataChain1)[0][0];
//     const ele1 = Web3EthAbi.decodeParameter(
//         {        
//             "ElementSwap":{
//                 "encodeRouters" :"bytes",
//                 "encodeAmountIn" :"bytes",
//                 "encodeAmountOut" :"bytes",
//                 "fromToken": "address",
//                 "encodePayload": "bytes",
//             },
//         },adaptor1);

//     //console.log( ele1);

//     const payloadele1 = Web3EthAbi.decodeParameters(['bytes[]'],ele1.encodePayload)[0][1];
//     //console.log(payloadele1);
//     const swapele1 = Web3EthAbi.decodeParameter(
//         {        
//             "SwapParam":{
//                 //"index":"uint256",
//                 "fromToken":"address",
//                 "toToken":"address",
//                 "targetExchange": "address",
//                 "payload": "bytes",
//                 //"networkFee": "uint256"
//             },
//         },payloadele1);
//     //     //console.log(swapele1);

//     //     // const amountIn = Web3EthAbi.decodeParameters(['uint256[]'],ele1.encodeAmountIn);
//     //     // console.log(amountIn)

//         const curve = Web3EthAbi.decodeParameter(
//             {        
//                 "CurveV2Data:":{
//                     "i":"uint256",
//                     "j":"int256",
//                     "underlyingSwap":"bool"
      
//             },
//         },swapele1.payload);
//         console.log(curve);


    var payload = Web3EthAbi.encodeParameter({
                BalancerV2:{
                    poolId:"bytes32",
                    kind:"uint256",
                    userData: "bytes",
                    fromInternalBalance: "bool",
                    toInternalBalance: "bool",
                    limit: "uint256",
                    deadline: "uint256"
                },
            },
            {
                poolId:"0x148ce9b50be946a96e94a4f5479b771bab9b1c59000100000000000000000054",
                kind:1,
                userData: "0x",
                fromInternalBalance: 0,
                toInternalBalance: 0,
                limit: 1234,
                deadline: 1234
            });

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
                    fromToken:"0x1aE0EA34a72D944a8C7603FfB3eC30a6669E454C",
                    toToken: "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4",
                    targetExchange: "0x1aE0EA34a72D944a8C7603FfB3eC30a6669E454C",
                    payload: payload,
                    //networkFee: 111,
            });

            const encodeAmountIn = Web3EthAbi.encodeParameters(
                ['uint256[]'],[['111']]
            );
            const encodeAmountOut = Web3EthAbi.encodeParameters(
                ['uint256[]'],[['1111']]
            );
            const encodeRouters = Web3EthAbi.encodeParameters(
                ['address[]'],[["0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c"]]
            );
            const encodePayload = Web3EthAbi.encodeParameters(
                ['bytes[]'],[[swapparam]]
            );

            var fromToken = "0x583031D1113aD414F02576BD6afaBfb302140225";
            const element = Web3EthAbi.encodeParameter({
            ElementSwap:{
                encodeRouters :"bytes",
                encodeAmountIn :"bytes",
                encodeAmountOut: "bytes",
                fromToken: "address",
                encodePayload: "bytes",
            },
            },
        {
            encodeRouters:encodeRouters,
            encodeAmountIn:encodeAmountIn,
            encodeAmountOut:encodeAmountOut,
            fromToken: fromToken,
            encodePayload: encodePayload,
        });

        const chain =  Web3EthAbi.encodeParameters(
            ['bytes[]'],[[element]]
        );
            //console.log(chain2);
            
        const total = Web3EthAbi.encodeParameters(
            ['bytes[]'],[[chain]]
        );
            console.log(total)
        const dataChain1 = Web3EthAbi.decodeParameters(['bytes[]'],total)[0][0];
        // console.log(dataChain1)
        const adaptor1 = Web3EthAbi.decodeParameters(['bytes[]'],dataChain1)[0][0];
        // console.log(adaptor1);
        const ele1 = Web3EthAbi.decodeParameter(
                    {        
                        "ElementSwap":{
                            "encodeRouters" :"bytes",
                            "encodeAmountIn" :"bytes",
                            "encodeAmountOut" :"bytes",
                            "fromToken": "address",
                            "encodePayload": "bytes",
                        },
                    },adaptor1);
            
        // console.log( ele1.encodePayload);
        const payloadele1 = Web3EthAbi.decodeParameters(['bytes[]'],ele1.encodePayload)[0][0];
        // console.log(payloadele1);
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
                    },payloadele1);
            // console.log(swapele1);

            const balancerv2 = Web3EthAbi.decodeParameter(
                            {        
                                "BalancerV2":{
                                    "poolId":"bytes32",
                                    "kind":"uint256",
                                    "userData": "bytes",
                                    "fromInternalBalance": "bool",
                                    "toInternalBalance": "bool",
                                    "limit": "uint256",
                                    "deadline": "uint256"
                                },
                        },swapele1.payload);
                // console.log(balancerv2);
                
                
        
        


        






    }



main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
