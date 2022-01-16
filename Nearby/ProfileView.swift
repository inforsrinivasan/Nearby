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
                Color(.secondarySystemBackground)
                    .frame(height: 160)
                    .cornerRadius(12)
                HStack(spacing: 20) {
                    ZStack {
                        AvatarView(size: 84)
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 14, height: 14)
                            .foregroundColor(.white)
                            .offset(y: 30)
                    }
                    VStack(alignment: .leading, spacing: 10) {
                        TextField("First Name", text: $firstName)
                            .font(.system(size: 32, weight: .bold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                            .foregroundColor(.primary)
                        TextField("Last Name", text: $lastName)
                            .font(.system(size: 32, weight: .bold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                            .foregroundColor(.primary)
                        TextField("Company Name", text: $company)
                            .foregroundColor(.secondary)
                    }
                    .foregroundColor(.white)
                }
                .padding()
            }

            VStack {
                HStack() {
                    Text("Bio: ")
                        .font(Font.callout)
                        .foregroundColor(.secondary)
                    +
                    Text("\(100 - bio.count)")
                        .bold()
                        .foregroundColor(bio.count <= 100 ? .brandPrimary : Color(.systemPink))
                    +
                    Text(" characters remaining")
                        .font(Font.callout)
                        .foregroundColor(.secondary)

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
                Text("Create profile")
                    .bold()
                    .frame(width: 280, height: 44)
                    .background(Color.brandPrimary)
                    .foregroundColor(.white)
                    .cornerRadius(8)
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
