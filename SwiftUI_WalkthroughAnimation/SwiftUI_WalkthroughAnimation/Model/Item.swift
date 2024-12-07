//
//  Item.swift
//  SwiftUI_WalkthroughAnimation
//
//  Created by Dinesh Shaw on 03/12/24.
//
import SwiftUI

struct Item: Identifiable {
    var id: String = UUID().uuidString
    var image: String
    var title: String

    // optional
    var scale: CGFloat = 1
    var anchor: UnitPoint = .center
    var offset: CGFloat = 0
    var rotation: CGFloat = 0
    var zIndex: CGFloat = 0
    
    var extraOffset: CGFloat = -350
}

let items: [Item] = [
    .init(
        image: "dog.circle.fill",
        title: "Unmatched love, wagging tails, endless joy"
    ),
    .init(
        image: "cat.circle.fill",
        title: "Graceful charm, purrs, and cozy cuddles",
        scale: 0.6,
        anchor: .topLeading,
        offset: -70,
        rotation: 30
    ),
    .init(
        image: "hare.circle.fill",
        title: "Softest fur, quiet hops, gentle hearts",
        scale: 0.5,
        anchor: .bottomLeading,
        offset: -60,
        rotation: -35
    ),
    .init(
        image: "bird.circle.fill",
        title: "Tiny friends, endless songs, bright days",
        scale: 0.4,
        anchor: .bottomLeading,
        offset: -50,
        rotation: 160,
        extraOffset: -120
    ),
    .init(
        image: "fish.circle.fill",
        title: "Serene beauty, calming moments, vibrant life",
        scale: 0.35,
        anchor: .bottomLeading,
        offset: -50,
        rotation: 250,
        extraOffset: -100
    ),
]
