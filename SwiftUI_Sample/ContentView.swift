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
    
    // AlertMessage 변수선언
    @State var alertIsVisible: Bool = false
    // Slider
    @State var sliderValue: Double = 50.0
    
    var body: some View {
        VStack {
            Spacer()
            
            // Target row.
            HStack {
                Text("Put the Bullseye as close as you can to: ")
                Text("100")
                    .fontWeight(.semibold)
                
            }
            
            Spacer()
            
            // Slider row, 1~100까지 슬라이더값 범위 지정.
            HStack {
                Text("1")
                Slider(value: self.$sliderValue, in: 1...100)
                Text("100")
                
            }
            
            Spacer()
            
            // 버튼 UI구현, 버튼 탭했을 시 테스트log출력.
            Button(action: {
                print("Button Pressed")
                self.alertIsVisible = true
            }) {
                Text("Hit me!")
            }
            
            // 버튼을 탭 했을 시 나타나는 AlertMessage.
            .alert(isPresented: $alertIsVisible) { () -> Alert in
                var roundedValue: Int = Int(self.sliderValue)
                return Alert(title: Text("Hello Bulleye!!"), message: Text("Slider값은 \(roundedValue)."), dismissButton: .default(Text("확인")))
            }
            
            Spacer()
            
            // Score row.
            HStack {
                Button(action: {}) {
                    Text("시작!!")
                }
                Spacer()
                Text("Score :" )
                Text("999999999" )
                Spacer()
                Text("Round :" )
                Text("999" )
                Spacer()
                
                Button(action: {}) {
                    Text("Info")
                }
            }
            .padding(.bottom, 20)
        }
    }
}

// MARK: 02. 해당 뷰에 대한 미리보기 부분 역시 구조체로 선언되어 있다. macOS 10.15버전 이후부터 제공.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
        
        
        
        
    }
}
