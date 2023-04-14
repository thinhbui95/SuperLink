//const { getProxyAdminFactory } = require("@openzeppelin/hardhat-upgrades/dist/utils");
const hre = require("hardhat");
const Web3 = require("web3")
const Web3EthAbi = require('web3-eth-abi');


async function main() {

    const swapstable = await hre.ethers.getContractFactory("Coin98CurveV2");
    const Swapstable = await swapstable.attach("0x8cfe82eEAeA8bDc75C2570803dD50A9AE959330a");//Goerli testnet
    var amount = Web3.utils.toWei('50', 'ether'); 
    const payload1 = Web3EthAbi.encodeParameter({
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

    const swapparam1 = Web3EthAbi.encodeParameter({
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
        fromToken:"0xCA8eB2dec4Fe3a5abbFDc017dE48E461A936623D",
        toToken: "0x3304dd20f6Fe094Cb0134a6c8ae07EcE26c7b6A7",
        targetExchange: "0xd5e56cd4c8111643a94ee084df31f44055a1ec9f",
        payload: payload1,
        //networkFee: 11,
    });
    const encodeAmountIn1 = Web3EthAbi.encodeParameters(
        ['uint256[]'],[[amount]]
    );
    const encodeAmountOut1 = Web3EthAbi.encodeParameters(
        ['uint256[]'],[['0']]
    );
    const encodeRouters1 = Web3EthAbi.encodeParameters(
        ['address[]'],[["0x14019b6fec14cf6777954078917f8a239Aa1BE93"]]
    );
    const encodePayload1 = Web3EthAbi.encodeParameters(
        ['bytes[]'],[[swapparam1]]
    );
    var fromToken1 = "0xCA8eB2dec4Fe3a5abbFDc017dE48E461A936623D";
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

    const chain1 =  Web3EthAbi.encodeParameters(
        ['bytes[]'],[[element1]]
    );
    //console.log(chain2);

    const total = Web3EthAbi.encodeParameters(
        ['bytes[]'],[[chain1]]
    );
    // console.log(total);


    var amount = Web3.utils.toWei('50', 'ether'); 
    var to = "0x197eE7A0515158225B3A19d9552b894Ff6a55E9b";
    // await Swapstable.swap(amount,0,to, swapparam1);
    await Swapstable.withdrawStuckERC20("0x3304dd20f6Fe094Cb0134a6c8ae07EcE26c7b6A7");




    
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
//npx hardhat run scripts/ReferralBonus/init_data.js --network bsc-mainnet