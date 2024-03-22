# MyNFT Smart Contract

## Introduzione

Il contratto MyNFT permette agli utenti di partecipare a un mercato decentralizzato di token non fungibili (NFT), mettendo in risalto l'unicità e la proprietà digitale. Gli utenti possono creare, acquistare e vendere NFT, ciascuno rappresentante un oggetto digitale unico, come arte, collezionabili e altro ancora. Questa piattaforma utilizza lo standard ERC-721 per garantire la compatibilità e la sicurezza nella gestione dei NFT.

## Prerequisiti

Per utilizzare questo progetto, assicurati di avere installato:

**Node.js** (versione 12.x o superiore)

**npm** (versione 6.x o superiore) o yarn

**Hardhat**

### Installazione 

Clona il repository e installa le dipendenze:

```zsh
git clone https://github.com/Nicco6598/NFT-SmartContract.git
cd NFT-SmartContract
npm install
```

### Test

Per eseguire i test automatizzati:

```zsh
npx hardhat test
```

### Avviare la Rete Locale

Per avviare una blockchain locale per lo sviluppo e il testing:

```zsh
npx hardhat node
```

### Deploy del Contratto

Per deployare il contratto sulla rete locale o su una rete di test, usa il seguente comando:

```zsh
npx hardhat run --network <nomeRete> scripts/deploy.ts
```

Assicurati di sostituire <nomeRete> con il nome della rete su cui intendi deployare, ad esempio localhost o sepolia.


## Scopo

Il contratto `MyNFT` mira a fornire un ecosistema decentralizzato per la creazione e lo scambio di NFT, permettendo agli artisti e ai collezionisti di avere pieno controllo sulle loro opere digitali.

## Funzionalità Principali

1. **Minting di NFT**: Gli utenti possono creare nuovi NFT caricando i loro contenuti digitali unici.

2. **Scambio di NFT**: Gli utenti possono scambiare i propri NFT con altri wallet/utenti.

3. **Storia e Provenienza**: Ogni NFT ha una storia tracciabile che ne conferma l'autenticità e la proprietà.

4. **Vantaggi**: Ogni NFT offrirà un vantaggio sulla piattaforma di Yoga.

## Deploy, Subscription ed esempi di utilizzo tramite tx

Address del contratto su [Rete Sepolia](https://sepolia.etherscan.io/address/0x8D337D4b15bA18B75CfbDf33C0FEe6F3E272F982)

Chainlink [Subscription ID](https://vrf.chain.link/sepolia/10060) 

Transazione (tx) [minting NFT](https://sepolia.etherscan.io/tx/0x549b4c5015e0dc3616b843fbe9607da0ee54643818e537b46668642c56a6081f)

[Passaggio NFT tra 2 wallet su rete Sepolia](https://sepolia.etherscan.io/tx/0x11a3a5878271f8c735aa23f8d806f1e6caec3d3ebcc1c713c6a524a5eb37b976)

### Minting di NFT

```solidity
// Creazione di un nuovo NFT
await myNFT.mint(tokenURI);
```

### Info Contratto

Il contratto MyNFT (MyNFT.sol) è stato deployato al seguente Address su [Rete Sepolia](https://sepolia.etherscan.io/address/0x8D337D4b15bA18B75CfbDf33C0FEe6F3E272F982)