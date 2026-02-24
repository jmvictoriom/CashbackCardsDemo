import Testing
@testable import CashbackCardsDemo

@Suite("Transaction Model")
struct TransactionTests {

    @Test("Sample transactions have 4 date sections")
    func sectionCount() {
        #expect(Transaction.sampleTransactions.count == 4)
    }

    @Test("Each section has exactly 2 transactions")
    func transactionsPerSection() {
        for (_, transactions) in Transaction.sampleTransactions {
            #expect(transactions.count == 2)
        }
    }

    @Test("All transactions have required fields populated")
    func transactionFields() {
        for (date, transactions) in Transaction.sampleTransactions {
            #expect(!date.isEmpty)
            for tx in transactions {
                #expect(!tx.title.isEmpty)
                #expect(!tx.subtitle.isEmpty)
                #expect(tx.amount > 0)
                #expect(!tx.icon.isEmpty)
            }
        }
    }

    @Test("Income transactions use arrow.down icon")
    func incomeIcon() {
        let allTx = Transaction.sampleTransactions.flatMap(\.1)
        let incomeTx = allTx.filter(\.isIncome)
        #expect(!incomeTx.isEmpty)
        for tx in incomeTx {
            #expect(tx.icon == "arrow.down")
        }
    }

    @Test("Expense transactions use arrow.up icon")
    func expenseIcon() {
        let allTx = Transaction.sampleTransactions.flatMap(\.1)
        let expenseTx = allTx.filter { !$0.isIncome }
        #expect(!expenseTx.isEmpty)
        for tx in expenseTx {
            #expect(tx.icon == "arrow.up")
        }
    }
}
