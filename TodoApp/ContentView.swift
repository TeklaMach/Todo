//
//  ContentView.swift
//  TodoApp
//
//  Created by Tekla Matcharashvili on 09.12.23.
//
//

import SwiftUI
struct BarProgressStyle: ProgressViewStyle {
    
    var color: Color = .purple
    var height: Double = 20.0
    func makeBody(configuration: Configuration) -> some View {
        
        let progress = configuration.fractionCompleted ?? 0.0
        
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 50.0)
                    .fill(Color(uiColor: .systemGray5))
                    .frame(height: height)
                    .frame(width: geometry.size.width)
                    .overlay(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 50.0)
                            .fill(color)
                            .frame(width: geometry.size.width * progress)
                    }
            }
        }
    }
}
struct TodoView: View {
    @State private var tasks: [String] = ["Task 1", "Task 2", "Task 3","Task 1", "Task 2", "Task 3"]
    @State private var completedTasks: [Bool] = Array(repeating: false, count: 6)
    
    var totalTasks: Int {
        tasks.count
    }
    
    var remainingTasks: Int {
        tasks.filter { !completedTasks[tasks.firstIndex(of: $0)!] }.count
    }
    
    var body: some View {
        VStack {
            HStack {
                Image("userProfileImage")
                    .resizable()
                    .offset(x: 150, y: 60)
                    .frame(width: 50, height: 50)
                    .overlay(
                        Text("\(remainingTasks)")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding(5)
                            .background(Color.red)
                            .clipShape(Circle())
                            .offset(x: 165, y: 80)
                    )
                    .padding()
                
            }
            
            VStack(alignment: .center) {
                Text("You have \(remainingTasks) tasks to complete")
                    .font(.headline)
                    .padding()
                
                ProgressView(value: Double(remainingTasks), total: Double(totalTasks))
                    .progressViewStyle(BarProgressStyle(height: 20.0))
                    .padding()
                
                Button("Complete All") {
                    completeAllTasks()
                }
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.7294117647, green: 0.5098039216, blue: 0.8705882353, alpha: 1)), Color(#colorLiteral(red: 0.8705882353, green: 0.5098039216, blue: 0.6901960784, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
                .foregroundColor(.white)
                .cornerRadius(10)
                HStack {
                    
                    Text("To-Do List")
                        .font(.title)
                        .padding()
                }
                
                List {
                    ForEach(0..<tasks.count, id: \.self) { index in
                        HStack {
                            Button(action: {
                                toggleTaskCompletion(index)
                            }) {
                                Image(systemName: completedTasks[index] ? "checkmark.circle" : "circle")
                                    .imageScale(.large)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            
                            Text(tasks[index])
                            
                            Spacer()
                            
                            if completedTasks[index] {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.green)
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    private func toggleTaskCompletion(_ index: Int) {
        completedTasks[index].toggle()
    }
    
    private func completeAllTasks() {
        completedTasks = Array(repeating: true, count: totalTasks)
    }
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView()
    }
}

#Preview {
    TodoView()
}
