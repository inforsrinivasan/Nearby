//
//  ProfileView.swift
//  Nearby
//
//  Created by Srinivasan Rajendran on 2022-01-15.
//

import SwiftUI
import CloudKit

struct ProfileView: View {

    @StateObject private var viewModel = ProfileViewModel()

    var body: some View {
        ZStack {
            VStack {
                ZStack(alignment: .top) {
                    NameBackgroundView()
                    HStack(spacing: 20) {
                        ZStack {
                            AvatarView(image: viewModel.avatar, size: 84)
                            EditImage()
                        }
                        .onTapGesture {
                            viewModel.isShowingPhotoPicker = true
                        }
                        VStack(alignment: .leading, spacing: 10) {
                            TextField("First Name", text: $viewModel.firstName)
                                .profileNameStyle()
                            TextField("Last Name", text: $viewModel.lastName)
                                .profileNameStyle()
                            TextField("Company Name", text: $viewModel.company)
                                .foregroundColor(.secondary)
                        }
                        .foregroundColor(.white)
                    }
                    .padding()
                }

                VStack {
                    HStack() {
                        CharactersRemainView(currentCount: viewModel.bio.count)
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
                    TextEditor(text: $viewModel.bio)
                        .frame(height: 100)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.secondary, lineWidth: 1))
                }

                Spacer()

                Button {
                    viewModel.profileContext == .create ? viewModel.createProfile() : viewModel.updateProfile()
                } label: {
                    NButton(title: viewModel.profileContext == .create ? "Create Profile" : "Update Profile")
                }
                .padding(.bottom)
            }
            .padding()

            if viewModel.isLoading { LoadingView() }
        }
        .navigationTitle("Profile")
        .toolbar {
            Button {
                dismissKeyboard()
            } label: {
                Image(systemName: "keyboard.chevron.compact.down")
            }
        }
        .onAppear { viewModel.getProfile() }
        .alert(item: $viewModel.alertItem, content: { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        })
        .sheet(isPresented: $viewModel.isShowingPhotoPicker,
               onDismiss: { }) {
            PhotoPicker(image: $viewModel.avatar)
        }
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
