//
//  GameLogic.swift
//  snakeGame1
//
//  Created by RAYED AL NOOM on 11/09/2022.
//

import SwiftUI
import Combine


enum Diraction: Int {
    case east = 1
    case north = 2
    case west = -1
    case south = -2
}



struct GamePixel: Identifiable {
    var index: Int
    var id: Int {
        index
    }
}


class SankeGame: ObservableObject {
    @Published var tick: Int = 0
    @Published var gameIsOver: Bool = false
    var boardWidth: Int
    var snakeInitialSize: Int = 10
    var snake: Snake
    var boardPixls: [GamePixel]
    private var timeCancelable: AnyCancellable?
    let timer = Timer.publish(every: 0.30, on: .current, in: .default).autoconnect()
    
 
    
    func start()
    {
        self.gameIsOver = false
        timeCancelable = timer.sink(receiveValue: {
            t in
            
            if !self.snake.move()
            {
                self.timeCancelable?.cancel()
                self.gameIsOver = true
                return 
            }
            self.tick += 1
        })
    }
    
    public static func generateBoardPixels(size: Int) -> [GamePixel]
    {
        var _pixels = [GamePixel]()
        for i in 0..<(size)
        {
            _pixels.append(GamePixel(index: i))
        }
        
        return _pixels
    }
    
 
    
    init(boardWidth: Int, snakeInitialSize: Int = 10)
    {
        
        
        self.boardWidth = boardWidth
        self.snakeInitialSize = snakeInitialSize
        boardPixls = SankeGame.generateBoardPixels(size: boardWidth * boardWidth)
        snake = Snake(boardWidth: boardWidth, at: 91, bons: snakeInitialSize)
        
        start()
    
    }
    
    func turn(diraction: Diraction)
    {
        snake.turn(diraction: diraction)
    }
    
    func restart()
    {
        snake = Snake(boardWidth: boardWidth, at: 91, bons: snakeInitialSize)
        start()
        
    }
    

}
