//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Talaicia Isaacs on 6/24/24.
//

import SwiftUI

struct FlagImage: View {
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .font(.largeTitle.weight(.semibold))
    }
}

struct ProminentTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundStyle(.white)
    }
}


extension View {
    func ProminentTitle() -> some View {
        modifier(ProminentTitleModifier())
    }
}
    
    
    
struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
   @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var isFinished = false
    @State private var numberOfRounds = 1
    @State private var scoreTitle = ""
    
    @State private var score = 0
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue:0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
                ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack{
                Spacer()
                
                Text("Guess the Flag")
                    .ProminentTitle()
                    /*.font(.largeTitle.bold())
                    .foregroundStyle(.white)*/
                
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3){number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(imageName: countries[number])
                           /* Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)*/
                            
                        }
                    }
                }
           
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
            
                
                Spacer()
                Spacer()
        
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        }message: {
            Text("Your score is \(score)")
        }
        
        .alert("Finished", isPresented: $isFinished){
            Button("Restart", action: restart)
        } message: {
            Text("Your score is \(score)")
        }
        
    }
    func flagTapped(_ number : Int){
        if numberOfRounds >= 8 {
            isFinished = true
        }else {
            if number == correctAnswer {
                scoreTitle = "Correct"
                score += 5
            } else {
                scoreTitle = "Wrong"
                score -= 3
            }
        }
        numberOfRounds += 1
        showingScore = true
    }
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    func restart ()
    {
        score = 0
        numberOfRounds = 1
    }
}

#Preview {
    ContentView()
}
