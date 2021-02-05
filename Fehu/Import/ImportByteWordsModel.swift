//
//  ImportByteWordsModel.swift
//  Guardian
//
//  Created by Wolf McNally on 2/4/21.
//

import Combine

final class ImportByteWordsModel: ImportModel {
    required init() {
        super.init()
        validator = fieldValidator
            .validateByteWords(seedPublisher: seedPublisher)
    }

    override var name: String { "ByteWords" }
    override var typeName: String { "ByteWords" }
}

extension Publisher where Output == String, Failure == Never {
    func validateByteWords(seedPublisher: PassthroughSubject<Seed?, Never>) -> ValidationPublisher {
        map { string in
            do {
                let seed = try Seed(byteWords: string)
                seedPublisher.send(seed)
                return .valid
            } catch {
                seedPublisher.send(nil)
                return .invalid(error.localizedDescription)
            }
        }
        .dropFirst()
        .eraseToAnyPublisher()
    }
}
