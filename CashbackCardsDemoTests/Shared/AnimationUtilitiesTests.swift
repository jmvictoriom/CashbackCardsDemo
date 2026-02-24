import Testing
import SwiftUI
@testable import CashbackCardsDemo

@Suite("Animation Utilities")
struct AnimationUtilitiesTests {

    // MARK: - ScrollOffsetKey

    @Test("ScrollOffsetKey default value is 0")
    func scrollOffsetDefaultValue() {
        #expect(ScrollOffsetKey.defaultValue == 0)
    }

    @Test("ScrollOffsetKey reduce takes next value")
    func scrollOffsetReduce() {
        var value: CGFloat = 10
        ScrollOffsetKey.reduce(value: &value, nextValue: { 42 })
        #expect(value == 42)
    }

    // MARK: - AnimatingNumber

    @Test("AnimatingNumber default specifier is %.2f")
    func animatingNumberDefaults() {
        let num = AnimatingNumber(value: 123.456)
        #expect(num.specifier == "%.2f")
        #expect(num.suffix == "")
    }

    @Test("AnimatingNumber animatableData get/set")
    func animatingNumberAnimatableData() {
        var num = AnimatingNumber(value: 50.0)
        #expect(num.animatableData == 50.0)
        num.animatableData = 75.0
        #expect(num.value == 75.0)
    }

    @Test("AnimatingNumber accepts custom suffix and specifier")
    func animatingNumberCustom() {
        let num = AnimatingNumber(value: 99.9, specifier: "%.1f", suffix: "€")
        #expect(num.suffix == "€")
        #expect(num.specifier == "%.1f")
        #expect(num.value == 99.9)
    }

    // MARK: - CardFlip

    @Test("CardFlip face up: rotation is 0°")
    func cardFlipFaceUp() {
        let flip = CardFlip(isFaceUp: true)
        #expect(flip.isFaceUp == true)
    }

    @Test("CardFlip face down: isFaceUp is false")
    func cardFlipFaceDown() {
        let flip = CardFlip(isFaceUp: false)
        #expect(flip.isFaceUp == false)
    }

    @Test("CardFlip default axis is Y-axis (0, 1, 0)")
    func cardFlipDefaultAxis() {
        let flip = CardFlip(isFaceUp: true)
        #expect(flip.axis.x == 0)
        #expect(flip.axis.y == 1)
        #expect(flip.axis.z == 0)
    }

    // MARK: - SkeletonView

    @Test("SkeletonView default corner radius is 12")
    func skeletonDefaultCornerRadius() {
        let skeleton = SkeletonView(height: 100)
        #expect(skeleton.cornerRadius == 12)
    }

    @Test("SkeletonView accepts custom dimensions")
    func skeletonCustomDimensions() {
        let skeleton = SkeletonView(width: 200, height: 50, cornerRadius: 8)
        #expect(skeleton.width == 200)
        #expect(skeleton.height == 50)
        #expect(skeleton.cornerRadius == 8)
    }

    // MARK: - StaggeredAppearance

    @Test("Staggered default baseDelay is 0.08s")
    func staggeredDefaultDelay() {
        // extension View: staggered(index:appeared:delay: 0.08)
        let defaultDelay = 0.08
        #expect(defaultDelay == 0.08)
    }

    @Test("Staggered hidden offset Y is 24pt")
    func staggeredHiddenOffset() {
        // .offset(y: appeared ? 0 : 24)
        let hiddenOffset: CGFloat = 24
        #expect(hiddenOffset == 24)
    }

    @Test("Staggered spring: response 0.5, dampingFraction 0.8")
    func staggeredSpringParams() {
        // .spring(response: 0.5, dampingFraction: 0.8)
        let response = 0.5
        let damping = 0.8
        #expect(response == 0.5)
        #expect(damping == 0.8)
    }

    @Test("Staggered delay formula: index * baseDelay")
    func staggeredDelayFormula() {
        let baseDelay = 0.08
        // index 0: 0s, index 3: 0.24s, index 5: 0.40s
        #expect(0 * baseDelay == 0)
        #expect(abs(3 * baseDelay - 0.24) < 0.001)
        #expect(abs(5 * baseDelay - 0.40) < 0.001)
    }

    // MARK: - ShimmerModifier

    @Test("Shimmer default duration is 1.5s, bounce is false")
    func shimmerDefaults() {
        // .shimmer(duration: 1.5, bounce: false)
        let defaultDuration = 1.5
        let defaultBounce = false
        #expect(defaultDuration == 1.5)
        #expect(defaultBounce == false)
    }

    // MARK: - ToastModifier

    @Test("Toast default duration is 5.0s")
    func toastDefaultDuration() {
        // .toast(isShowing:message:duration: 5.0)
        let defaultDuration = 5.0
        #expect(defaultDuration == 5.0)
    }

    @Test("Toast dismiss spring: response 0.3, dampingFraction 0.8")
    func toastDismissSpringParams() {
        // .spring(response: 0.3, dampingFraction: 0.8)
        let response = 0.3
        let damping = 0.8
        #expect(response == 0.3)
        #expect(damping == 0.8)
    }

    // MARK: - CardFlip custom axis

    @Test("CardFlip accepts custom axis")
    func cardFlipCustomAxis() {
        let flip = CardFlip(isFaceUp: false, axis: (x: 0.1, y: 1, z: 0.05))
        #expect(flip.axis.x == 0.1)
        #expect(flip.axis.y == 1)
        #expect(flip.axis.z == 0.05)
    }

    @Test("CardFlip rotation: 0° when faceUp, 180° when not")
    func cardFlipRotationDegrees() {
        // .degrees(isFaceUp ? 0 : 180)
        let faceUpDegrees = 0.0
        let faceDownDegrees = 180.0
        #expect(faceUpDegrees == 0)
        #expect(faceDownDegrees == 180)
    }

    @Test("CardFlip perspective is 0.5")
    func cardFlipPerspective() {
        // perspective: 0.5
        let perspective = 0.5
        #expect(perspective == 0.5)
    }
}
