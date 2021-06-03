const ethers = require('ethers')
// const abi = require('./abi')
const config = require('./config/config')
const abi = [
    'function totalSupply() public view returns (uint256)',
    'function balanceOf(address account) public view returns (uint256)',
    'function transfer(address recipient, uint256 amount) public returns (bool)',
    'function allowance(address owner, address spender) public view returns (uint256)',
    'function approve(address spender, uint256 amount) public returns (bool)',
    'function transferFrom(address sender, address recipient, uint256 amount) public returns (bool)'
]
const CONTRACT_ADDRESS = config.address.dgc_contract
const MY_ADDRESS = config.address.senderWallet
const MY_PRIVATE_KEY = config.walletPrivateKey
// const provider = new ethers.providers.JsonRpcProvider('https://rinkeby.infura.io/v3/7a9ed5d28c7e4208b3e308b33f4d0ae0')
const provider = new ethers.getDefaultProvider('rinkeby')

getBalance = async () => {
    try{
        // const provider = new ethers.providers.InfuraProvider('rinkeby','7a9ed5d28c7e4208b3e308b33f4d0ae0')
        const contract = new ethers.Contract(CONTRACT_ADDRESS, abi, provider)
        const balance = await contract.balanceOf(MY_ADDRESS)
        console.log(ethers.utils.formatUnits(balance,18))

    }catch(err){
        console.error(err)
    }
}

transferToken = async (transferAmount) => {
    try{
        const senderWallet = new ethers.Wallet(MY_PRIVATE_KEY,provider)
        const contract = new ethers.Contract(CONTRACT_ADDRESS,abi, senderWallet)
        const receiveWallet = '0xd389b5A945670D68681c53fE3C5cCA973CaC53F4'
        const amount = ethers.utils.parseUnits(transferAmount,18)
        const response = await contract.transfer(receiveWallet, amount)
        const result = await response.wait()
        console.log("result.blockHash: ", result.blockHash)
        console.log("result.transactionHash: ", result.transactionHash)
    }catch(err){
        console.error(err)
    }
}

(async () => {
    await getBalance()
    console.log("---------------")
    console.log("transfer token")
    await transferToken('0.00000099995')
    console.log("---------------")
    await getBalance()
})()