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
	@Binding var tempTitle: String
	
	var body: some View {
		VStack(alignment: .leading) {
			TextField("Title", text: $tempTitle)
			Text("by")
			Text(book.author.fullName)
			
			HStack {
				Button("Change") {
					book.title = tempTitle
					inspecting = false
				}
				.disabled(book.title == tempTitle)
				
				Button("Close") {
					inspecting = false
				}
			}

		}
		.padding()
		.onAppear {
			tempTitle = book.title
		}
		.onDisappear {
			tempTitle = ""
		}
		.task {
			tempTitle = book.title
		}
	}
}

#Preview {
	@State var navigationPath = NavigationPath()
	@State var inspecting = false
	@State var tempTitle = ""
	return BookView(book: Book(title: "My Book", author: Author(firstName: "Foo", lastName: "Barr")), navigationPath: $navigationPath, inspecting: $inspecting, tempTitle: $tempTitle)
}
