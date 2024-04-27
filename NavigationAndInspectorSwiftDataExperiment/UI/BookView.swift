//
//  BookView.swift
//  NavigationStackExperiment
//
//  Created by Eric Kampman on 4/25/24.
//

import SwiftUI

struct BookView: View {
	@Bindable var book: Book
	@Binding var navigationPath: NavigationPath
	@Binding var inspecting: Bool
	@State var tempTitle = ""
	var body: some View {
		VStack(alignment: .leading) {
			TextField("Title", text: $tempTitle)
			Text("by")
			Text(book.author.fullName)
			
			Button("Change") {
				book.title = tempTitle
				inspecting = false
			}
			.disabled(book.title == tempTitle)
			
			Button("Close") {
				inspecting = false
			}

		}
		.padding()
		.onAppear {
			tempTitle = book.title
		}
	}
}

#Preview {
	@State var navigationPath = NavigationPath()
	@State var inspecting = false
	return BookView(book: Book(title: "My Book", author: Author(firstName: "Foo", lastName: "Barr")), navigationPath: $navigationPath, inspecting: $inspecting)
}
