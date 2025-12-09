use dep::merkle_trees::compute_merkle_root;
use dep::std::hash::pedersen_hash;
      

fn main(
    id: Field,
    r: Field,
    hash_path: [Field; 8],
    old_root: pub Field,
    new_root: pub Field,
    commitment:pub Field,
    index: Field,
) {
    // 1. Constraint: Commitment Integrity
    // Compute commitment internally using private secrets (id, r)
    let calculated_commitment: Field = pedersen_hash([id, r]);

    // Assert that the internally calculated hash matches the public input
    assert(calculated_commitment == commitment);

    // STEP 1: Prove the path is valid for the OLD root (where the leaf is currently empty)
    let empty_leaf: Field = pedersen_hash([0]);
    let calculated_old_root = compute_merkle_root::<8>(empty_leaf, index, hash_path);
    assert(calculated_old_root == old_root);

    // STEP 2: Calculate the NEW root (inserting the commitment into that same spot)
    let calculated_new_root = compute_merkle_root::<8>(commitment, index, hash_path);
    assert(calculated_new_root == new_root);
}