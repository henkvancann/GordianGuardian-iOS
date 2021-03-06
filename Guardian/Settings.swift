//
//  Settings.swift
//  Guardian
//
//  Created by Wolf McNally on 1/30/21.
//

import SwiftUI

fileprivate let appDefaultNetwork: Network = .testnet

final class Settings: ObservableObject {
    var storage: SettingsStorage
    
    @Published var defaultNetwork: Network {
        didSet {
            storage.defaultNetwork = defaultNetwork
        }
    }
    
    init(storage: SettingsStorage) {
        self.storage = storage
        defaultNetwork = storage.defaultNetwork
    }
}

protocol SettingsStorage {
    var defaultNetwork: Network { get set }
}

struct MockSettingsStorage: SettingsStorage {
    var defaultNetwork: Network = appDefaultNetwork
}

extension UserDefaults: SettingsStorage {
    var defaultNetwork: Network {
        get { Network(id: string(forKey: "defaultNetwork") ?? appDefaultNetwork.id) ?? appDefaultNetwork }
        set { setValue(newValue.id, forKey: "defaultNetwork") }
    }
}
