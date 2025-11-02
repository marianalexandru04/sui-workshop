
/// Module: tip_jar
module tip_jar::tip_jar;
use sui::coin::Coin;
use sui::sui::SUI;

// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions


public struct TipJar has key {
    id: UID,
    balance: u64,
    no_of_tips: u64,
    owner: address,

}

fun init(ctx: &mut TxContext) {
    let tip_jar = TipJar {
        id: object::new(ctx),
        balance: 0,
        no_of_tips: 0,
        owner: ctx.sender(),
    };

    sui::transfer::share_object(tip_jar);
}

public fun tip(tip_jar: &mut TipJar, payment: Coin<SUI>) {
    // Logic to add tip to the tip jar
    let amount = sui::coin::value(&payment);
    tip_jar.balance = tip_jar.balance + amount;
    tip_jar.no_of_tips = tip_jar.no_of_tips + 1;

    sui::transfer::public_transfer(payment, tip_jar.owner);
    
}