//
//  GameView.swift
//  mbtiRankGame
//
//  Created by 박종후 on 2022/05/15.
//

import SwiftUI

struct GameView: View {
    
    var data: StageList
    @State private var firstCard = false
    @State private var secondCard = true
    @State private var isFirstCard = false
    
    @State private var cardX: CGFloat = UIScreen.main.bounds.width
    @State private var topCardY:CGFloat = CGFloat(150)
    @State private var secCardY:CGFloat = CGFloat(150 + UIScreen.main.bounds.height * 0.4)
    
    @State private var stage: Array<String>
    @State private var answer: Array<Int>
    @State private var firstText: String
    @State private var secondText: String
    @State private var firstCount: Int
    @State private var secondCount: Int
    @State private var showCount = false
    
    @State private var showAlert = false
    @State private var showGameEnd = false
    
    
    init(data: StageList){
        self.data = data
        self.stage = data.data
        self.answer = data.answer
        self.firstText = data.data[0]
        self.secondText = data.data[1]
        self.firstCount = data.answer[0]
        self.secondCount = data.answer[1]
    }
    
    func checkStage(isSmall: Bool) -> (Bool, Bool){
        var res: Bool
        var isNext = true
//        if (self.answer.count < 3){
//            isNext = false
//            return (false, isNext)
//        }
        if (self.answer[1] == self.answer[self.answer.count - 1]){
            isNext = false
        }
        if (self.answer[0] < self.answer[1]){
            res = isSmall ? true: false
        } else {
            res = isSmall ? false: true
        }
        return (res, isNext)
    }
    func changeStatus() {
        self.firstCard.toggle()
        self.secondCard.toggle()
        self.stage.removeFirst()
        self.answer.removeFirst()
    }
    
    var body: some View {
        VStack{
            ZStack{
                CardItem(firstCard: true, isFirst: self.firstCard, targetText: self.firstText, targetCount: self.firstCount, isShowCount: showCount ? false : true)
                CardItem(firstCard: false, isFirst: self.secondCard, targetText: self.secondText, targetCount: self.secondCount, isShowCount: showCount ? true : false)
            }
            HStack{
                Button(action: {
                    let (res, isNext) = self.checkStage(isSmall: true)
                    if (isNext==false){
                        showGameEnd = true
                        showCount.toggle()
                    }else{
                        if (res==true){
                            self.changeStatus()
                            if (self.isFirstCard != true){
                                self.firstText = self.stage[1]
                                self.firstCount = self.answer[1]
                                self.isFirstCard = isFirstCard ? false : true
                            }else{
                                self.secondText = self.stage[1]
                                self.secondCount = self.answer[1]
                            }
                            showCount.toggle()
                        }else{
                            showAlert = true
                        }
                    }
                    
                }){
                    Text("더 높다")
                }.alert("틀렸습니다.", isPresented: $showAlert){
                    Button("OK", role: .cancel){}
                }.alert("게임이 종료됐습니다.", isPresented: $showGameEnd){
                    Button("OK", role: .cancel){}
                }
                
                Button(action: {
                    let (res, isNext) = self.checkStage(isSmall: true)
                    if (isNext==false){
                        showGameEnd = true
                        showCount.toggle()
                    }else{
                        if (res==false){
                            self.changeStatus()
                            if (isFirstCard == true){
                                showCount.toggle()
                                self.firstText = self.stage[1]
                                self.firstCount = self.answer[1]
                            }else{
                                isFirstCard = isFirstCard ? false : true
                                self.secondText = self.stage[1]
                                self.secondCount = self.answer[1]
                                
                                
                            }
                            
                        }else{
                            showAlert = true
                        }
                    }
                    
                }){
                    Text("더 낮다")
                }.alert("틀렸습니다.", isPresented: $showAlert){
                    Button("OK", role: .cancel){}
                }.alert("게임이 종료됐습니다.", isPresented: $showGameEnd){
                    Button("OK", role: .cancel){}
                }
            }
            
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(data:ModelData().stageList)
    }
}
