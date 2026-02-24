import Testing
import SwiftUI
@testable import CashbackCardsDemo

@Suite("CardDesign Model")
struct CardDesignTests {

    @Test("Exactly 5 designs exist")
    func designCount() {
        #expect(CardDesign.designs.count == 5)
    }

    @Test("Design names match expected set")
    func designNames() {
        let names = CardDesign.designs.map(\.name)
        #expect(names == ["Aurora", "Cosmos", "Nebula", "Solar", "Glaciar"])
    }

    @Test("Each design has exactly 2 thumbnail colors")
    func thumbnailColorCount() {
        for design in CardDesign.designs {
            #expect(design.thumbnailColors.count == 2, "\(design.name) should have 2 thumbnail colors")
        }
    }

    @Test("Each design gradient has 4 colors")
    func gradientColorCount() {
        for design in CardDesign.designs {
            #expect(design.gradient.colors.count == 4, "\(design.name) gradient should have 4 colors")
        }
    }

    @Test("CardDesign equality is identity-based")
    func designEquality() {
        let designs = CardDesign.designs
        // Same instance should be equal
        #expect(designs[0] == designs[0])
        // Different instances should differ (different UUIDs)
        #expect(designs[0] != designs[1])
    }
}
