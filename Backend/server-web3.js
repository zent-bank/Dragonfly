const Web3 = require('web3')
const Tx = require('ethereumjs-tx').Transaction
const util = require('ethereumjs-util');   
const Buffer = require('safe-buffer').Buffer
const abi = require('./abi')

const config = require('./config/config')
const CONTRACT_ADDRESS = config.address.dgc_contract
const MY_ADDRESS = config.address.senderWallet
const MY_PRIVATE_KEY = config.walletPrivateKey


const web3 = new Web3(new Web3.providers.HttpProvider('https://rinkeby.infura.io/v3/7a9ed5d28c7e4208b3e308b33f4d0ae0'))

// const provider = new ethers.providers.InfuraProvider('rinkeby','7a9ed5d28c7e4208b3e308b33f4d0ae0')

getBalance = async () => {
    try{
        const balance = await web3.eth.getBalance(MY_ADDRESS)
        console.log(`Balance ${balance}`)

        const contract = new web3.eth.Contract(abi, CONTRACT_ADDRESS)
        const totalSupply = await contract.methods.balanceOf(MY_ADDRESS).call()
        console.log(`TotalSupply: ${totalSupply/10e18}`)
    }catch(err){
        console.error(err)
    }
}

transferToken = async () => {
    try{
        const contract = new web3.eth.Contract(abi, CONTRACT_ADDRESS)
        const txCount = await web3.eth.getTransactionCount(MY_ADDRESS)
        var rawTx = {
            from: MY_ADDRESS,
            nonce: util.bufferToHex(txCount),
            gasPrice: web3.utils.toHex(web3.utils.toWei('6', 'gwei')),
            gasLimit: web3.utils.toHex(2100000),
            to: CONTRACT_ADDRESS,
            value: web3.utils.toHex(web3.utils.toWei('0', 'ether')),
            data: contract.methods.transfer('0xd389b5A945670D68681c53fE3C5cCA973CaC53F4', web3.utils.toWei('500', 'ether')).encodeABI()
        }
        console.log('rawTx', rawTx)

        let tx = new Tx(rawTx, { chain: 'rinkeby' })
        console.log('transaction: ', tx.serialize().toString('hex'))
        console.log('tx.hash(false): ', tx.hash(false).toString('hex'))
        tx.sign(new Buffer.from(MY_PRIVATE_KEY, 'hex'))
        console.log('tx.v', tx.v)

        let serializedTx = tx.serialize()
        console.log('transaction signed: ', serializedTx.toString('hex'))

        const result = await web3.eth.sendSignedTransaction('0x' + serializedTx.toString('hex'))
        console.log(`result`, result)
    }catch(err){
        console.error(err)
    }
}

(async () => {
    await getBalance()
    console.log("---------------")
    console.log("transfer token")
    await transferToken()
    console.log("---------------")
    await getBalance()
})()