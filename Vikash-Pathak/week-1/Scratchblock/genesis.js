
// creating a genesis block

// Step-1
const GENESIS_DATA = {
    timestamp: Date.now(),
    lastHash: '4C94485E0C21AE6C41CE1DFE7B6BFACEEA5AB68E40A2476F50208E526F506080',
    hash: 'E20383708E67D5F9BF1C03944BF191D1D5BEE069E05D9DFF453CBFDBCB37DE02',
    data: 'vikash'
};
console.log(GENESIS_DATA);
module.exports = { GENESIS_DATA };

console.log(`this is working ${module.exports.GENESIS_DATA}`);
// create a first genesis block
