```
yarn
yarn start
```

Album folder
```
cd <path>/Album
npm init
npm install fs
npm install axios
download media files to /export folder
add file names to music.js -> media []
copy API key from moralis -> Web3 API -> Copy API key -> Default
paste API key -> music.js -> axios post headers X-API-KEY
node music.js

add song names and durations to metadata.js -> songs[], durations[]
copy has from printed ipfs path of .png file to metadata.js ipfsArray push image
copy has from printed ipfs paths of .mp3 files to metadata.js ipfsArray push animation_url
fill rest of ipfsArray push metadata with random values
in metadata.js fill X-API-KEY with same as in music.js
node metadata.js
```

Remix IDE
```
create workspace
create Album.sol in contracts folder
copy contract from github
add to constructor two methods createToken with .json files returned from metadata.js upload
Compile Album.sol
Select environment Injected Web3 (Kovan)
Deploy
Check if was create on Kovan etherscan and Testnets opensea
Update smart contract address and image ipfs link in albumList.js
```