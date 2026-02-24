import Testing
@testable import CashbackCardsDemo

@Suite("Models")
struct ModelsTests {

    @Test("Brand sample data exists")
    func brandSampleData() {
        #expect(!Brand.featured.isEmpty)
        #expect(!Brand.allBrands.isEmpty)
        #expect(!Brand.popular.isEmpty)
        #expect(Brand.featured.count == 3)
    }

    @Test("Brand has valid cashback percent")
    func brandCashback() {
        for brand in Brand.allBrands {
            #expect(brand.cashbackPercent > 0)
            #expect(brand.cashbackPercent <= 100)
        }
    }

    @Test("Brand has conditions")
    func brandConditions() {
        for brand in Brand.allBrands {
            #expect(!brand.conditions.isEmpty)
        }
    }

    @Test("Card models have valid data")
    func cardModels() {
        let debit = BankCard.debitCard
        let credit = BankCard.creditCard

        #expect(debit.type == .debit)
        #expect(credit.type == .credit)
        #expect(debit.lastFour == "1093")
        #expect(credit.lastFour == "0221")
        #expect(debit.network == "VISA")
        #expect(debit.spentThisMonth > 0)
    }

    @Test("Card gradient has colors")
    func cardGradient() {
        let debit = BankCard.debitCard
        #expect(!debit.gradient.colors.isEmpty)
        #expect(debit.gradient.colors.count == 4)
    }

    @Test("Transaction sample data is grouped by date")
    func transactions() {
        let sections = Transaction.sampleTransactions
        #expect(!sections.isEmpty)

        for (date, transactions) in sections {
            #expect(!date.isEmpty)
            #expect(!transactions.isEmpty)
        }
    }

    @Test("Card designs exist")
    func cardDesigns() {
        #expect(CardDesign.designs.count == 5)
        for design in CardDesign.designs {
            #expect(!design.name.isEmpty)
            #expect(!design.thumbnailColors.isEmpty)
        }
    }

    @Test("BankCard hashable conformance")
    func bankCardHashable() {
        let card1 = BankCard.debitCard
        let card2 = BankCard.creditCard

        #expect(card1 == card1)
        #expect(card1 != card2)

        var set = Set<BankCard>()
        set.insert(card1)
        set.insert(card2)
        #expect(set.count == 2)
    }
}
