use SimpleLoanListProposal::{Proposal, ProposalValues};
use pwn::loan::terms::simple::loan::types::Terms;

#[starknet::interface]
trait ISimpleLoanListProposal<TState> {
    fn make_proposal(ref self: TState, proposal: Proposal) -> felt252;
    fn accept_proposal(
        ref self: TState,
        acceptor: starknet::ContractAddress,
        refinancing_loan_id: felt252,
        proposal_data: Array<felt252>,
        proposal_inclusion_proof: Array<felt252>,
        signature: felt252
    ) -> (felt252, Terms);
    fn get_proposal_hash(self: @TState, proposal: Proposal) -> felt252;
    fn encoded_proposal_data(
        self: @TState, proposal: Proposal, proposal_values: ProposalValues
    ) -> felt252;
    fn decode_proposal_data(self: @TState, encoded_data: felt252) -> (Proposal, ProposalValues);
}

#[starknet::contract]
mod SimpleLoanListProposal {
    use pwn::ContractAddressDefault;
    use pwn::multitoken::library::MultiToken;
    use starknet::ContractAddress;

    // NOTE: we can hard code this by calculating the poseidon hash of the string 
    // in the Solidity contract offline.
    const PROPOSAL_TYPEHASH: felt252 = 0;

    #[derive(Default, Drop, Serde)]
    pub struct Proposal {
        collateral_category: MultiToken::Category,
        collateral_address: ContractAddress,
        collateral_ids_whitelist_merkle_root: felt252,
        collateral_amount: u256,
        check_collateral_state_fingerprint: bool,
        collateral_state_fingerprint: felt252,
        credit_address: ContractAddress,
        credit_amount: u256,
        available_credit_limit: u256,
        fixed_interest_amount: u256,
        accruing_interest_APR: u32,
        duration: u64,
        expiration: u64,
        allowed_acceptor: ContractAddress,
        proposer: ContractAddress,
        proposer_specHash: felt252,
        is_offer: bool,
        refinancing_loan_id: felt252,
        nonce_space: felt252,
        nonce: felt252,
        loan_contract: ContractAddress,
    }


    #[derive(Drop, Serde)]
    pub struct ProposalValues {
        collateral_id: felt252,
        merkle_inclusion_proof: Span<felt252>,
    }

    #[storage]
    struct Storage {}

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        ProposalMade: ProposalMade,
    }

    #[derive(Drop, starknet::Event)]
    struct ProposalMade {
        proposal_hash: felt252,
        proposer: ContractAddress,
        proposal: Proposal,
    }

    pub mod Err {
        fn COLLATERAL_ID_NOT_WHITELISTED(id: felt252) {
            panic!("Collateral ID {} is not whitelisted", id);
        }
    }


    #[constructor]
    fn constructor(
        ref self: ContractState,
        hub: ContractAddress,
        revoke_nonce: ContractAddress,
        config: ContractAddress
    ) {}

    #[abi(embed_v0)]
    impl SimpleLoanListProposalImpl of super::ISimpleLoanListProposal<ContractState> {
        fn make_proposal(ref self: ContractState, proposal: Proposal) -> felt252 {
            0
        }

        fn accept_proposal(
            ref self: ContractState,
            acceptor: starknet::ContractAddress,
            refinancing_loan_id: felt252,
            proposal_data: Array<felt252>,
            proposal_inclusion_proof: Array<felt252>,
            signature: felt252
        ) -> (felt252, super::Terms) {
            (0, Default::default())
        }

        fn get_proposal_hash(self: @ContractState, proposal: Proposal) -> felt252 {
            0
        }

        fn encoded_proposal_data(
            self: @ContractState, proposal: Proposal, proposal_values: ProposalValues
        ) -> felt252 {
            0
        }

        fn decode_proposal_data(
            self: @ContractState, encoded_data: felt252
        ) -> (Proposal, ProposalValues) {
            (
                Default::default(),
                ProposalValues { collateral_id: 0, merkle_inclusion_proof: array![].span() }
            )
        }
    }
}

