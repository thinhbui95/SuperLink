//const { getProxyAdminFactory } = require("@openzeppelin/hardhat-upgrades/dist/utils");
const hre = require("hardhat");
const Web3 = require("web3")
const Web3EthAbi = require('web3-eth-abi');


async function main() {

    const Executor = await hre.ethers.getContractFactory("Executor");
    const executor = await Executor.attach("0x45b582b0e3F2c5f698d8Ef09288051b64C71A748");//BSC Testnet
    
    
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

   const encodeAmountIn1 = Web3EthAbi.encodeParameters(
        ['uint256[]'],[[amountIn,amountIn]]
    );
    const encodeAmountOut1 = Web3EthAbi.encodeParameters(
        ['uint256[]'],[[amountOut,amountOut]]
    );
    const encodeRouters1 = Web3EthAbi.encodeParameters(
        ['address[]'],[["0xe4D2394AEf495B1A3aeda413FBADda84f59F1698","0xe4D2394AEf495B1A3aeda413FBADda84f59F1698"]]
    );
    const encodePayload1 = Web3EthAbi.encodeParameters(
        ['bytes[]'],[[swapparam1,swapparam1]]
    );
    var fromToken1 = "0xD67aC77AF1Aa020Ed3D169daB78Cf70aFe1f2498"; //A
    const element1 = Web3EthAbi.encodeParameter({
        ElementSwap:{
            encodeRouters :"bytes",
            encodeAmountIn :"bytes",
            encodeAmountOut :"bytes",
            fromToken: "address",
            encodePayload: "bytes",
        },
    },
    {
        encodeRouters:encodeRouters1,
        encodeAmountIn:encodeAmountIn1,
        encodeAmountOut:encodeAmountOut1,
        fromToken: fromToken1,
        encodePayload: encodePayload1,
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
        fromToken:"0xCA8eB2dec4Fe3a5abbFDc017dE48E461A936623D",  //USDC
        toToken: "0x3304dd20f6Fe094Cb0134a6c8ae07EcE26c7b6A7", //BUSD
        targetExchange: "0xd5e56cd4c8111643a94ee084df31f44055a1ec9f",  //StableSwap USDC/BUSD
        payload: payload2,
        //networkFee: 11,
    });
    var amountIn  = Web3.utils.toWei('100', 'ether');
    var amountOut  = Web3.utils.toWei('0', 'ether');
    const encodeAmountIn2 = Web3EthAbi.encodeParameters(
        ['uint256[]'],[[amountIn]]
    );
    const encodeAmountOut2 = Web3EthAbi.encodeParameters(
        ['uint256[]'],[[amountOut]]
    );
    const encodeRouters2 = Web3EthAbi.encodeParameters(
        ['address[]'],[["0x14019b6fec14cf6777954078917f8a239Aa1BE93"]]
    );
    const encodePayload2 = Web3EthAbi.encodeParameters(
        ['bytes[]'],[[swapparam2]]
    );
    var fromToken2 = "0xCA8eB2dec4Fe3a5abbFDc017dE48E461A936623D"; //USDC
    const element2 = Web3EthAbi.encodeParameter({
        ElementSwap:{
            encodeRouters :"bytes",
            encodeAmountIn :"bytes",
            encodeAmountOut :"bytes",
            fromToken: "address",
            encodePayload: "bytes",
        },
    },
    {
        encodeRouters:encodeRouters2,
        encodeAmountIn:encodeAmountIn2,
        encodeAmountOut:encodeAmountOut2,
        fromToken: fromToken2,
        encodePayload: encodePayload2,
    });

    const chain1 =  Web3EthAbi.encodeParameters(
        ['bytes[]'],[[element1,element2]]
    );

    const total = Web3EthAbi.encodeParameters(
        ['bytes[]'],[[chain1,chain1]]
    );
    console.log(total)
    //const dataChain1 = Web3EthAbi.decodeParameters(['bytes[]'],total)[0];


    var from = "0x197eE7A0515158225B3A19d9552b894Ff6a55E9b";
    var toToken = "0x3304dd20f6Fe094Cb0134a6c8ae07EcE26c7b6A7";
    var data = total;
    // //var executor = "0x2926EdAb17996aFD7ce4877Db9EE24127174bdae";
    await executor.execution(total,from,toToken);


    
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
//npx hardhat run scripts/ReferralBonus/init_data.js --network bsc-mainnet