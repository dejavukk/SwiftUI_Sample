//
//  ContentView.swift
//  SwiftUI_Sample
//
//  Created by JunHyuk on 21/09/2019.
//  Copyright © 2019 junhyuk. All rights reserved.
//

import SwiftUI
import UIKit

// MARK: - 01. 뷰와 레이아웃부분 구조체.
struct ContentView: View {
    
    // AlertMessage
    @State var alertIsVisible = false
    // Slider
    @State var sliderValue = 50.0
    // 슬라이더의 범위 1~100까지 정의.
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1
    let midnightBlue = Color(red: 0.0 / 255.0, green: 51.0 / 255.0, blue: 102.0 / 255.0)
    
    // ViewModifier정의, 구조체로 공통의 커스텀 제작한 LabelStyle구현.
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            
            .foregroundColor(Color.white)
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
            .modifier(Shadow())
        }
    }
    
    // LabelStyle과 동일하게 ValueStyle 정의.
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            
            .foregroundColor(Color.green)
            .font(Font.custom("Arial Rounded MT Bold", size: 24))
            .modifier(Shadow())
        }
    }
    
    struct ButtonLargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            
            .foregroundColor(Color.black)
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
            .modifier(Shadow())
        }
    }
    
    struct ButtonSmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            
            .foregroundColor(Color.black)
            .font(Font.custom("Arial Rounded MT Bold", size: 12))
            .modifier(Shadow())
        }
    }
    
    struct Shadow: ViewModifier {
        func body(content: Content) -> some View {
            return content
            
                .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }

    
    var body: some View {
        VStack {
            Spacer()
            
            // Target row, 폰트 및 그래픽 효과.
            HStack {
                Text("Put the Bullseye as close as you can to: ").modifier(LabelStyle())
                Text("\(target)").modifier(ValueStyle())
            }
            
            Spacer()
            
            // Slider row, 1~100까지 슬라이더값 범위 지정.
            HStack {
                Text("1").modifier(LabelStyle())
                Slider(value: $sliderValue, in: 1...100).accentColor(Color.green)
                Text("100").modifier(LabelStyle())
            }
            
            Spacer()
            
            // 버튼 UI구현, 버튼 탭했을 시 테스트log출력.
            Button(action: {
                print("버튼 누름!")
                self.alertIsVisible = true
                self.score = self.score + self.pointsForCurrentRound()
                // 랜덤으로 숫자 출력.
                self.target = Int.random(in: 1...100)
            }) {
                Text("Hit me!").modifier(ButtonLargeTextStyle())
            }
            
            // 버튼을 탭 했을 시 나타나는 AlertMessage.
            .alert(isPresented: $alertIsVisible) { () -> Alert in
                // let roundedValue = Int(sliderValue)
                return Alert(title: Text("\(alertTitle())"), message: Text(
                    "Slider값은 \(sliderValueRounded()).\n" +
                    "이번 라운드 당신의 점수는 \(pointsForCurrentRound())입니다."
                ), dismissButton: .default(Text("확인")) {
                    self.score = self.score + self.pointsForCurrentRound()
                    self.target = Int.random(in: 1...100)
                    self.round = self.round + 1
                })
            }
            
            .background(Image("Button")).modifier(Shadow())
            
            Spacer()
            
            // Score row.
            HStack {
                Button(action: {
                    self.startNewGame()
                }) {
                    
                    HStack {
                        Image("StartOverIcon")
                        Text("시작").modifier(ButtonSmallTextStyle())
                    }
                }
                
                .background(Image("Button")).modifier(Shadow())
                
                Spacer()
                Text("Score :" ).modifier(LabelStyle())
                Text("\(score)" ).modifier(ValueStyle())
                Spacer()
                Text("Round :" ).modifier(LabelStyle())
                Text("\(round)" ).modifier(ValueStyle())
                Spacer()
                
                // NavigationBar에서 버튼을 구현하여 화면이동.
                NavigationLink(destination: AboutView()) {
                    HStack {
                        Image("InfoIcon")
                        Text("정보").modifier(ButtonSmallTextStyle())
                    }
                }
                
                .background(Image("Button")).modifier(Shadow())

            }
            .padding(.bottom, 20)
        }
        // 배경화면 이미지 지정, 중앙 정렬.
        .background(Image("Background"), alignment: .center)
        .accentColor(midnightBlue)
        .navigationBarTitle("Bullseye")
        
        
    }
    
    // 함수로 슬라이더값 구현. 중복된 변수를 삭제.
    func sliderValueRounded() -> Int {
     
        return Int(sliderValue.rounded())
    }
    
    func amountOff() -> Int {
        
        abs(target - sliderValueRounded())
    }
    
    // 함수, 분기문 구현 -> 조건에 따라 값을 다르게 표현
    func pointsForCurrentRound() -> Int {
        
        // abs() : 숫자의 절대값을 반환하는 메소드, 개발문서참조
        // Swift언어의 특징 -> 타입 추론가능
        100 - amountOff()
        
        let maximumScore = 100
        let difference = amountOff()
        let bonus: Int
        
        if difference == 0 {
            bonus = 100
            
        } else if difference == 1 {
            bonus = 50
            
        } else {
            bonus = 0
        }
        
        return maximumScore - maximumScore + difference
        
    }
    
    func alertTitle() -> String {
        
        let difference = amountOff()
        let title: String
        
        // 조건에 따른 AlertSheet 구현
        if difference == 0 {
            title = "퍼펙트!"
        } else if difference < 5 {
            title = "굿!"
        } else if difference <= 10 {
            title = "나쁘지 않아!"
        } else {
            
            title = "재도전 하시겠습니까?"
        }
        
        return title
    }
    
    func startNewGame() {
        
        score = 0
        round = 1
        sliderValue = 50.0
        target = Int.random(in: 1...100)
        
    }
    
}

// MARK: 02. 해당 뷰에 대한 미리보기 부분 역시 구조체로 선언되어 있다. macOS 10.15버전 이후부터 제공.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
        
    }
}
