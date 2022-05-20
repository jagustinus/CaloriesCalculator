//
//  UserViewModel.swift
//  CaloriesCalculator
//
//  Created by Jeems Terri Agustinus on 20/05/22.
//

import Foundation

enum Gender {
    case male
    case female
}

enum Activity {
    case sedentary
    case light
    case moderate
    case active
    case veryActive
}

class UserViewModel: ObservableObject {
    @Published var id = UUID()
    @Published var name: String
    @Published var gender: Gender
    @Published var age: Double
    @Published var height: Double
    @Published var weight: Double
    @Published var activity: Activity
    @Published var expectedCalories: Double

    init(){
        self.name = ""
        self.gender = Gender.male
        self.age = 0
        self.height = 0
        self.weight = 0
        self.expectedCalories = 0
        self.activity = Activity.sedentary

    }
    
    public func calculateCalories() {
        var bmr:Double = 0
        var calories: Double = 0
        switch gender {
            case Gender.male:
                bmr = 66.47 + (13.75 * weight) + (5.003 * height) - (6.755 * age)
            case Gender.female:
                bmr = 655.1 + (9.563 * weight) + (1.850 * height) - (4.676 * age)
        }
        
        switch activity {
            case Activity.sedentary:
                calories = bmr * 1.2
            case Activity.light:
                calories = bmr * 1.375
            case Activity.moderate:
                calories = bmr * 1.55
            case Activity.active:
                calories = bmr * 1.725
            case Activity.veryActive:
                calories = bmr * 1.9
        }
        
        expectedCalories = calories
        
    }
    
}
