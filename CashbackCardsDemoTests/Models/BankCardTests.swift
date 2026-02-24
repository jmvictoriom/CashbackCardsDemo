import Testing
@testable import CashbackCardsDemo

@Suite("BankCard Model")
struct BankCardTests {

    // MARK: - A15: Full card number fields

    @Test("Debit card fullNumber contains lastFour")
    func debitFullNumberContainsLastFour() {
        let card = BankCard.debitCard
        #expect(card.fullNumber.hasSuffix(card.lastFour))
    }

    @Test("Credit card fullNumber contains lastFour")
    func creditFullNumberContainsLastFour() {
        let card = BankCard.creditCard
        #expect(card.fullNumber.hasSuffix(card.lastFour))
    }

    @Test("Debit card expiryDate format MM/YY")
    func debitExpiryFormat() {
        let parts = BankCard.debitCard.expiryDate.split(separator: "/")
        #expect(parts.count == 2)
        #expect(parts[0].count == 2)
        #expect(parts[1].count == 2)
    }

    @Test("Credit card expiryDate format MM/YY")
    func creditExpiryFormat() {
        let parts = BankCard.creditCard.expiryDate.split(separator: "/")
        #expect(parts.count == 2)
        #expect(parts[0].count == 2)
        #expect(parts[1].count == 2)
    }

    @Test("CVV is exactly 3 digits")
    func cvvThreeDigits() {
        let debit = BankCard.debitCard
        let credit = BankCard.creditCard

        #expect(debit.cvv.count == 3)
        #expect(credit.cvv.count == 3)
        #expect(Int(debit.cvv) != nil)
        #expect(Int(credit.cvv) != nil)
    }

    @Test("fullNumber has 4 groups of 4 digits")
    func fullNumberFormat() {
        let groups = BankCard.debitCard.fullNumber.split(separator: " ")
        #expect(groups.count == 4)
        for group in groups {
            #expect(group.count == 4)
            #expect(Int(group) != nil)
        }
    }

    @Test("lastFour matches last group of fullNumber")
    func lastFourConsistency() {
        for card in [BankCard.debitCard, BankCard.creditCard] {
            let lastGroup = String(card.fullNumber.split(separator: " ").last!)
            #expect(lastGroup == card.lastFour)
        }
    }

    @Test("Card types have correct rawValue")
    func cardTypeRawValues() {
        #expect(BankCard.CardType.debit.rawValue == "Tarjeta de débito")
        #expect(BankCard.CardType.credit.rawValue == "Tarjeta de crédito")
    }

    @Test("Both sample cards have VISA network")
    func cardNetworks() {
        #expect(BankCard.debitCard.network == "VISA")
        #expect(BankCard.creditCard.network == "VISA")
    }
}
