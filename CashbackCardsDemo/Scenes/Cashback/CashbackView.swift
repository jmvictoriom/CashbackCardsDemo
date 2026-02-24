import SwiftUI

struct CashbackView: View {

    private enum Layout {
        static let hPadding: CGFloat = 16
        static let sectionSpacing: CGFloat = 20
        static let cardCorner: CGFloat = 14
        static let featuredCorner: CGFloat = 20
        static let chipHeight: CGFloat = 38
        static let brandCardWidth: CGFloat = 140
        static let brandGridHeight: CGFloat = 160
        static let loadDelay: Double = 1.2
    }

    @State private var isLoading = true
    @State private var appeared = false
    @State private var showToast = false
    @State private var showSearch = false
    @State private var showOnboarding = true
    @State private var selectedBrand: Brand?
    @Namespace private var heroNamespace

    private let monthlySaved: Double = 47.80
    private let totalAccumulated: Double = 312.45
    private let filters = ["Marca", "Categoría", "Ubicación"]

    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: Layout.sectionSpacing) {
                    savingsSection
                    filterChips
                    featuredSection
                    brandGrid
                }
                .padding(.bottom, 80)
            }
            .toast(isShowing: $showToast, message: "Comparte con tus amigos y gana 50€ en cashback")
        }
        .navigationTitle("Cashback")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(false)
        .sheet(isPresented: $showOnboarding) {
            CashbackOnboardingSheet()
                .presentationDetents([.large])
        }
        .sheet(isPresented: $showSearch) {
            BrandSearchView()
        }
        .navigationDestination(item: $selectedBrand) { brand in
            BrandDetailView(brand: brand, namespace: heroNamespace)
        }
        .onAppear {
            // Simulate loading
            DispatchQueue.main.asyncAfter(deadline: .now() + Layout.loadDelay) {
                withAnimation(.easeOut(duration: 0.3)) {
                    isLoading = false
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation {
                        appeared = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                        showToast = true
                    }
                }
            }
        }
    }

    // MARK: - Savings Cards

    private var savingsSection: some View {
        HStack(spacing: 12) {
            if isLoading {
                SkeletonView(height: 90)
                SkeletonView(height: 90)
            } else {
                // Monthly saved
                VStack(alignment: .leading, spacing: 6) {
                    Text("Este mes has\nahorrado:")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)

                    AnimatingNumber(
                        value: appeared ? monthlySaved : 0,
                        specifier: "%.2f",
                        suffix: " €",
                        font: .title2.bold()
                    )
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: Layout.cardCorner)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
                .staggered(index: 0, appeared: $appeared)

                // Total accumulated
                VStack(alignment: .leading, spacing: 6) {
                    Text("Total\nacumulado")
                        .font(.caption)
                        .foregroundStyle(.primary.opacity(0.8))
                        .lineLimit(2)

                    AnimatingNumber(
                        value: appeared ? totalAccumulated : 0,
                        specifier: "%.2f",
                        suffix: " €",
                        font: .title2.bold()
                    )
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: Layout.cardCorner)
                        .fill(Color(red: 1.0, green: 0.85, blue: 0.25))
                )
                .staggered(index: 1, appeared: $appeared)
            }
        }
        .padding(.horizontal, Layout.hPadding)
        .padding(.top, 8)
    }

    // MARK: - Filter Chips

    private var filterChips: some View {
        Group {
            if isLoading {
                HStack(spacing: 10) {
                    SkeletonView(width: 38, height: 38, cornerRadius: 19)
                    ForEach(0..<3, id: \.self) { _ in
                        SkeletonView(width: 90, height: 38, cornerRadius: 19)
                    }
                }
                .padding(.horizontal, Layout.hPadding)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        Button {
                            showSearch = true
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .font(.body.weight(.medium))
                                .foregroundStyle(.primary)
                                .frame(width: Layout.chipHeight, height: Layout.chipHeight)
                                .background(
                                    Circle()
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                )
                        }

                        ForEach(filters, id: \.self) { filter in
                            HStack(spacing: 4) {
                                Text(filter)
                                    .font(.subheadline.weight(.medium))
                                Image(systemName: "chevron.down")
                                    .font(.caption2.weight(.semibold))
                            }
                            .foregroundStyle(.primary)
                            .padding(.horizontal, 16)
                            .frame(height: Layout.chipHeight)
                            .background(
                                Capsule()
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                        }
                    }
                    .padding(.horizontal, Layout.hPadding)
                }
                .staggered(index: 2, appeared: $appeared)
            }
        }
    }

    // MARK: - Featured Section

    private var featuredSection: some View {
        Group {
            if isLoading {
                SkeletonView(height: 280)
                    .padding(.horizontal, Layout.hPadding)
            } else {
                VStack(alignment: .leading, spacing: 14) {
                    // Header
                    HStack {
                        Text("Destacados")
                            .font(.title3.bold())
                            .foregroundStyle(.white)

                        Spacer()

                        HStack(spacing: 16) {
                            Button { } label: {
                                Image(systemName: "chevron.left")
                                    .font(.caption.bold())
                                    .foregroundStyle(.white.opacity(0.6))
                            }
                            Button { } label: {
                                Image(systemName: "chevron.right")
                                    .font(.caption.bold())
                                    .foregroundStyle(.white.opacity(0.6))
                            }
                        }
                    }

                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit in id tortor.")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.7))

                    // Horizontal brand cards
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(Brand.featured) { brand in
                                featuredBrandCard(brand)
                                    .onTapGesture {
                                        selectedBrand = brand
                                    }
                            }
                        }
                    }
                }
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: Layout.featuredCorner)
                        .fill(Color(red: 0.15, green: 0.15, blue: 0.17))
                )
                .padding(.horizontal, Layout.hPadding)
                .staggered(index: 3, appeared: $appeared)
            }
        }
    }

    private func featuredBrandCard(_ brand: Brand) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            // Logo circle
            ZStack {
                Circle()
                    .fill(brand.logoColor)
                    .frame(width: 48, height: 48)

                Text(brand.logoLetter)
                    .font(.system(size: brand.logoLetter.count > 2 ? 10 : 18, weight: .bold))
                    .foregroundStyle(.white)
            }

            Text(brand.name)
                .font(.subheadline.bold())
                .foregroundStyle(.white)
                .lineLimit(1)

            Text("\(brand.cashbackPercent)% cashback")
                .font(.caption)
                .foregroundStyle(.white.opacity(0.7))

            Text(brand.expiryText)
                .font(.caption2)
                .foregroundStyle(.white.opacity(0.5))
        }
        .frame(width: Layout.brandCardWidth)
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color(red: 0.22, green: 0.22, blue: 0.24))
        )
    }

    // MARK: - Brand Grid

    private var brandGrid: some View {
        Group {
            if isLoading {
                HStack(spacing: 12) {
                    SkeletonView(height: Layout.brandGridHeight)
                    SkeletonView(height: Layout.brandGridHeight)
                }
                .padding(.horizontal, Layout.hPadding)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(Array(Brand.allBrands.enumerated()), id: \.element.id) { index, brand in
                            brandGridItem(brand, index: index)
                                .onTapGesture {
                                    selectedBrand = brand
                                }
                        }
                    }
                    .padding(.horizontal, Layout.hPadding)
                }
                .staggered(index: 4, appeared: $appeared)
            }
        }
    }

    private func brandGridItem(_ brand: Brand, index: Int) -> some View {
        VStack(spacing: 8) {
            // Brand image placeholder
            RoundedRectangle(cornerRadius: 14)
                .fill(
                    LinearGradient(
                        colors: [brand.logoColor.opacity(0.3), brand.logoColor.opacity(0.1)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: Layout.brandGridHeight, height: Layout.brandGridHeight)
                .overlay {
                    ZStack {
                        // Large SF Symbol background decoration
                        Image(systemName: brand.gridSymbol)
                            .font(.system(size: 60, weight: .bold))
                            .foregroundStyle(brand.logoColor.opacity(0.15))
                            .offset(x: 20, y: -10)

                        VStack(spacing: 6) {
                            ZStack {
                                Circle()
                                    .fill(brand.logoColor)
                                    .frame(width: 44, height: 44)

                                Text(brand.logoLetter)
                                    .font(.system(size: brand.logoLetter.count > 2 ? 9 : 16, weight: .bold))
                                    .foregroundStyle(.white)
                            }

                            Text(brand.name)
                                .font(.caption.bold())
                                .foregroundStyle(.primary)
                        }
                    }
                }

            Text(brand.name)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    NavigationStack {
        CashbackView()
    }
}
