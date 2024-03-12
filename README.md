# MyNFT Smart Contract

## Introduzione

Il nostro contratto `MyNFT` consente agli utenti di interagire con un mercato decentralizzato di token non fungibili (NFT), enfatizzando l'unicità e la proprietà digitale. Gli utenti possono creare, acquistare e vendere NFT, ciascuno rappresentante un oggetto digitale unico, come arte, collezionabili, e altro ancora. La nostra piattaforma utilizza lo standard ERC-721 per garantire la compatibilità e la sicurezza nella gestione degli NFT.

## Scopo

Il contratto `MyNFT` mira a fornire un ecosistema decentralizzato per la creazione e lo scambio di NFT, permettendo agli artisti e ai collezionisti di avere pieno controllo sulle loro opere digitali.

## Funzionalità Principali

1. **Minting di NFT**: Gli utenti possono creare nuovi NFT caricando i loro contenuti digitali unici.

2. **Scambio di NFT**: Gli utenti possono scambiare i propri NFT con altri wallet/utenti.

3. **Storia e Provenienza**: Ogni NFT ha una storia tracciabile che ne conferma l'autenticità e la proprietà.

4. **Vantaggi**: Ogni NFT offriràun vantaggio sulla piattaforma di Yoga.

## Deploy, Subscription ed esempi di utilizzo tramite tx

Address del contratto su [Rete Sepolia](https://sepolia.etherscan.io/address/0x8D337D4b15bA18B75CfbDf33C0FEe6F3E272F982)

[Chainlink subscription ID](https://vrf.chain.link/sepolia/10060) 

[Transazione minting NFT](https://sepolia.etherscan.io/tx/0x549b4c5015e0dc3616b843fbe9607da0ee54643818e537b46668642c56a6081f)

[Passaggio NFT tra 2 wallet su rete Sepolia](https://sepolia.etherscan.io/tx/0x11a3a5878271f8c735aa23f8d806f1e6caec3d3ebcc1c713c6a524a5eb37b976)

### Minting di NFT

```solidity
// Creazione di un nuovo NFT
await myNFT.mint(tokenURI);
```

### Info Contratto

Il contratto MyNFT (MyNFT.sol) è stato deployato al seguente Address su [Rete Sepolia](https://sepolia.etherscan.io/address/0x8D337D4b15bA18B75CfbDf33C0FEe6F3E272F982)

### Deploy Contratto

Prima di effettuare il deploy, assicurati di avere configurato correttamente il tuo ambiente di sviluppo e di aver impostato i parametri necessari (es. URL dell'immagine, descrizione dell'NFT).

```zsh
npx hardhat run --network tuaRete scripts/deployMyNFT.ts
```