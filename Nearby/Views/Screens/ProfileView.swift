//
//  ProfileView.swift
//  Nearby
//
//  Created by Srinivasan Rajendran on 2022-01-15.
//

import SwiftUI

struct ProfileView: View {

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var company = ""
    @State private var bio = ""
    @State private var avatar = PlaceholderImages.avatar
    @State private var isShowingPhotoPicker: Bool = false
    @State private var alertItem: AlertItem?

    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                NameBackgroundView()
                HStack(spacing: 20) {
                    ZStack {
                        AvatarView(image: avatar, size: 84)
                        EditImage()
                    }
                    .onTapGesture {
                        isShowingPhotoPicker = true
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
                createProfile()
            } label: {
                NButton(title: "Create Profile")
            }
            .padding(.bottom)
        }
        .navigationTitle("Profile")
        .toolbar {
            Button {
                dismissKeyboard()
            } label: {
                Image(systemName: "keyboard.chevron.compact.down")
            }
        }
        .alert(item: $alertItem, content: { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        })
        .sheet(isPresented: $isShowingPhotoPicker,
               onDismiss: { }) {
            PhotoPicker(image: $avatar)
        }
        .padding()
    }

    func isValidProfile() -> Bool {

        guard !firstName.isEmpty,
              !lastName.isEmpty,
              !bio.isEmpty,
              !bio.isEmpty,
              avatar != PlaceholderImages.avatar,
              bio.count <= 100 else { return false }

        return true
    }

    func createProfile() {
        guard isValidProfile() else {
            alertItem = AlertContext.invalidProfile
            return
        }
        // send to cloud kit
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
