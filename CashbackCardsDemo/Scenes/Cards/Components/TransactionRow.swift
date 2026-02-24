import SwiftUI

struct TransactionRow: View {

    private enum Layout {
        static let iconSize: CGFloat = 40
        static let iconInnerSize: CGFloat = 16
    }

    let transaction: Transaction

    var body: some View {
        HStack(spacing: 14) {
            // Icon circle
            ZStack {
                Circle()
                    .fill(transaction.iconColor.opacity(0.2))
                    .frame(width: Layout.iconSize, height: Layout.iconSize)

                Image(systemName: transaction.icon)
                    .font(.system(size: Layout.iconInnerSize, weight: .semibold))
                    .foregroundStyle(transaction.iconColor)
            }

            // Title & subtitle
            VStack(alignment: .leading, spacing: 2) {
                Text(transaction.title)
                    .font(.subheadline.bold())
                    .foregroundStyle(.white)

                Text(transaction.subtitle)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.5))
            }

            Spacer()

            // Amount
            Text("\(transaction.isIncome ? "+ " : "- ")\(transaction.amount, specifier: "%.2f")€")
                .font(.subheadline.bold())
                .foregroundStyle(transaction.isIncome ? Color(red: 0.6, green: 0.85, blue: 0.4) : Color(red: 0.95, green: 0.4, blue: 0.4))
                .monospacedDigit()
        }
        .padding(.vertical, 6)
    }
}

struct TransactionSectionView: View {
    let date: String
    let transactions: [Transaction]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(date)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.4))
                .padding(.top, 8)

            ForEach(transactions) { transaction in
                TransactionRow(transaction: transaction)
            }
        }
    }
}

#Preview {
    ZStack {
        Color.black
        VStack {
            TransactionSectionView(
                date: "Hoy",
                transactions: Transaction.sampleTransactions[0].1
            )
        }
        .padding()
    }
}
