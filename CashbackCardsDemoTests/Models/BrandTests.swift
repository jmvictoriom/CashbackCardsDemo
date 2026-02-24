import Testing
@testable import CashbackCardsDemo

@Suite("Brand Model")
struct BrandTests {

    // MARK: - A20: heroSymbol / gridSymbol

    @Test("Each brand has non-empty heroSymbol")
    func heroSymbolsExist() {
        for brand in Brand.allBrands {
            #expect(!brand.heroSymbol.isEmpty, "Brand \(brand.name) has empty heroSymbol")
        }
    }

    @Test("Each brand has non-empty gridSymbol")
    func gridSymbolsExist() {
        for brand in Brand.allBrands {
            #expect(!brand.gridSymbol.isEmpty, "Brand \(brand.name) has empty gridSymbol")
        }
    }

    @Test("Known brands have expected symbols")
    func knownBrandSymbols() {
        #expect(Brand.europcar.heroSymbol == "car.fill")
        #expect(Brand.vicio.heroSymbol == "fork.knife")
        #expect(Brand.northFace.heroSymbol == "mountain.2.fill")
        #expect(Brand.rayBan.heroSymbol == "sunglasses")
        #expect(Brand.lego.heroSymbol == "building.2.fill")
    }

    // MARK: - Collections

    @Test("Featured collection has exactly 3 brands")
    func featuredCount() {
        #expect(Brand.featured.count == 3)
    }

    @Test("AllBrands collection has exactly 5 brands")
    func allBrandsCount() {
        #expect(Brand.allBrands.count == 5)
    }

    @Test("Popular collection has exactly 4 brands")
    func popularCount() {
        #expect(Brand.popular.count == 4)
    }

    // MARK: - Hashable

    @Test("Brand equality is identity-based")
    func brandEquality() {
        let brand = Brand.europcar
        #expect(brand == brand)
        // Two different static instances always have different UUIDs
        #expect(Brand.europcar != Brand.vicio)
    }

    @Test("Brand can be inserted into a Set")
    func brandHashable() {
        var set = Set<Brand>()
        set.insert(Brand.europcar)
        set.insert(Brand.vicio)
        set.insert(Brand.europcar) // same instance
        #expect(set.count == 2)
    }
}
