//  ContentView.swift
//  MykoGO
//
//  Created by Andrew Ginster & Mike Ruiz on 5/5/25.
//
 
import SwiftUI

struct ContentView: View {
    // Button names
    let buttonNames = [
        "ADM", "Tech", "HS", "CAN/JH", "GCE",
        "SKY", "CME", "BME", "PVE", "ZEB"
    ]

    // Initialize the button press variables at a neutral state
    @State private var lastPressed: String? = nil
    @State private var currentPressed: String? = nil
    @State private var logMessage: String = ""

    var body: some View {
        NavigationView {
            VStack {
                Text("Myko Go!")
                    .font(.largeTitle)
                    .padding()

                // Grid Layout for site buttons
                VStack(spacing: 20) {
                    ForEach(0..<3, id: \.self) { row in
                        HStack(spacing: 20) {
                            ForEach(0..<3, id: \.self) { col in
                                let index = row * 3 + col
                                if index < buttonNames.count {
                                    createBlueButton(buttonNames[index])
                                }
                            }
                        }
                    }

                    // Centering the 10th button and adding an else condition to add an 11th or 12th if we need
                    if buttonNames.count % 3 == 1 {
                        HStack {
                            Spacer()
                            createBlueButton(buttonNames.last!)
                            Spacer()
                        }
                    } else if buttonNames.count % 3 == 2 {
                        HStack(spacing: 20) {
                            Spacer()
                            createBlueButton(buttonNames[buttonNames.count - 2])
                            createBlueButton(buttonNames.last!)
                            Spacer()
                        }
                    }
                }
                .padding(.bottom, 20)

                // School Site Logger Display
                Text(logMessage)
                    .font(.headline)
                    .foregroundColor(.purple)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.bottom, 20)

                // Start and Stop Buttons
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
            .padding()
            .navigationBarTitle("Myko Go!旅するマイク", displayMode: .inline)
        }
    }

    // Create Site Button
    private func createBlueButton(_ title: String) -> some View {
        Button(action: {
            print("\(title) pressed")

            lastPressed = currentPressed
            currentPressed = title

            if let from = lastPressed, let to = currentPressed, from != to {
                logMessage = "\(from) to \(to)"
            }
        }) {
            Text(title)
                .font(.headline)
                .frame(minWidth: 60, minHeight: 40)
                .padding(.horizontal, 10)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .padding(4)
    }
}

//@main //
//struct MykoGoApp: App {
    //var body: some Scene {
        //WindowGroup {
            //ContentView()
        //}
    //}
//}
