# Enable debug JSON RPC API

Check if the module has been enable:

```bash
curl --request POST \
  --url http://127.0.0.1:8545/ \
  --header 'Content-Type: application/json' \
  --header 'User-Agent: insomnia/2023.5.8' \
  --data '{
    "jsonrpc": "2.0",
    "method": "rpc_modules",
    "params": [],
    "id": 1
}
'
```

Response should be

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "result": {
    "debug": "1.0",
    "eth": "1.0",
    "net": "1.0",
    "rpc": "1.0",
    "txpool": "1.0",
    "web3": "1.0"
  }
}

``` 
