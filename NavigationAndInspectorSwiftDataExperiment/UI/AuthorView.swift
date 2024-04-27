//
//  AuthorView.swift
//  NavigationStackExperiment
//
//  Created by Eric Kampman on 4/25/24.
//

import SwiftUI

struct AuthorView: View {
	var author: Author
	@Binding var navigationPath: NavigationPath

    var body: some View {
		NavigationStack(path: $navigationPath) {
			VStack {
				Text(author.id)
			}
//			.navigationDestination(for: Book.self) { book in
//				AuthorDetailView(author: book.author, navigationPath: $navigationPath)
//			}
			.padding()
		}
    }
}

#Preview {
	@State var navigationPath = NavigationPath()
	return AuthorView(author:Author(firstName: "John", lastName: "Lennon"), navigationPath: $navigationPath)
}
