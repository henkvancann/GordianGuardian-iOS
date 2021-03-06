//
//  Scanner.swift
//  Gordian Guardian
//
//  Created by Wolf McNally on 12/24/20.
//

import SwiftUI
import URKit
import URUI

struct Scanner: View {
    @Binding var text: String
    @StateObject var scanState = URScanState(feedbackProvider: Feedback())
    @State var errorMessage: String?

    var body: some View {
        Group {
            if !scanState.isDone {
                VStack {
                    URVideo(scanState: scanState)
                    Spacer()
                    URProgressBar(value: $scanState.estimatedPercentComplete)
                        .padding()
                }
            } else if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            } else {
                EmptyView()
            }
        }
        .onReceive(scanState.$result) { result in
            switch result {
            case .ur(let ur):
                text = UREncoder.encode(ur)
            case .other(let text):
                self.text = text
            case .failure(let error):
                errorMessage = error.localizedDescription
            case nil:
                break
            }
        }
    }
}
