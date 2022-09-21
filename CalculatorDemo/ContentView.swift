//
//  ContentView.swift
//  CalculatorDemo
//
//  Created by Sander Hafstad on 09/09/2022.
//

import SwiftUI

//let hei: Array<String> = ""

enum CalcButton: String{
    case one        = "1"
    case two        = "2"
    case three      = "3"
    case four       = "4"
    case five       = "5"
    case six        = "6"
    case seven      = "7"
    case eight      = "8"
    case nine       = "9"
    case zero       = "0"
    case plus       = "+"
    case subsract   = "-"
    case divide     = "/"
    case multiply   = "x"
    case equal      = "="
    case clear      = "AC"
    case decimal    = "."
    case percent    = "%"
    case negative   = "+/-"
    // case blank = "🖕🏼"
    
    var buttonColor: Color{
        switch self{
        case .plus, .subsract, .multiply, .divide, .equal:
            return .orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
    
}

enum Opration {
    case plus, substract, multiply, divide, none
}

struct ContentView: View {
    
    @State var value = "0"
    
    @State var runningNumber: Double = 0
    
    @State var currnetOpration: Opration = .none
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subsract],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equal]
    ]
    
    let calc = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
        
    
    var body: some View {
        
        // Text display
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                HStack {
                    Spacer()
                    Text(value)
                        .bold()
                        .lineLimit(1)
                        .minimumScaleFactor(0.10) // 72*0.5
                        .font(.system(size: 72))
                        .foregroundColor(.white)
                }
                
                .padding()
                //our buttons
                VStack {
                    ForEach(buttons, id: \.self) { row in
                        HStack {
                            
                                ForEach(row, id: \.self) { item in
                                    Button(action: {
                                        self.didTap(button: item)
                                    }, label: {
                                        Text(item.rawValue)
                                            .font(.system(size: 32))
                                            //.frame(width: 80, height: 80)
                                            .frame(width: self.buttonWidth(item: item),
                                                   height: self.buttonHeight()
                                            )
                                            .background(item.buttonColor)
                                            .foregroundColor(.white)
                                            //.cornerRadius(40)
                                            .cornerRadius(self.buttonWidth(item: item)/2)
                                      
                                        
                                    })
                                    
                                }
                                
                            }
                            .padding(.bottom, 3)
                        }
                     
                }
                
            }
        }
    }
    func didTap(button: CalcButton){
        switch button{
        case .plus, .subsract, .multiply, .divide, .equal:
            if button == .plus{
                self.currnetOpration = .plus
                self.runningNumber = Double(self.value) ?? 0
            }
            else if button == .subsract{
                self.currnetOpration = .substract
                self.runningNumber = Double(self.value) ?? 0
            }
            else if button == .multiply{
                self.currnetOpration = .multiply
                self.runningNumber = Double(self.value) ?? 0
            }
            else if button == .divide{
                self.currnetOpration = .divide
                self.runningNumber = Double(self.value) ?? 0
            }
            
            else if button == .equal{
                let runningValue = self.runningNumber
                let currentValue = Double(self.value) ?? 0
                
                switch self.currnetOpration {
                case .plus: self.value = "\(runningValue + currentValue)"
                case .substract: self.value = "\(runningValue - currentValue)"
                case .multiply: self.value = "\(runningValue * currentValue)"
                case .divide: self.value = "\(runningValue / currentValue)"
               // case .decimal: self.value = "\(runningValue "\(.)" currentValue)"
                case .none:
                    
                    break
                    
                }
                
                if let parsedDouble = Double(value), Double(Int(parsedDouble)) == parsedDouble {
                    value = String(Int(parsedDouble))
                }
                
            }
            
            if button != .equal{
                self.value = "0"
            }
        case .clear:
            self.value = "0"
            
        case .negative, .percent:
            
            break
        default:
            let number = button.rawValue
            if self.value == "0"{
                value = number
            } else{
                self.value = "\(self.value)\(number)"
            }
        }
    }

    func buttonWidth(item: CalcButton) -> CGFloat{
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
        }
        
        return (UIScreen.main.bounds.width - (5*12)) / 4
        
    }
    func buttonHeight() -> CGFloat{
            return (UIScreen.main.bounds.width - (5*12)) / 4
        }
        
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
