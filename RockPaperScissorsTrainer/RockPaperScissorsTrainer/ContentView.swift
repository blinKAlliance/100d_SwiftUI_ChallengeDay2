//
//  ContentView.swift
//  RockPaperScissorsTrainer
//
//  Created by Jordan Kramer on 6/7/22.
//

import SwiftUI

struct ContentView: View {
    var possibleMoves: Array<String> = ["Rock", "Paper", "Scissors"]
    @State var playerSelectedMove: String = ""
    @State var computerSelectedMove: Int = Int.random(in: 0...2)
    @State var playerShouldWin: Bool = Bool.random()
    @State var roundsPlayed: Int = 0
    @State var score: Int = 0
    @State var isGameOver: Bool = false
    @State var correctAnswer: Bool = false
    @State var answerSelected: Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .white, .pink]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                VStack {
                    Text("Rock Paper Scissors Trainer")
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    Spacer()
                    Image(possibleMoves[computerSelectedMove])
                        .resizable()
                        .frame(width: 250.0, height: 250.0)

                    Text("Computer Selection: \(possibleMoves[computerSelectedMove])")
                        .padding()
                    Text("Round \(roundsPlayed): \(playerShouldWin ? "Win" : "Lose") the game.")
                }
                VStack {
                    Spacer()
                    Image(playerSelectedMove)
                        .resizable()
                        .frame(width: 250.0, height: 250.0)
                    HStack {
                        Button("Rock", action: {
                            selectMove(selectedMove: "Rock")
                        })
                        .padding()
                        .frame(minWidth: 110)
                        .background(Color.black.cornerRadius(8))
                        .foregroundColor(.white)
                        
                        Button("Paper", action: {
                            selectMove(selectedMove: "Paper")
                        })
                        .padding()
                        .frame(minWidth: 110)
                        .background(Color.black.cornerRadius(8))
                        .foregroundColor(.white)
                        
                        Button("Scissors", action: {
                            selectMove(selectedMove: "Scissors")
                        })
                        .padding()
                        .frame(minWidth: 110)
                        .background(Color.black.cornerRadius(8))
                        .foregroundColor(.white)
                    }
                    Spacer()
                    Spacer()
                    Text("Score: \(score) / \(roundsPlayed)")
                }
                .alert("Game Over", isPresented: $isGameOver ) {
                    Button("New Game", action: {
                        score = 0
                        roundsPlayed = 0
                        isGameOver = false
                    })
                } message: {
                    Text("Your score is \(score) / \(roundsPlayed)")
                }
                .alert("\(correctAnswer ? "Correct" : "Incorrect")", isPresented: $answerSelected ) {
                    Button("Next", action: {
                        generateNextQuestion()
                    })
                }
            }
        }
    }
    
    func selectMove(selectedMove: String) -> Void {
        playerSelectedMove = selectedMove
        determineWinner()
    }
    
    func determineWinner() {
        let tempScore: Int = score
        if (possibleMoves[computerSelectedMove] == "Rock") {
            if ((playerShouldWin && playerSelectedMove == "Paper") || (!playerShouldWin && playerSelectedMove == "Scissors")) {
                score += 1
            }
        }
        if (possibleMoves[computerSelectedMove] == "Paper") {
            if ((playerShouldWin && playerSelectedMove == "Scissors") || (!playerShouldWin && playerSelectedMove == "Rock")) {
                score += 1
            }
        }
        if (possibleMoves[computerSelectedMove] == "Scissors") {
            if ((playerShouldWin && playerSelectedMove == "Rock") || (!playerShouldWin && playerSelectedMove == "Paper")) {
                score += 1
            }
        }
        roundsPlayed += 1
        
        if (roundsPlayed > 9) {
            isGameOver = true
        }
        correctAnswer = tempScore == score ? false : true
        answerSelected = true;
    }
    
    func generateNextQuestion() {
        computerSelectedMove = Int.random(in: 0...2)
        playerShouldWin = Bool.random()
        playerSelectedMove = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
