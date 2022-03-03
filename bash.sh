export ID=eespinor.testnet
export ID_ALICE=A1.$ID 
export ID_BOB=B1.$ID 
export ID_EVE=E1.$ID 


echo '......building project......'
cargo clean & cargo build --target wasm32-unknown-unknown --release

echo '......testing......'
cargo test -- --nocapture

echo $ID
echo 'ALICE:' $ID_ALICE
echo 'BOB:'  $ID_BOB
echo 'EVE:'  $ID_EVE

echo '......creation accounts......'
near create-account $ID_ALICE --masterAccount $ID --initialBalance 3
near create-account $ID_BOB --masterAccount $ID --initialBalance 1
near create-account $ID_EVE --masterAccount $ID --initialBalance 2




echo '......deployment to testnet......'
near deploy  --initFunction 'new' --initArgs '{}'  --wasmFile target/wasm32-unknown-unknown/release/sales.wasm --accountId $ID_ALICE

echo '...final...'
