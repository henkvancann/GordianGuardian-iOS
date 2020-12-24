//
//  ImportParentView.swift
//  Fehu
//
//  Created by Wolf McNally on 12/22/20.
//

import SwiftUI
import WolfSwiftUI

struct ImportParentView<ImportChildViewType>: View where ImportChildViewType: Importer {
    let importChildViewType: ImportChildViewType.Type
    @Binding var isPresented: Bool
    @State private var seed: Seed?
    @StateObject var model: ImportChildViewType.ModelType = ImportChildViewType.ModelType()
    let addSeed: (Seed) -> Void
    
    var body: some View {
        NavigationView {
            ImportChildViewType(model: model, seed: $seed)
                .padding()
                .navigationTitle("Import")
                .navigationBarItems(leading: cancelButton, trailing: doneButton)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onDisappear {
            if let seed = seed {
                addSeed(seed)
            }
        }
    }

    var cancelButton: some View {
        CancelButton {
            seed = nil
            isPresented = false
        }
    }

    var doneButton: some View {
        DoneButton {
            isPresented = false
        }
        .disabled(seed == nil)
    }
}
