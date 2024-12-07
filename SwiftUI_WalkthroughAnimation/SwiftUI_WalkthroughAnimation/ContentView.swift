//
//  ContentView.swift
//  SwiftUI_WalkthroughAnimation
//
//  Created by Dinesh Shaw on 03/12/24.
//

import SwiftUI

struct ContentView: View {

    @State private var selectedItem: Item = items.first!
    @State private var introItems: [Item] = items
    @State private var activeIndex: Int = 0

    var body: some View {
        VStack(spacing: 0) {
            Button {
                print("here")
                updateItem(forward: false)
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title.bold())
                    .foregroundStyle(.blue)
                    .contentShape(.rect)
            }
            .padding(15)
            .frame(maxWidth: .infinity, alignment: .leading)
            .opacity(selectedItem.id != introItems.first?.id ? 1 : 0)

            ZStack {
                ForEach(introItems) { item in
                    AnimatedIconView(item)
                }
            }
            .frame(height: 250)
            .frame(maxHeight: .infinity)

            VStack(spacing: 6) {
                HStack(spacing: 6) {
                    ForEach(Array(introItems.enumerated()), id: \.offset) {
                        index, item in
                        Capsule()
                            .fill(
                                selectedItem.id == item.id
                                    ? Color.primary : .gray
                            )
                            .frame(
                                width: selectedItem.id == item.id ? 16 : 8,
                                height: 8
                            )
                            .onTapGesture {
                                withAnimation(.snappy) {
                                    let prevIndex = activeIndex
                                    print(index, prevIndex)

                                    activeIndex =
                                        prevIndex < index
                                        ? index - 1 : index + 1

                                    if index != prevIndex {
                                        updateItem(forward: prevIndex < index)

                                    }
                                }
                            }
                    }
                }

                Text(selectedItem.title)
                    .font(.title.bold())
                    .contentTransition(.numericText())

                Text("Healthy brain lives in a healthy body")
                    .padding(.top, 10)
                    .font(.footnote)
                    .foregroundStyle(.gray)

                Button {
                    updateItem(forward: true)
                } label: {
                    Text(
                        selectedItem.id == introItems.last?.id
                            ? "Continue" : "Next"
                    )
                    .fontWeight(.semibold)
                    .frame(width: 250)
                    .padding(.vertical, 12)
                    .background(.green.gradient, in: .capsule)
                    .foregroundStyle(.white)
                }
                .padding(.top, 25)
            }
            .multilineTextAlignment(.center)
            .frame(width: 300)
            .frame(maxHeight: .infinity)
        }
    }

    @ViewBuilder
    func AnimatedIconView(_ item: Item) -> some View {
        let isSelected = selectedItem.id == item.id

        Image(systemName: item.image)
            .font(.system(size: 80))
            .foregroundStyle(.white.shadow(.drop(radius: 10)))
            .frame(width: 120, height: 120)
            .background(.green.gradient, in: .rect(cornerRadius: 32))
            .background {
                RoundedRectangle(cornerRadius: 35)
                    .fill(.background)
                    .shadow(color: .primary.opacity(0.2), radius: 1, x: 1, y: 1)
                    .shadow(
                        color: .primary.opacity(0.2), radius: 1, x: -1, y: -1
                    )
                    .padding(-3)
                    .opacity(isSelected ? 1 : 0)
            }
            .rotationEffect(.init(degrees: -item.rotation))  // resetting rotation
            .scaleEffect(isSelected ? 1 : item.scale, anchor: item.anchor)
            .offset(x: item.offset)
            .rotationEffect(.init(degrees: item.rotation))
            .zIndex(isSelected ? 2 : item.zIndex)
    }

    // Shifting of icon

    func updateItem(forward: Bool) {
        guard activeIndex != (forward ? introItems.count - 1 : 0) else {
            return
        }

        var fromIndex: Int
        var extraOffset: CGFloat

        if forward {
            activeIndex += 1

            fromIndex = activeIndex - 1
            extraOffset = introItems[activeIndex].extraOffset
        } else {
            activeIndex -= 1

            fromIndex = activeIndex + 1
            extraOffset = introItems[activeIndex].extraOffset
        }

        // Reset zIndex
        for index in introItems.indices {
            introItems[index].zIndex = 0
        }

        Task { [fromIndex, extraOffset] in
            withAnimation(.bouncy(duration: 1)) {
                introItems[fromIndex].scale = introItems[activeIndex].scale
                introItems[fromIndex].rotation =
                    introItems[activeIndex].rotation
                introItems[fromIndex].anchor = introItems[activeIndex].anchor
                introItems[fromIndex].offset = introItems[activeIndex].offset

                introItems[activeIndex].offset = extraOffset

                introItems[fromIndex].zIndex = 1

            }

            try? await Task.sleep(for: .seconds(0.1))

            withAnimation(.bouncy(duration: 0.9)) {

                // To positon location change
                introItems[activeIndex].scale = 1
                introItems[activeIndex].rotation = .zero
                introItems[activeIndex].anchor = .center
                introItems[activeIndex].offset = .zero

                // Update selectedItem
                selectedItem = introItems[activeIndex]

            }
        }
    }
}

#Preview {
    ContentView()
}
