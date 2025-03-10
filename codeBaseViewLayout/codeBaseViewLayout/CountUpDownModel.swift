//
//  CountUpDownModel.swift
//  codeBaseViewLayout
//
//  Created by nelime on 3/10/25.
//

struct CountUpDownModel {
    var count: Int = 0
    
    mutating func increaseCount() {
        self.count += 1
    }
    
    mutating func decreaseCount() {
        self.count -= 1
    }
}
