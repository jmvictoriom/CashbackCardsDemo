import SwiftUI

struct BankCard: Identifiable {
    let id = UUID()
    let type: CardType
    let lastFour: String
    let fullNumber: String
    let expiryDate: String
    let cvv: String
    let network: String
    let gradient: CardGradient
    var spentThisMonth: Double

    enum CardType: String {
        case debit = "Tarjeta de débito"
        case credit = "Tarjeta de crédito"
    }
}

struct CardGradient: Equatable {
    let colors: [Color]
    let startPoint: UnitPoint
    let endPoint: UnitPoint

    static func == (lhs: CardGradient, rhs: CardGradient) -> Bool {
        lhs.colors.description == rhs.colors.description
    }
}

struct Transaction: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let amount: Double
    let isIncome: Bool
    let date: String
    let icon: String
    let iconColor: Color
}

struct CardDesign: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let gradient: CardGradient
    let thumbnailColors: [Color]

    static func == (lhs: CardDesign, rhs: CardDesign) -> Bool {
        lhs.id == rhs.id
    }
}

extension BankCard {
    static let debitCard = BankCard(
        type: .debit,
        lastFour: "1093",
        fullNumber: "4821 7634 5590 1093",
        expiryDate: "09/28",
        cvv: "347",
        network: "VISA",
        gradient: CardGradient(
            colors: [
                Color(red: 0.95, green: 0.7, blue: 0.75),
                Color(red: 0.85, green: 0.6, blue: 0.8),
                Color(red: 0.6, green: 0.5, blue: 0.85),
                Color(red: 0.45, green: 0.55, blue: 0.9)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        ),
        spentThisMonth: 275.73
    )

    static let creditCard = BankCard(
        type: .credit,
        lastFour: "0221",
        fullNumber: "4917 3820 1456 0221",
        expiryDate: "03/27",
        cvv: "512",
        network: "VISA",
        gradient: CardGradient(
            colors: [
                Color(red: 0.95, green: 0.85, blue: 0.3),
                Color(red: 0.9, green: 0.4, blue: 0.6),
                Color(red: 0.5, green: 0.3, blue: 0.8),
                Color(red: 0.3, green: 0.6, blue: 0.9)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        ),
        spentThisMonth: 1_240.50
    )
}

extension Transaction {
    static let sampleTransactions: [(String, [Transaction])] = [
        ("Hoy", [
            Transaction(title: "Nómina", subtitle: "Transferencia recibida", amount: 3110.0, isIncome: true, date: "Hoy", icon: "arrow.down", iconColor: Color(red: 0.6, green: 0.8, blue: 0.3)),
            Transaction(title: "Salud", subtitle: "Farmacia", amount: 312.9, isIncome: false, date: "Hoy", icon: "arrow.up", iconColor: Color(red: 0.9, green: 0.75, blue: 0.2))
        ]),
        ("June 13th", [
            Transaction(title: "Nómina", subtitle: "Transferencia recibida", amount: 3110.0, isIncome: true, date: "June 13th", icon: "arrow.down", iconColor: Color(red: 0.6, green: 0.8, blue: 0.3)),
            Transaction(title: "Salud", subtitle: "Farmacia", amount: 312.9, isIncome: false, date: "June 13th", icon: "arrow.up", iconColor: Color(red: 0.9, green: 0.75, blue: 0.2))
        ]),
        ("June 12th", [
            Transaction(title: "Nómina", subtitle: "Transferencia recibida", amount: 3110.0, isIncome: true, date: "June 12th", icon: "arrow.down", iconColor: Color(red: 0.6, green: 0.8, blue: 0.3)),
            Transaction(title: "Salud", subtitle: "Farmacia", amount: 312.9, isIncome: false, date: "June 12th", icon: "arrow.up", iconColor: Color(red: 0.9, green: 0.75, blue: 0.2))
        ]),
        ("June 11th", [
            Transaction(title: "Salud", subtitle: "Farmacia", amount: 312.9, isIncome: false, date: "June 11th", icon: "arrow.up", iconColor: Color(red: 0.9, green: 0.75, blue: 0.2)),
            Transaction(title: "Nómina", subtitle: "Transferencia recibida", amount: 3110.0, isIncome: true, date: "June 11th", icon: "arrow.down", iconColor: Color(red: 0.6, green: 0.8, blue: 0.3))
        ])
    ]
}

extension CardDesign {
    static let designs: [CardDesign] = [
        CardDesign(
            name: "Aurora",
            gradient: CardGradient(
                colors: [
                    Color(red: 0.95, green: 0.7, blue: 0.75),
                    Color(red: 0.85, green: 0.6, blue: 0.8),
                    Color(red: 0.6, green: 0.5, blue: 0.85),
                    Color(red: 0.45, green: 0.55, blue: 0.9)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ),
            thumbnailColors: [Color(red: 0.95, green: 0.7, blue: 0.75), Color(red: 0.45, green: 0.55, blue: 0.9)]
        ),
        CardDesign(
            name: "Cosmos",
            gradient: CardGradient(
                colors: [
                    Color(red: 0.1, green: 0.1, blue: 0.2),
                    Color(red: 0.0, green: 0.3, blue: 0.5),
                    Color(red: 0.1, green: 0.5, blue: 0.6),
                    Color(red: 0.0, green: 0.2, blue: 0.3)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ),
            thumbnailColors: [Color(red: 0.1, green: 0.1, blue: 0.2), Color(red: 0.1, green: 0.5, blue: 0.6)]
        ),
        CardDesign(
            name: "Nebula",
            gradient: CardGradient(
                colors: [
                    Color(red: 0.6, green: 0.2, blue: 0.5),
                    Color(red: 0.3, green: 0.1, blue: 0.6),
                    Color(red: 0.1, green: 0.4, blue: 0.7),
                    Color(red: 0.2, green: 0.7, blue: 0.6)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ),
            thumbnailColors: [Color(red: 0.6, green: 0.2, blue: 0.5), Color(red: 0.2, green: 0.7, blue: 0.6)]
        ),
        CardDesign(
            name: "Solar",
            gradient: CardGradient(
                colors: [
                    Color(red: 0.95, green: 0.5, blue: 0.2),
                    Color(red: 0.95, green: 0.3, blue: 0.4),
                    Color(red: 0.8, green: 0.2, blue: 0.6),
                    Color(red: 0.5, green: 0.2, blue: 0.7)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ),
            thumbnailColors: [Color(red: 0.95, green: 0.5, blue: 0.2), Color(red: 0.5, green: 0.2, blue: 0.7)]
        ),
        CardDesign(
            name: "Glaciar",
            gradient: CardGradient(
                colors: [
                    Color(red: 0.85, green: 0.9, blue: 0.95),
                    Color(red: 0.6, green: 0.75, blue: 0.9),
                    Color(red: 0.4, green: 0.55, blue: 0.85),
                    Color(red: 0.3, green: 0.4, blue: 0.75)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ),
            thumbnailColors: [Color(red: 0.85, green: 0.9, blue: 0.95), Color(red: 0.3, green: 0.4, blue: 0.75)]
        )
    ]
}
