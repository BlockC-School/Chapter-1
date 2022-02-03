const Block = require('./block');
const Blockchain = require('./blockchain');
const blockchain = require('./Blockchain');
const addBlock  = require('./addBlock');

for (let i = 0; i < 20; i++) {
    const newData = `vikash ${i}`;
    blockchain.addBlock({ data: `block ${i}` });
}

console.log(blockchain);