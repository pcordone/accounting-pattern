//
//  PostingRulesTests.swift
//  
//
//  Created by Peter Wiley-Cordone on 3/8/20.
//

import Foundation
import XCTest
@testable import Accounting
    
final class PostingRulesTests: XCTestCase {

    func testAccountPostingRule() {
        let postingRule = AccountPostingRule()
        let now = Date()
        let agreement = ServiceAgreement()
        let otherParty = OtherParty(name: "Other Party")
        // test an debit
        var event: AccountingEvent = AccountingEvent(name: "Test postentry debit", whenOccurred: now, whenNoticed: nil, isProcessed: false, otherParty: otherParty, agreement: agreement, amount: Money(100), account: Account(name: "Account Name", number: AccountNumber("12345"), currency: .USD), entryType: .debit)
        // store the generated id of the event so we can make sure they match after the call to processEvent
        let eventIdBeforeProcessCall = event.id
        XCTAssertEqual(0, event.account.entries.count)
        XCTAssertNoThrow(try postingRule.processEvent(&event))
        // make sure the id's match before and after the process call so that I can rely on id
        XCTAssertEqual(eventIdBeforeProcessCall, event.id)
        XCTAssertEqual(1, event.account.entries.count)
        XCTAssertNotNil(event.account.entries.first)
        guard let entry = event.account.entries.first else {
            return XCTFail("Expected a single entry but got none!")
        }
        XCTAssertEqual(now, entry.date)
        XCTAssertEqual(Money(100), entry.amount)
        XCTAssertEqual(.debit, entry.entryType)
        XCTAssertEqual(otherParty.id, entry.otherParty.id)
    }
    
    static var allTests = [
        ("testAccountPostingRule", testAccountPostingRule),
    ]
}
