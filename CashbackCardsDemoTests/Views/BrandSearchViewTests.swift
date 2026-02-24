import Testing
@testable import CashbackCardsDemo

@Suite("BrandSearchView Integration")
struct BrandSearchViewTests {

    /// Replicates the filteredBrands logic from BrandSearchView
    private func filteredBrands(searchText: String) -> [Brand] {
        if searchText.isEmpty {
            return Brand.popular
        }
        return Brand.allBrands.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    @Test("Empty search returns popular brands (4 items)")
    func emptySearchReturnsPopular() {
        let results = filteredBrands(searchText: "")
        #expect(results.count == 4)
    }

    @Test("Partial search 'euro' matches Europcar")
    func partialSearchMatch() {
        let results = filteredBrands(searchText: "euro")
        #expect(results.count == 1)
        #expect(results.first?.name == "Europcar")
    }

    @Test("Case insensitive search 'LEGO' matches Lego")
    func caseInsensitiveSearch() {
        let results = filteredBrands(searchText: "LEGO")
        #expect(results.count == 1)
        #expect(results.first?.name == "Lego")
    }

    @Test("Search with no match returns empty")
    func noMatchSearch() {
        let results = filteredBrands(searchText: "xyz123nonexistent")
        #expect(results.isEmpty)
    }
}
