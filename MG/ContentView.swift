//
//  ContentView.swift
//  MykoGO
//
//  Created by Andrew Ginster on 5/5/25.
//
 
import SwiftUI
 
struct ContentView: View {
    //Button names
    let buttonNames = [
        "ADM", "Tech", "HS", "CAN/JH", "GCE",
        "SKY", "CME", "BME", "PVE", "ZEB"
    ]
 
    var body: some View {
        NavigationView {
            VStack {
                Text("Myko Go!旅するマイク")
                    .font(.largeTitle)
                    .padding()
 
                // Top 5 school sites on grid view
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5)) {
                    ForEach(buttonNames.prefix(5), id: \.self) { title in
                        createBlueButton(title)
                    }
                }
                .padding(.bottom, 20)
 
                // Bottom 5 school sites on the grid view
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5)) {
                    ForEach(buttonNames.suffix(5), id: \.self) { title in
                        createBlueButton(title)
                    }
                }
                .padding(.bottom, 40)
 
                // Start and stop buttons
                HStack(spacing: 40) {
                    Button(action: {
                        print("You are now logging your mileage")
                    }) {
                        Text("Start")
                            .frame(width: 120, height: 50)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
 
                    Button(action: {
                        print("Your mileage has been logged")
                    }) {
                        Text("Stop")
                            .frame(width: 120, height: 50)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
 
                Spacer()
            }
            //Navigation Bar title
            .padding()
            .navigationBarTitle("Myko Go!旅するマイク", displayMode: .inline)
        }
    }
 
    // Button does THIS!!
    private func createBlueButton(_ title: String) -> some View {
        Button(action: {
            print("\(title) Thank you for pressing the button. Ninjas are heading to your location")
        }) {
            Text(title)
                .frame(width: 100, height: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}
 
//@main
struct MykoGoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
