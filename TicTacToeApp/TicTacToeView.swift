// Created for TicTacToe in 2022
// Using Swift 5.0

import SwiftUI

// Created in pair with chat.openai.com
struct TicTacToeView: View {
    @ObservedObject var game = ObservableGame()
    @State var refreshTrigger = false
    @State var buttonStates: [Bool] = Array(repeating: false, count: 9)

    var body: some View {
        VStack {
            ForEach(0..<3, id: \.self) { row in
                HStack {
                    ForEach(0..<3, id: \.self) { col in
                        ZStack {
                            Circle()
                                .fill(self.squareColor(at: (row, col)))
                                .frame(width: 100, height: 100)
                                .scaleEffect(buttonStates[row * 3 + col] ? 1.1 : 1)
                                .onTapGesture {
                                    do {
                                        try self.game.play(at: (row, col))
                                        withAnimation(
                                            Animation
                                                .easeInOut(duration: 0.2)
                                                .repeatCount(1, autoreverses: true)
                                        ) {
                                            self.buttonStates[row * 3 + col] = true
                                        }

                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                            withAnimation(
                                                Animation
                                                    .easeInOut(duration: 0.2)
                                                    .repeatCount(1, autoreverses: true)
                                            ) {
                                                self.buttonStates[row * 3 + col] = false
                                            }
                                        }

                                    } catch {
                                        print(error)
                                    }
                                }

                            Text(playerToken(at: (row, col)))
                                .font(.system(size: 60))
                                .foregroundColor(.white)
                                .frame(width: 100, height: 100)
                        }
                    }
                }
            }

            Text(game.game.currentState.description)
        }.id(refreshTrigger)
    }
}

extension TicTacToeView {
    func squareColor(at position: (row: Int, col: Int)) -> Color {
        let player = self.game.game.board.player(at: position)

        if player == "x" {
            return .red
        }

        if player == "o" {
            return .green
        }

        return .blue
    }

    func playerToken(at position: (row: Int, col: Int)) -> String {
        let player = self.game.game.board.player(at: position)

        if player == "x" {
            return "X"
        }

        if player == "o" {
            return "O"
        }

        return ""
    }
}
