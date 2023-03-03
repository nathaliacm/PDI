//
//  ColorsModel.swift
//  CollectionView
//
//  Created by Nathalia Cardoso on 17/02/23.
//

import UIKit

struct ColorsModel: Hashable {
    let type: ColorType
    let color: UIColor
}

enum ColorType {
    case primary
    case secondary
}

let colorMockData = [
    ColorsModel(type: .primary, color: .red),
    ColorsModel(type: .primary, color: .yellow),
    ColorsModel(type: .primary, color: .blue),
    ColorsModel(type: .secondary, color: .orange),
    ColorsModel(type: .secondary, color: .green),
    ColorsModel(type: .secondary, color: .purple),
    ColorsModel(type: .secondary, color: .magenta),
    ColorsModel(type: .secondary, color: .gray),
    ColorsModel(type: .secondary, color: .systemCyan),
    ColorsModel(type: .secondary, color: .systemMint),
    ColorsModel(type: .secondary, color: .systemIndigo),
    ColorsModel(type: .secondary, color: .darkText)
]


