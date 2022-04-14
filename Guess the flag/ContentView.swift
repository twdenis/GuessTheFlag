//
//  ContentView.swift
//  Guess the (red) flag
//
//  Created by Denis on 02/03/22.
//

import SwiftUI

struct ContentView: View {
    
    
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var numberOfTries = 0
    @State private var shouldThisEnd = false

    let endOfTries = "Time for a new game!"
    
   @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    
    struct flagImages: View {
        var country: String
        var body: some View {
            Image(country)
            .renderingMode(.original)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .shadow(radius: 5)
        }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.teal, .white]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
               
            VStack {
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
                Text("Guess the Flag")
                    .padding()
                    .foregroundColor(.black)
                    .font(.largeTitle.bold())
               
                
            VStack (spacing:50) {
            VStack {
               Text("Tap the flag of:")
                    
                    .foregroundColor(.black)
                    .font(.subheadline.weight(.heavy))
                Text(countries [correctAnswer])
                    .foregroundColor(.black)
                    .font(.largeTitle.weight(.semibold))
            }

                .alert(endOfTries, isPresented: $shouldThisEnd) {
                    Button ("Continue", action: askQuestion)
                } message: {
                    Text ("10 tries is more than enough :P" )
                }
                VStack (spacing: 30) {
            ForEach(0..<3) { number in
                Button {
                    flagTapped(number)
                } label: {
                    flagImages(country: countries [number])
                }
                .alert(scoreTitle, isPresented: $showingScore) {
                    Button("Continue", action: askQuestion)
                } message: {
                    Text("""
                Scored: \(score) points
                Tried: \(numberOfTries) times
                """ )
                }
        }
           
                Text("Your score is: \(score)")
                Spacer()
        
               
                }
                
            .padding()
        }
        
    }
        
        }
        
}
        
        func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries [number])"
        }
        showingScore = true
        numberOfTries += 1
    }
    func askQuestion() {
        if numberOfTries == 10 {
            shouldThisEnd.toggle()
            scoreTitle = "Time for a new game!"
            score = 0
            numberOfTries = 0
            countries.shuffle()
        } else {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        }
    }
    func reseting () {
        if numberOfTries == 10 {
            score = 0
            numberOfTries = 0
            countries.shuffle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

