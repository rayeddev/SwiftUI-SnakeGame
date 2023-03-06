//
//  BoardView.swift
//  snakeGame1
//
//  Created by RAYED AL NOOM on 04/03/2023.
//

import SwiftUI

struct SnakeGameView: View {
    @ObservedObject var game: SankeGame

    
    var body: some View {
        ZStack
        {
            GeometryReader {
                geo in
                
                ZStack(alignment: .center) {
                    LazyVGrid(columns: Array.init(repeating: GridItem(.fixed(geo.size.width / CGFloat(game.boardWidth)),spacing: 0), count: game.boardWidth), spacing: 0)
                    {
                        ForEach(game.boardPixls)
                        {
                            box in
                            
                            
                            Rectangle()
                                .fill(game.snake.isbone(pos: box.index + 1) ? .blue  : .white)
                                .overlay
                            {
                                
                                
                                Rectangle()
                                    .stroke(.gray, lineWidth: 0.3)
                                
                                
                            }
                            .aspectRatio(1.0,contentMode: .fit)
                            
                            
                        }
                    }
                }
                .frame(maxHeight: .infinity)
                
            }
            
            .padding()
            .background(.yellow)
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        SnakeGameView(game: SankeGame(boardWidth: 20))
    }
}
