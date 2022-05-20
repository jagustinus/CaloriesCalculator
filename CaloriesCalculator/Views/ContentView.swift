//
//  ContentView.swift
//  CaloriesCalculator
//
//  Created by Jeems Terri Agustinus on 20/05/22.
//

import SwiftUI

struct ContentView: View {
    var bgColor = #colorLiteral(red: 0.9254901961, green: 0.9725490196, blue: 1, alpha: 1)
    @EnvironmentObject var userVM : UserViewModel
    @FocusState private var nameIsFocused: Bool
    @State var calories: Double = 0
    
    var body: some View {
        NavigationView{
            ZStack{
                Color(bgColor).edgesIgnoringSafeArea(.all)
                VStack{
                    Form{
                        Section(header:
                            Text("Your personal information")
                                .font(.subheadline)){
                            TextField("Name", text:$userVM.name)
                            HStack{
                                Text("Age")
                                    .font(.body)
                                Slider(value: $userVM.age, in:
                                        10...100, step: 1.0)
                                Text(String(format: "%0.0f y.o.", userVM.age))
                                    .font(.body)
                            }
                            .accessibilityElement(children: .combine)
                            .accessibility(label: Text("Input Your Age"))
                                    
                            HStack{
                                Text("Gender")
                                    .font(.body)
                                Picker("Gender", selection: $userVM.gender) {
                                    Text("Male")
                                        .font(.body)
                                        .tag(Gender.male)
                                    Text("Female")
                                        .font(.body)
                                        .tag(Gender.female)
                                }.pickerStyle(SegmentedPickerStyle())
                            }
                            .accessibilityElement(children: .combine)
                            .accessibility(label: Text("Select Your Gender"))
                            
                        }
                        
                        Section(header: Text("Your body information").font(.subheadline)){
                            HStack{
                                Text("Height")
                                    .font(.body)
                                Slider(value: $userVM.height, in:
                                        100...250, step: 1.0)
                                Text(String(format: "%0.0f cm", userVM.height))
                                    .font(.body)
                            }
                            HStack{
                                Text("Weight")
                                    .font(.body)
                                Slider(value: $userVM.weight, in:
                                        40...200, step: 1.0)
                                Text(String(format: "%0.0f Kg", userVM.weight))
                                    .font(.body)
                            }
                        }
                        
                        Section(header: Text("Your activity information").font(.subheadline)){
                            VStack(alignment:.leading){
                                Picker("Daily Activity", selection: $userVM.activity){
                                    Text("Sedentary (little or no exercise)")
                                        .font(.body)
                                        .tag(Activity.sedentary)
                                    Text("Lightly active (exercise 1–3 days/week)")
                                        .font(.body)
                                        .tag(Activity.light)
                                    Text("Moderately active (exercise 3–5 days/week)")
                                        .font(.body)
                                        .tag(Activity.moderate)
                                    Text("Active (exercise 6–7 days/week)")
                                        .font(.body)
                                        .tag(Activity.active)
                                    Text("Very active (hard exercise 6–7 days/week):")
                                        .font(.body)
                                        .tag(Activity.veryActive)
                                }
                            }
                        }
                        
                        Section(header: Text("Your Daily Calories Result: ")
                            .font(.subheadline)){
                            VStack{
                                Text(toString(n: calories))
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemBlue))
                                    .padding(.top, 5)
                                
                                Text("Calories/Day")
                                    .font(.caption)
                                    .padding(.top, 5)
                                    .foregroundColor(Color(.systemGray))
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                        }
                        
                        Button(){
                            userVM.calculateCalories()
                            calories = userVM.expectedCalories
                        } label: {
                            Text("Calculate Calories")
                                .font(.body)
                        }
                        
//                        Button("Record Your Meals") {
//                            TabBar()
//                        }
                    }
                }
            }
            .navigationTitle("Calories Calculator")
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button{
                        hideKeyboard()
                    } label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                    }
                }
            }
        }
    }
    func toString(n: Double) -> String{
        return String(format: "%0.0f", n)
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserViewModel())
    }
}
