import SwiftUI

struct BrandSearchView: View {

    private enum Layout {
        static let hPadding: CGFloat = 16
        static let logoSize: CGFloat = 44
        static let rowHeight: CGFloat = 60
    }

    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    @State private var appeared = false

    private var filteredBrands: [Brand] {
        if searchText.isEmpty {
            return Brand.popular
        }
        return Brand.allBrands.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                // Search bar
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .font(.body)
                        .foregroundStyle(.secondary)

                    TextField("Buscar marcas...", text: $searchText)
                        .font(.body)
                        .textFieldStyle(.plain)
                        .autocorrectionDisabled()
                }
                .padding(.horizontal, Layout.hPadding)
                .padding(.vertical, 12)

                Divider()
                    .padding(.horizontal, Layout.hPadding)

                // Section title
                if searchText.isEmpty {
                    Text("Más buscados")
                        .font(.title3.bold())
                        .padding(.horizontal, Layout.hPadding)
                        .padding(.top, 20)
                        .padding(.bottom, 8)
                }

                // Results
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(Array(filteredBrands.enumerated()), id: \.element.id) { index, brand in
                            brandRow(brand)
                                .staggered(index: index, appeared: $appeared)
                        }
                    }
                }

                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cerrar") {
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            withAnimation {
                appeared = true
            }
        }
    }

    private func brandRow(_ brand: Brand) -> some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(brand.logoColor)
                    .frame(width: Layout.logoSize, height: Layout.logoSize)

                Text(brand.logoLetter)
                    .font(.system(size: brand.logoLetter.count > 2 ? 10 : 16, weight: .bold))
                    .foregroundStyle(.white)
            }

            Text(brand.name)
                .font(.body)
                .foregroundStyle(.primary)

            Spacer()
        }
        .padding(.horizontal, Layout.hPadding)
        .frame(height: Layout.rowHeight)
    }
}

#Preview {
    BrandSearchView()
}
