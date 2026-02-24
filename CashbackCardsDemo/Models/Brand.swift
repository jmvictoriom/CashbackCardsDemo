import SwiftUI

struct Brand: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let logoLetter: String
    let logoColor: Color
    let cashbackPercent: Int
    let expiryText: String
    let description: String
    let conditions: [BrandCondition]
    let ctaText: String
    let daysLeft: Int

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Brand, rhs: Brand) -> Bool {
        lhs.id == rhs.id
    }
}

struct BrandCondition: Identifiable {
    let id = UUID()
    let icon: String
    let text: String
}

extension Brand {
    static let europcar = Brand(
        name: "Europcar",
        logoLetter: "E",
        logoColor: .green,
        cashbackPercent: 10,
        expiryText: "Hasta el 15 de enero",
        description: "Alquila tu coche con Europcar y consigue hasta un 10% de cashback en tu primera reserva.",
        conditions: [
            BrandCondition(icon: "clock.arrow.circlepath", text: "Reembolso en un plazo estimado de 30 días"),
            BrandCondition(icon: "building.2", text: "Disponible en tiendas física y online"),
            BrandCondition(icon: "eurosign.circle", text: "Gasto mínimo de 50€, reembolso máximo de 15€")
        ],
        ctaText: "Visitar web Europcar",
        daysLeft: 12
    )

    static let vicio = Brand(
        name: "Vicio",
        logoLetter: "V",
        logoColor: .red,
        cashbackPercent: 10,
        expiryText: "Hasta el 15 de enero",
        description: "Pide tus hamburguesas favoritas en Vicio y recibe un 10% de cashback.",
        conditions: [
            BrandCondition(icon: "clock.arrow.circlepath", text: "Reembolso en un plazo estimado de 30 días"),
            BrandCondition(icon: "iphone", text: "Solo disponible online"),
            BrandCondition(icon: "eurosign.circle", text: "Gasto mínimo de 20€, reembolso máximo de 10€")
        ],
        ctaText: "Visitar web Vicio",
        daysLeft: 12
    )

    static let northFace = Brand(
        name: "The North Face",
        logoLetter: "TNF",
        logoColor: .red,
        cashbackPercent: 5,
        expiryText: "Hasta el 15 de enero",
        description: "Equípate con The North Face y recibe hasta un 5% de cashback en tus compras.",
        conditions: [
            BrandCondition(icon: "clock.arrow.circlepath", text: "Reembolso en un plazo estimado de 30 días"),
            BrandCondition(icon: "building.2", text: "Disponible en tiendas física y online"),
            BrandCondition(icon: "eurosign.circle", text: "Gasto mínimo de 100€, reembolso máximo de 25€")
        ],
        ctaText: "Visitar web The North Face",
        daysLeft: 12
    )

    static let rayBan = Brand(
        name: "Ray-Ban",
        logoLetter: "RB",
        logoColor: Color(red: 0.8, green: 0.1, blue: 0.1),
        cashbackPercent: 10,
        expiryText: "Hasta el 15 de enero",
        description: "Encuentra la mejor selección de gafas de sol y graduadas. Hasta un 10% de cashback en la primera compra.",
        conditions: [
            BrandCondition(icon: "clock.arrow.circlepath", text: "Reembolso en un plazo estimado de 30 días"),
            BrandCondition(icon: "building.2", text: "Disponible en tiendas física y online"),
            BrandCondition(icon: "eurosign.circle", text: "Gasto mínimo de 100€, reembolso máximo de 25€")
        ],
        ctaText: "Visitar web Ray-Ban",
        daysLeft: 3
    )

    static let lego = Brand(
        name: "Lego",
        logoLetter: "LEGO",
        logoColor: Color(red: 0.9, green: 0.1, blue: 0.1),
        cashbackPercent: 8,
        expiryText: "Hasta el 28 de febrero",
        description: "Construye tu mundo con LEGO y ahorra un 8% de cashback.",
        conditions: [
            BrandCondition(icon: "clock.arrow.circlepath", text: "Reembolso en un plazo estimado de 30 días"),
            BrandCondition(icon: "building.2", text: "Disponible en tiendas física y online"),
            BrandCondition(icon: "eurosign.circle", text: "Gasto mínimo de 50€, reembolso máximo de 20€")
        ],
        ctaText: "Visitar web Lego",
        daysLeft: 30
    )

    static let featured: [Brand] = [europcar, vicio, northFace]
    static let allBrands: [Brand] = [rayBan, lego, europcar, vicio, northFace]
    static let popular: [Brand] = [europcar, vicio, northFace, lego]
}
