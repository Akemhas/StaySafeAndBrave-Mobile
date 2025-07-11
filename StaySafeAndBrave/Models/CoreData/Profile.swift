//
//  Profile.swift
//  StaySafeAndBrave
//
//  Created by Alexander Staub on 15.06.25.
//

import Foundation

struct Profile: Equatable {
    let user_id: String
    var mentor_id: String? = nil
    var name: String?
    var email: String?
    var role: Role? = Role.user
    var birth_date: Date?
    var hobbies: [Hobby]? = []
    var languages: [AvailableLanguage]? = []
    var image: String? = sampleImagesURL.nomusaURL.rawValue
    var city: City? = City.dortmund
    var bio: String? = ""
    var rating: Float? = 0.0
    
    static let empty = Profile(user_id: "null")
    
    static let testMentor = Profile(user_id: "mentor012", name: "Test Mentor", email: "Mentor@test.de", role: .mentor, birth_date: Date(timeIntervalSince1970: 0), hobbies: [Hobby.coding, Hobby.cooking], languages: [AvailableLanguage.english, AvailableLanguage.xhosa], image: sampleImagesURL.nomusaURL.rawValue, city: City.dortmund, bio: "My mentor bio...", rating: 4.9)
    
    static func register(_name: String, _email: String, _role: Role, _birth_date: Date, _hobbies:[Hobby], _languages: [AvailableLanguage] ) -> Self{
        return Profile(user_id: "registerUser123", name: _name, email: _email, role: _role, birth_date: _birth_date, hobbies: _hobbies, languages: _languages)
    }
    
    static func login (_email: String, _password: String) -> Self {
        return Profile(user_id: "loginUser123", name: "Test User", email: _email, role: .user, birth_date: Date(timeIntervalSince1970: 0), hobbies: [Hobby.coding, Hobby.cooking], languages: [AvailableLanguage.english, AvailableLanguage.german])
    }
    
    static func updateUser(_user_id: String, _name: String, _email: String, _role: Role, _birth_date: Date, _hobbies:[Hobby], _languages: [AvailableLanguage], _city: City, _bio: String, _rating: Float) -> Self{
        return Profile(user_id: _user_id, name:_name, email: _email, role: _role, birth_date: _birth_date, hobbies: _hobbies, languages: _languages, city: _city, bio: _bio, rating: _rating)
    }
    
    static func logout () -> Self {
        Profile.clearSaved()
        return .empty
    }
    
    func toUserUpdateDTO() -> UserUpdateDTO {
        return UserUpdateDTO(
            name: self.name,
            email: self.email,
            birth_date: self.birth_date
        )
    }
    
    func toMentorUpdateDTO() -> MentorUpdateDTO {
        return MentorUpdateDTO(
            name: self.name,
            profile_image: self.image!,
            score: self.rating,
            birth_date: self.birth_date,
            bio: self.bio!,
            languages: self.languages,
            hobbies: self.hobbies,
            location: self.city
        )
    }
}




