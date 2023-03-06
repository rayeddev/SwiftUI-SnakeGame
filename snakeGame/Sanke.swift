//
//  Sanke.swift
//  snakeGame1
//
//  Created by RAYED AL NOOM on 06/03/2023.
//

import Foundation


struct Cell {
    
    var pos: Int
    var type: CellType
    var diraction: Diraction
    
    enum CellType {
        case head
        case body
        case tail
    }
}


class Snake {
    var boardWidth: Int
    var bons: Int
    var cells: [Cell] = []
    var cpos : Set<Int> = []
    var turns: [Int: Diraction] = [:]
    var head: Cell
    {
        return cells[0]
    }
    var tail: Cell
    {
        return cells.last!
    }
    
    var diraction: Diraction { head.diraction }
    
    
    init(boardWidth: Int, at: Int, bons: Int, diraction: Diraction = .east)
    {
        self.bons = bons
        self.boardWidth = boardWidth
        
        cells.append(Cell(pos: at, type: .head, diraction: diraction))
        cpos.insert(at)
        
        for i in (at - (bons - 2))..<(at)
        {
            cells.append(Cell(pos: i, type: .body, diraction: diraction))
            cpos.insert(i)
            
        }
        

        cells.append(Cell(pos: at - (bons - 1), type: .tail, diraction: diraction))
        cpos.insert(at - (bons - 1))
    }
    
    func isEdge(pos: Int) -> Bool
    {
        
        if diraction == .north
        {
            return (1...boardWidth).contains(pos)
        }
        
        
        
        if diraction == .east
        {
            return pos % boardWidth == 0
        }
        
        if diraction == .west
        {
            return (pos - 1) % boardWidth == 0
        }
        
        if diraction == .south
        {
            // bottom boxs
            return ((((boardWidth * boardWidth) - boardWidth) + 1)...(boardWidth * boardWidth)).contains(pos)
        }
        
        return false
    }
    
    public func move() -> Bool
    {

        let tailCopy = tail
        
        guard !isEdge(pos: head.pos) else {return false}
        
        // is collision
        guard  !(cells.filter {$0.type != .head}.map {$0.pos}).contains(head.pos) else {return false}
        
        cells = cells.map {
            
            var jump: Int = 1
            let dir = turns[$0.pos] ?? $0.diraction
            
            switch dir
            {
            case .east:
                jump = 1
            case .west:
                jump = -1
            case .north:
                jump = -boardWidth
            case .south:
                jump = boardWidth
            }
            
            return Cell(pos: $0.pos + jump, type: $0.type, diraction: dir)
            
        }
        cpos = Set( cells.map { $0.pos } )
        
        if tailCopy.diraction != tail.diraction
        {
            turns.removeValue(forKey: tailCopy.pos)
        }
        
        return true
    }
    
    func turn(diraction: Diraction)
    {
        guard abs( head.diraction.rawValue ) != abs(diraction.rawValue) else {return}
            
        turns[head.pos] = diraction
        cells[0].diraction = diraction
    }
    
    func isbone(pos: Int) -> Bool
    {
        return cpos.contains(pos)
    }
    
}
