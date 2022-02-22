function generate(count){
    let chars = 'acdefhiklmnoqrstuvwxyz0123456789'.split('');
    let result = '';
    for(let i=0; i<count; i++){
      let x = Math.floor(Math.random() * chars.length);
      result += chars[x];
    }
    return result;
}

let newNFT = generate(6)

console.log(newNFT);

let stamp = Date.now()
console.log(stamp);