use dep::merkle_trees::compute_merkle_root;
use dep::std::hash::pedersen_hash;

fn main(
    //TODO: fill in inputs
    r: Field,
    index: Field,
    hash_path: [Field; 8],
    root: pub Field,
    id: pub Field,
) {
    //TODO: implement the logic for the withdraw circuit
// 1. Reconstruct the Commitment
    // combine the PUBLIC 'id' with the PRIVATE 'r'.
    // This allows link the visible nullifier (id) to the hidden note (commitment)
    // without revealing 'r'. 
    let commitment = pedersen_hash([id, r]);

    // 2. Verify Membership
    // Prove that this specific commitment exists in the tree at 'root'.
    // This proves: "I own the money at 'index' that corresponds to this 'id'."
    let calculated_root = compute_merkle_root(commitment, index, hash_path);
    
    assert(calculated_root == root);
}
