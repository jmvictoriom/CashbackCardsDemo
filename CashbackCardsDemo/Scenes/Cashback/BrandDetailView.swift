import SwiftUI

struct BrandDetailView: View {

    private enum Layout {
        static let hPadding: CGFloat = 16
        static let heroHeight: CGFloat = 350
        static let heroMinHeight: CGFloat = 180
        static let logoSize: CGFloat = 56
        static let cornerRadius: CGFloat = 20
        static let conditionSpacing: CGFloat = 16
    }

    let brand: Brand
    let namespace: Namespace.ID

    @State private var appeared = false
    @State private var scrollOffset: CGFloat = 0

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                heroImage
                detailContent
            }
        }
        .ignoresSafeArea(.container, edges: .top)
        .navigationTitle("Cashback")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) {
                appeared = true
            }
        }
    }

    // MARK: - Hero Image

    private var heroImage: some View {
        GeometryReader { geo in
            let offset = geo.frame(in: .global).minY
            let height = max(Layout.heroHeight + (offset > 0 ? offset : 0), Layout.heroMinHeight)
            let zoomScale = 1.0 + abs(min(offset, 0)) / 500.0

            ZStack(alignment: .bottomLeading) {
                // Background gradient simulating product image
                LinearGradient(
                    colors: [
                        brand.logoColor.opacity(0.6),
                        brand.logoColor.opacity(0.3),
                        Color(red: 0.95, green: 0.9, blue: 0.8)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .overlay {
                    // Decorative pattern
                    ZStack {
                        Circle()
                            .fill(brand.logoColor.opacity(0.15))
                            .frame(width: 200, height: 200)
                            .offset(x: 60, y: -30)

                        Circle()
                            .fill(brand.logoColor.opacity(0.1))
                            .frame(width: 150, height: 150)
                            .offset(x: -80, y: 40)

                        // Large SF Symbol watermark
                        Image(systemName: brand.heroSymbol)
                            .font(.system(size: 100, weight: .bold))
                            .foregroundStyle(brand.logoColor.opacity(0.12))
                            .rotationEffect(.degrees(-15))
                            .offset(x: 40, y: -20)
                    }
                }

                // Bottom gradient fade
                LinearGradient(
                    colors: [.clear, .clear, Color(.systemBackground).opacity(0.5), Color(.systemBackground)],
                    startPoint: .top,
                    endPoint: .bottom
                )

                // Brand info overlay
                HStack(spacing: 14) {
                    // Logo
                    ZStack {
                        Circle()
                            .fill(.white)
                            .frame(width: Layout.logoSize, height: Layout.logoSize)
                            .shadow(color: .black.opacity(0.1), radius: 8, y: 4)

                        Text(brand.logoLetter)
                            .font(.system(size: brand.logoLetter.count > 2 ? 12 : 20, weight: .bold))
                            .foregroundStyle(brand.logoColor)
                    }

                    VStack(alignment: .leading, spacing: 2) {
                        Text(brand.name)
                            .font(.title2.bold())
                            .foregroundStyle(.primary)
                    }
                }
                .padding(.horizontal, Layout.hPadding)
                .padding(.bottom, 20)
                .opacity(appeared ? 1 : 0)
                .offset(y: appeared ? 0 : 20)
            }
            .scaleEffect(zoomScale)
            .frame(width: geo.size.width, height: height)
            .clipped()
            .offset(y: offset > 0 ? -offset : 0)
        }
        .frame(height: Layout.heroHeight)
    }

    // MARK: - Detail Content

    private var detailContent: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Cashback badge
            Text("\(brand.cashbackPercent)% cashback")
                .font(.subheadline.bold())
                .foregroundStyle(.primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(Color(red: 1.0, green: 0.85, blue: 0.25))
                )
                .staggered(index: 0, appeared: $appeared)

            // CTA Button
            Button { } label: {
                Text(brand.ctaText)
                    .font(.subheadline.bold())
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(red: 1.0, green: 0.85, blue: 0.25))
                    )
            }
            .staggered(index: 1, appeared: $appeared)

            // Days left
            HStack(spacing: 6) {
                Image(systemName: "calendar")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text("Quedan \(brand.daysLeft) días")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity)
            .staggered(index: 2, appeared: $appeared)

            // Description
            Text(brand.description)
                .font(.body)
                .foregroundStyle(.primary)
                .staggered(index: 3, appeared: $appeared)

            // Fine print
            Text("Si la compra se realiza con tarjeta de crédito el reembolso aplicado será del \(brand.cashbackPercent)%. Si la compra se realiza con tarjeta de débito, el reembolso aplicado será del \(max(brand.cashbackPercent - 5, 2))%.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .staggered(index: 4, appeared: $appeared)

            // Conditions
            VStack(alignment: .leading, spacing: Layout.conditionSpacing) {
                ForEach(Array(brand.conditions.enumerated()), id: \.element.id) { index, condition in
                    HStack(alignment: .top, spacing: 14) {
                        Image(systemName: condition.icon)
                            .font(.body)
                            .foregroundStyle(.primary)
                            .frame(width: 28)

                        Text(condition.text)
                            .font(.subheadline)
                            .foregroundStyle(.primary)
                    }
                    .staggered(index: 5 + index, appeared: $appeared)

                    if index < brand.conditions.count - 1 {
                        Divider()
                    }
                }
            }
            .padding(.top, 8)

            // Bottom action buttons
            HStack(spacing: 12) {
                actionButton(title: "Encuentra la tienda", icon: "mappin.and.ellipse")
                actionButton(title: "Ver términos", icon: "doc.text")
            }
            .staggered(index: 8, appeared: $appeared)

            // CTA repeated at bottom
            Button { } label: {
                VStack(spacing: 4) {
                    Text("\(brand.cashbackPercent)% cashback")
                        .font(.caption.bold())
                        .foregroundStyle(.primary)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            Capsule()
                                .fill(Color(red: 1.0, green: 0.85, blue: 0.25))
                        )

                    Text(brand.ctaText)
                        .font(.subheadline.bold())
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(red: 0.15, green: 0.15, blue: 0.17))
                        )
                }
            }
            .staggered(index: 9, appeared: $appeared)

            // Days left bottom
            HStack(spacing: 6) {
                Image(systemName: "calendar")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text("Quedan \(brand.daysLeft) días")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, Layout.hPadding)
        .padding(.top, 8)
        .padding(.bottom, 40)
    }

    private func actionButton(title: String, icon: String) -> some View {
        Button { } label: {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.caption)
                Text(title)
                    .font(.caption.weight(.medium))
            }
            .foregroundStyle(.primary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
        }
    }
}

#Preview {
    @Previewable @Namespace var ns
    NavigationStack {
        BrandDetailView(brand: .rayBan, namespace: ns)
    }
}
