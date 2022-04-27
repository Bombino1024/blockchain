let fs = require("fs");
let axios = require("axios");

let songs = ["JTiger", "JTwinkle"];
let durations = ["00:15", "00:05"];
let ipfsArray = [];

for (let i = 0; i < songs.length; i++) {
  ipfsArray.push({
    path: `metadata/${i}.json`,
    content: {
      image: `ipfs://QmWGyS6mqvksGP98ofrZzw6b4dNfWpk4MZgMPcWRdJqAT2/media/2`,
      name: songs[i],
      animation_url: `ipfs://QmWGyS6mqvksGP98ofrZzw6b4dNfWpk4MZgMPcWRdJqAT2/media/${i}`, //xxx = hash
      duration: durations[i],
      artist: "MartinB",
      year: "1996",
    },
  });
}

axios
  .post("https://deep-index.moralis.io/api/v2/ipfs/uploadFolder", ipfsArray, {
    headers: {
      "X-API-KEY":
        "knetbjPWVvlsa9nWNRqmRRfDE7ZymaBXIWzvDhCEJk27KIodb5BrKtAZJUhWSnkA",
      "Content-Type": "application/json",
      accept: "application/json",
    },
  })
  .then((res) => {
    console.log(res.data);
  })
  .catch((error) => {
    console.log(error);
  });
