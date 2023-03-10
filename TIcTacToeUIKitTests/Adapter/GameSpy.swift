// Created for TicTacToe in 2023
// Using Swift 5.0

import Foundation
@testable import TIcTacToeUIKit

class GameSpy: TicTacToe & Resetable & TicTacToeErrorTranslator {

    var invokedStatusGetter = false
    var invokedStatusGetterCount = 0
    var stubbedStatus: String = ""

    var status: String {
        invokedStatusGetter = true
        invokedStatusGetterCount += 1
        return stubbedStatus
    }

    var invokedStartedGetter = false
    var invokedStartedGetterCount = 0
    var stubbedStarted: Bool = false

    var started: Bool {
        invokedStartedGetter = true
        invokedStartedGetterCount += 1
        return stubbedStarted
    }

    var invokedPlay = false
    var invokedPlayCount = 0
    var invokedPlayParameters: Int?
    var invokedPlayParametersList = [Int]()
    var stubbedPlayError: Error?

    func play(at position: Int) throws {
        invokedPlay = true
        invokedPlayCount += 1
        invokedPlayParameters = position
        invokedPlayParametersList.append(position)
        if let error = stubbedPlayError {
            throw error
        }
    }

    var invokedReset = false
    var invokedResetCount = 0
    func reset() {
        invokedReset = true
        invokedResetCount += 1
    }

    var invokedHumanReadable = false
    var invokedHumanReadableCount = 0
    var invokedHumanReadableParameters: Error?
    var invokedHumanReadableParametersList = [Error]()
    var stubbedHumanReadableReturnValue: String?

    func humanReadable(error: Error) -> String {
        invokedHumanReadable = true
        invokedHumanReadableCount += 1
        invokedHumanReadableParameters = error
        invokedHumanReadableParametersList.append(error)

        return stubbedHumanReadableReturnValue ?? ""
    }

    var invokedBoardRepresentationGetter = false
    var invokedBoardRepresentationGetterCount = 0
    var stubbedBoardRepresentation: [String] = Array(repeating: "", count: 9)

    var boardRepresentation: [String] {
        invokedBoardRepresentationGetter = true
        invokedBoardRepresentationGetterCount += 1
        return stubbedBoardRepresentation
    }
}
