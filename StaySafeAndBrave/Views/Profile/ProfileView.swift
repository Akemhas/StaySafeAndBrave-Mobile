//
//  ProfileView.swift
//  StaySafeAndBrave
//
//  Created by Akif Emre Bozdemir on 5/28/25.
//

import SwiftUI

struct ProfileView: View {
    @Binding var activeTab: BottomNavBar.ActiveTab
    @Binding var profile: Profile
    
    #if DEBUG
    @State private var showingAPIDebug = false
    @StateObject private var apiConfig = APIConfiguration.shared
    #endif
    
    var body: some View {
        NavigationStack {
            List{
                
                if profile == Profile.empty {
                    NavigationLink(destination:
                        LoginView(profile: $profile)){
                        ButtonView(label: "Login", icon: "person.badge.key"){}
                    }
                    .contentShape(Rectangle())
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
                    
                    
                    NavigationLink(destination:
                        RegisterView(profile: $profile)){
                        ButtonView(label: "Register", icon: "person.badge.plus"){}
                    }
                    .contentShape(Rectangle())
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
                    
                }else{
                    HStack{
                        VStack(alignment: .leading){
                            Text("Name")
                                .font(.headline)
                            Text(profile.name!)
                            
                            Text("E-Mail")
                                .font(.headline)
                            Text(profile.email!)
                            
                            Text("Birth Date")
                                .font(.headline)
                            Text(profile.birth_date!, style: .date)
                            
                            if profile.role == .mentor{
                                
                                Text("Languages")
                                    .font(.headline)
                                printList(items: profile.languages!)
                                
                                Text("Hobbies")
                                    .font(.headline)
                                printList(items: profile.hobbies!)
                                
                                Text("Rating")
                                    .font(.headline)
                                Text(String(format: "%.1f", profile.rating!))
                                
                                Text("City")
                                    .font(.headline)
                                Text(profile.city!.description)
                                
                                
                                
                            }
                            
                        }
                        
                        Spacer()
                        
                        VStack{
                            AsyncImage(url: URL(string: "\(profile.image!)"),
                            ){ image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(100)
                            } placeholder: {
                                ProgressView()
                                    .frame(minWidth: 100,minHeight: 100)
                                    .background(Color(.systemBackground))
                                    .cornerRadius(100)
                            }
                            
                            Spacer()
                        }
                        
                    }
                    if profile.role == .mentor{
                        Text("Bio")
                            .font(.headline).listRowSeparator(.hidden)
                        Text(profile.bio!)
                    }
                }
                Divider()
                    .listRowSeparator(.hidden)
                if profile != Profile.empty {
                    NavigationLink(destination:
                                    EditUserView(profile: $profile)){
                        ButtonView(label: "Edit Profile", icon: "pencil"){}
                    }
                    .contentShape(Rectangle())
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
                }
                
                NavigationLink(destination:
                    PackagesView()){
                    ButtonView(label: "Packages", icon: "cube.box"){}
                }
                .contentShape(Rectangle())
                .listRowSeparator(.hidden)
                .listRowInsets(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
                
                NavigationLink(destination: FAQView()){
                    ButtonView(label: "FAQ", icon: "questionmark"){}
                    }
                    .contentShape(Rectangle())
                        .listRowSeparator(.hidden)
                        .listRowInsets(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
                
                NavigationLink(destination: AboutUsView()){
                    ButtonView(label: "About Us", icon: "person.2"){}
                    }
                    .contentShape(Rectangle())
                        .listRowSeparator(.hidden)
                        .listRowInsets(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
                
                HStack{
                    ButtonView(label: "Contact Support", icon: "envelope"){
                        activeTab = .chat
                        }
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color(UIColor.tertiaryLabel))
                        .padding(.trailing, -2)
                        
                }.contentShape(Rectangle())
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
                
                if profile != Profile.empty {
                    HStack{
                        ButtonView(label: "Logout", icon: "person.badge.minus",
                                   color: Color.red ){
                                profile = Profile.logout()
                            }
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Color(UIColor.tertiaryLabel))
                            .padding(.trailing, -2)
                            
                    }.contentShape(Rectangle())
                        .listRowSeparator(.hidden)
                        .listRowInsets(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
                }
                
                #if DEBUG
                HStack {
                    ButtonView(label: "API Environment", icon: "server.rack") {
                        showingAPIDebug = true
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 2) {
                        Text(apiConfig.currentEnvironment.rawValue)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        HStack(spacing: 4) {
                            Circle()
                                .fill(apiConfig.isReachable ? .red : apiConfig.currentEnvironment.isSecure ? .green : .yellow)
                                .frame(width: 10, height: 10)
                            Text(apiConfig.currentEnvironment.isSecure ? "Secure" : "Local")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color(UIColor.tertiaryLabel))
                        .padding(.trailing, -2)
                }
                .contentShape(Rectangle())
                .listRowSeparator(.hidden)
                .listRowInsets(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
                .sheet(isPresented: $showingAPIDebug) {
                    APIDebugView()
                }
                #endif
                
                Spacer()
                    .frame(height: 50)
                    .listRowSeparator(.hidden)
                
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            
            Spacer()
            
                
        }
        .onAppear {
            #if DEBUG
            apiConfig.loadSavedEnvironment()
            #endif
        }
    }
}


func printList<T: CustomStringConvertible & Identifiable>(items: [T]) -> some View {
    let columns = [
        GridItem(.adaptive(minimum: 80), spacing: 0)
    ]

    return LazyVGrid(columns: columns, spacing: 8) {
        ForEach(items) { item in
            Text(item.description)
                .lineLimit(1)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(
                    UnevenRoundedRectangle(
                        topLeadingRadius: 100,
                        bottomLeadingRadius: 100,
                        bottomTrailingRadius: 100,
                        topTrailingRadius: 100
                    )
                    .fill(Color(.systemGray6))
                )
        }
    }
    .padding(.horizontal, 4)
}

#Preview {
    ProfileView(activeTab: .constant(.profile), profile: .constant(Profile.testMentor))
        .modelContainer(for: Mentor.self, inMemory: true)
}
