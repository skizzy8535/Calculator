//
//  CalculateViewController.swift
//  Calculator
//
//  Created by 林祐辰 on 2022/5/26.
//

import UIKit

class CalculateViewController: UIViewController {
    
    @IBOutlet var numberBtns: [UIButton]!
    @IBOutlet var operatorBtns: [UIButton]!
    @IBOutlet weak var numberLabel: UILabel!
  
     var firstNumHaveDialed = false
     var demicalPointDialed = false
     var expressionString = ""
     var calculateResult = 0
      
    override func viewDidLoad() {
        super.viewDidLoad()
        numberLabel.text = "0"
        numberLabel.adjustsFontSizeToFitWidth = true
        
        numberBtns.forEach { button in
            button.layer.cornerRadius = button.bounds.height / 2
        }
        
        operatorBtns.forEach { button in
            button.layer.cornerRadius = button.bounds.height / 2
        }
        
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        let pressedNum = sender.tag
        if firstNumHaveDialed{
            if numberLabel.text != "0"{
                numberLabel.text! += "\(pressedNum)"
            }else{
                numberLabel.text = ""
                numberLabel.text! += "\(pressedNum)"
            }
        }else{
            numberLabel.text = "\(pressedNum)"
            firstNumHaveDialed = true
            
        }
    }
    
    
    @IBAction func operatorPressed(_ sender: UIButton) {
    
        let operatorIndex = sender.tag
        
        guard let initNum = numberLabel.text else{return}
     
        
        var addedDouble :String = ""
        
        if demicalPointDialed{
            addedDouble += ""
        }else{
            if initNum.contains("."){
                addedDouble += ""
            }else{
                addedDouble += ".0"
            }
        }
        
        switch operatorIndex{
           case 0 :
             firstNumHaveDialed = false
             demicalPointDialed = false
             expressionString = ""
             calculateResult = 0
             numberLabel.text = "0"
           case 1 :
            calculateResult = 1
            
            if let addedNum = Int(numberLabel.text!),
                   addedNum != 0{
                
                  for i in 1...addedNum {
                      calculateResult*=i
                }
                
            }else{
                factorialErrorAlert()
            }
            
           case 2 :
            expressionString = initNum + addedDouble + "/"
           case 3 :
            expressionString = initNum + addedDouble + "*"
           case 4 :
            expressionString = initNum + addedDouble + "-"
           case 5 :
            expressionString = initNum + addedDouble + "+"
          default:
            break
        }
   
        firstNumHaveDialed = false
        demicalPointDialed = false
    }
    
    
    @IBAction func pointPressed(_ sender: UIButton) {
        if demicalPointDialed{
            demicalErrorAlert()
        }else{
            numberLabel.text! += "."
            firstNumHaveDialed = true
            demicalPointDialed = true
        }
    }
    
    
    @IBAction func equalPressed(_ sender: UIButton) {
   
        if let secondPressNum = Int(numberLabel.text!){
            expressionString += "\(secondPressNum)"
            print(expressionString)
        }
        
        let setExpression = NSExpression(format: expressionString)
        
        if let expressionValue = setExpression.expressionValue(with: nil, context: nil) as? Double {
            
                if expressionValue.truncatingRemainder(dividingBy: 1) == 0 {
                    numberLabel.text = String(expressionValue.floor(to: 1))
                } else {
                    numberLabel.text = String(expressionValue.rounding(to: 5))
                }
            }
            firstNumHaveDialed = false
            demicalPointDialed = false
            expressionString = ""
        }
                
    
    func demicalErrorAlert(){
        let alertController = UIAlertController(title:"Demical Error !", message: "There can only be one demical.", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)

        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    func factorialErrorAlert(){
     
        let alertController = UIAlertController(title:"Factorial Error !", message: "Factorial can only be integers.", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)

        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }

}
