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

    @State private var isLogging: Bool = false
    @State private var transitionLog: [String] = []
    //Iphone sharing? Haven't tested this
    @State private var showShareSheet: Bool = false
    @State private var logFileURL: URL?

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
                        isLogging = true
                        transitionLog.removeAll()
                        logMessage = "You are now logging your mileage..."
                        print("You are now logging your mileage...")
                    }) {
                        Text("Start")
                            .frame(width: 120, height: 50)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    Button(action: {
                        isLogging = false
                        logMessage = "Your mileage has been logged!"
                        exportLog()
                        print("Your mileage has been logged!")
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
            .sheet(isPresented: $showShareSheet) {
                if let url = logFileURL {
                    ShareSheet(activityItems: [url])
                }
            }
        }
    }

    // Create Site Button
    private func createBlueButton(_ title: String) -> some View {
        Button(action: {
            guard isLogging else { return }
            
            lastPressed = currentPressed
            currentPressed = title
            print("\(title) pressed")
            
            if let from = lastPressed, let to = currentPressed, from != to {
                let transition = "\(from) > \(to)"
                logMessage = transition
                transitionLog.append(transition)
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
    
    private func exportLog() {
        let logText = transitionLog.joined(separator: "\n")
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd_HH-mm-ss"
        let fileName = "MileageLog-\(formatter.string(from: Date())).txt"
        
        let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
        
        do {
            try logText.write(to: fileURL, atomically: true, encoding: .utf8)
            logFileURL = fileURL
            showShareSheet = true
            print("Log saved to \(fileURL)")
        } catch {
            logMessage = "Failed to save log"
            print("Error saving file: \(error)")
        }
    }
}

// ShareSheet
struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
    }

//@main //
//struct MykoGoApp: App {
    //var body: some Scene {
        //WindowGroup {
            //ContentView()
        //}
    //}
//}
