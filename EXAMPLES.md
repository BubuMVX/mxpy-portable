# Examples (`mxpy`)

A few quick, copy-pasteable examples for the MultiversX CLI (`mxpy`).

Replace `mxpy` with the name of your executable (`mxpy-windows.exe`, `mxpy-macos`, `mxpy-linux`, or your custom name if
you renamed it).

> Tip: add `--proxy` and `--chain` to target a network
> - mainnet: `--proxy https://gateway.multiversx.com --chain 1`
> - devnet: `--proxy https://devnet-gateway.multiversx.com --chain D`
> - testnet: `--proxy https://testnet-gateway.multiversx.com --chain T`

---

## Create a new wallet

```bash
mxpy wallet new
```

Creates a mnemonic and prints it to your terminal. To also save files, use `--format` and `--outfile` (see next
example).

---

## Create a new wallet in PEM format and save it to `wallet.pem`

```bash
mxpy wallet new \
  --format pem \
  --outfile wallet.pem
```

This writes a PEM file you can later use with `--pem`.

---

## Create a new VibeOX wallet (HRP = `vibe`)

```bash
mxpy wallet new \
  --format pem \
  --address-hrp vibe \
  --outfile wallet-vibe.pem
```

Sets the bech32 human-readable part (HRP) to `vibe` for addresses generated from this wallet file.

---

## Sign a simple “Hello world!” message

```bash
mxpy wallet sign-message \
  --pem wallet.pem \
  --message "Hello world!"
```

Signs arbitrary text with the private key in `wallet.pem`.

---

## Get details about an address

```bash
mxpy get account \
  --address erd1xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \
  --proxy https://gateway.multiversx.com
```

Add `--balance` if you only want the balance.

---

## Get details about a transaction

```bash
mxpy get transaction \
  --hash {TRANSACTION_HASH} \
  --proxy https://gateway.multiversx.com
```

---

## Create a transaction to wrap **0.01 EGLD** into **WEGLD**

Wrapping/Unwrapping EGLD is done by EGLD wrappers smart contracts. The usual callable endpoint is `wrapEgld` (and
`unwrapEgld` for the reverse). Replace the address below with the wrapper contract address for your network and wallet's
shard.

```bash
mxpy tx new \
  --receiver {EGLD_WRAPPER_CONTRACT_ADDRESS} \
  --value 0.01 \
  --data wrapEgld \
  --pem wallet.pem \
  --proxy https://gateway.multiversx.com \
  --chain 1 \
  --send
```

---

## Deploy a smart contract from a WASM file

```bash
mxpy contract deploy \
  --bytecode ./contract.wasm \
  --pem wallet.pem \
  --gas-limit 60000000 \
  --proxy https://devnet-gateway.multiversx.com \
  --chain D \
  --send
```

You can add `--abi ./contract.abi.json` and metadata flags like `--metadata-not-upgradeable` if needed. For mainnet,
switch `--proxy` and `--chain` accordingly.

---

### Notes

- Use `--wait-result` with `--timeout <seconds>` to wait for confirmations on commands that support it.
- For queries & calls to contracts, prefer `mxpy contract query` and `mxpy contract call`.
