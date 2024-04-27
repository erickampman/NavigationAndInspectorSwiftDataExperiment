//
//  AuthorView.swift
//  NavigationStackExperiment
//
//  Created by Eric Kampman on 4/25/24.
//

import SwiftUI

struct AuthorView: View {
	@Bindable var author: Author
	@Binding var navigationPath: NavigationPath
	@Binding var inspecting: Bool
	@State var tempAuthor = Author()
	
	/*
		When I don't use temporary State storage, I often hit an exception
		regarding the uniqueness of authors.
	 */
    var body: some View {
		NavigationStack(path: $navigationPath) {
			VStack {
				TextField("First Name", text: $tempAuthor.firstName)
				TextField("Last Name", text: $tempAuthor.lastName)
				Button("Change") {
					author.lastName = tempAuthor.lastName
					author.firstName = tempAuthor.firstName
					inspecting = false
				}
				.disabled(tempAuthor.firstName == author.firstName &&
						  tempAuthor.lastName == author.lastName)
				
				Button("Close") {
					inspecting = false
				}
			}
			.padding()
		}
		.onAppear {
			tempAuthor.firstName = author.firstName
			tempAuthor.lastName = author.lastName
		}
    }
}

#Preview {
	@State var navigationPath = NavigationPath()
	@State var inspecting = false
	return AuthorView(author:Author(firstName: "John", lastName: "Lennon"), navigationPath: $navigationPath, inspecting: $inspecting)
}
