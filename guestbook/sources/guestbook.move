
/// Module: guestbook
module guestbook::guestbook;

use std::string::String;
use sui::sui::SUI;


const MAX_MESSAGE_LENGTH: u64 = 100;

const EInvalidMessageLength: u64 = 0;


// For Move coding conventions, see
// https://docs.sui.io/concepts/sui-move-concepts/conventions

public struct Message has store {
    sender: address,
    message: String,
}


public struct Guestbook has key {
    id: UID,
    no_of_messages: u64,
    message: vector<Message>,
}

fun init(ctxx: &mut TxContext) {
    let guestbook = Guestbook {
        id: object::new(ctxx),
        no_of_messages: 0,
        message: vector::empty<Message>(),
    };

    sui::transfer::share_object(guestbook);
}

public fun post_message(guestbook: &mut Guestbook, msg: Message, ctxx: &mut TxContext) {

    let length = std::string::length(&msg.message);
    assert!(length <= MAX_MESSAGE_LENGTH, EInvalidMessageLength); // Limit message length to 100 characters

    guestbook.no_of_messages = guestbook.no_of_messages + 1;
    vector::push_back(&mut guestbook.message, msg);

    // Logic to handle the tip can be added here if needed
}


public fun create_message(msg_str: String, ctx: &mut TxContext): Message {
    let sender = ctx.sender();

    Message {
        sender,
        message: msg_str,
    }


}