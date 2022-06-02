//
//  DoubleEntensions.swift
//  Calculator
//
//  Created by 林祐辰 on 2022/5/27.
//

import Foundation


extension Double {
        
    func rounding(to demical:Int) -> Double {
        let numberOfDigits  = pow(10.0, Double(demical))
        return (self*numberOfDigits).rounded(.toNearestOrAwayFromZero)/numberOfDigits
        
    }
    
    func floor(to integer:Int) -> Double{
        let powerOfNumber = integer - 1
        let numberOfDigits  = pow(10.0, Double(powerOfNumber))
        return (self/numberOfDigits).rounded(.awayFromZero)*numberOfDigits
        
    }
    

}

