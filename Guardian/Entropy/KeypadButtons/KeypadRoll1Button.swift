//
//  KeypadRoll1Button.swift
//  Gordian Guardian
//
//  Created by Wolf McNally on 12/8/20.
//

import SwiftUI

struct KeypadRollButton<KeypadType: Keypad>: View {
    let model: EntropyViewModel<KeypadType>
    let text: String
    let action: () -> Void

    var body: some View {
        KeypadFunctionButton(content: {
            VStack(spacing: 1) {
                Image(systemName: "die.face.3")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(minWidth: 10, minHeight: 10)
                Text(text)
            }
            .font(Font.system(.title).bold())
            .minimumScaleFactor(0.5)
        }, action: action)
    }
}

struct KeypadRoll1Button<KeypadType: Keypad>: View {
    let model: EntropyViewModel<KeypadType>

    var body: some View {
        KeypadRollButton(model: model, text: "1") {
            model.values.append(KeypadType.random())
        }
    }
}

struct KeypadRollAllButton<KeypadType: Keypad>: View {
    let model: EntropyViewModel<KeypadType>

    var body: some View {
        KeypadRollButton(model: model, text: "All") {
            while(model.entropyStrength != .veryStrong) {
                model.values.append(KeypadType.random())
            }
        }
    }
}
