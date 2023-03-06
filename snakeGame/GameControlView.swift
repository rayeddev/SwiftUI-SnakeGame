//
//  ContentView.swift
//  snakeGame1
//
//  Created by RAYED AL NOOM on 11/09/2022.
//

import SwiftUI



struct GameControlView: View {
    
    @EnvironmentObject var game: SankeGame
    
    
    
    var body: some View {
        ZStack
        {
            
            
            VStack
            {
                Button(action: {
                    game.restart()
                })
                {
                    Image(systemName: "gobackward")
                }
                .buttonStyle(.borderedProminent)

                
                
                
                SnakeGameView(game: game)
                
                
                
                
                Button(action: {
                    game.turn(diraction: .north)
                })
                {
                    Image(systemName: "arrow.up")
                }
                .buttonStyle(.borderedProminent)
                
                HStack
                {
                    
                    Button(action: {
                        game.turn(diraction: .west)
                    })
                    {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button(action: {
                        game.turn(diraction: .south)
                    })
                    {
                        Image(systemName: "arrow.down")
                            
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button(action: {
                        game.turn(diraction: .east)
                    })
                    {
                        Image(systemName: "arrow.right")
                    }
                    .buttonStyle(.borderedProminent)
                    
                }
            }
            
            if game.gameIsOver {
                ZStack
                {
                    Color.gray.opacity(0.80)
                    Text("Game Over")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                }
                .frame(height:100)
                
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    public static var game = SankeGame(boardWidth: 20)
    static var previews: some View {
        GameControlView()
            .environmentObject(game)
            .previewDevice("iPhone 13 Pro")
    }
}
