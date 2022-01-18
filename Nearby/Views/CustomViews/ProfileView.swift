//
//  ProfileView.swift
//  Nearby
//
//  Created by Srinivasan Rajendran on 2022-01-15.
//

import SwiftUI

struct ProfileView: View {

    @State private var firstName = "Srinivasan"
    @State private var lastName = "Rajendran"
    @State private var company = "iOS Developer, Truecaller"
    @State private var bio = ""

    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                NameBackgroundView()
                HStack(spacing: 20) {
                    ZStack {
                        AvatarView(size: 84)
                        EditImage()
                    }
                    VStack(alignment: .leading, spacing: 10) {
                        TextField("First Name", text: $firstName)
                            .profileNameStyle()
                        TextField("Last Name", text: $lastName)
                            .profileNameStyle()
                        TextField("Company Name", text: $company)
                            .foregroundColor(.secondary)
                    }
                    .foregroundColor(.white)
                }
                .padding()
            }

            VStack {
                HStack() {
                    CharactersRemainView(currentCount: bio.count)
                    Spacer()
                    Button {
                        // action
                    } label: {
                        Label("Check Out",
                              systemImage: "location.fill")
                            .frame(width: 120, height: 40)
                            .background(Color(.systemPink))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                TextEditor(text: $bio)
                    .frame(height: 100)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.secondary, lineWidth: 1))
            }

            Spacer()

            Button {
                // action
            } label: {
                NButton(title: "Create Profile")
            }
        }
        .navigationTitle("Profile")
        .padding()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
        }
        .environment(\.colorScheme, .dark)
    }
}

struct CharactersRemainView: View {

    var currentCount: Int

    var body: some View {
        Text("Bio: ")
            .font(Font.callout)
            .foregroundColor(.secondary)
        +
        Text("\(100 - currentCount)")
            .bold()
            .foregroundColor(currentCount <= 100 ? .brandPrimary : Color(.systemPink))
        +
        Text(" characters remaining")
            .font(Font.callout)
            .foregroundColor(.secondary)
    }
}
