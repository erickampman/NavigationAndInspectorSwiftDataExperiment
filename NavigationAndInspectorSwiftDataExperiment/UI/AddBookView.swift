//
//  AddBookView.swift
//  NavigationAndInspectorExperiment
//
//  Created by Eric Kampman on 4/26/24.
//

import SwiftUI
import SwiftData

struct AddBookView: View {
	@Environment(\.modelContext) private var modelContext
	@Binding var showingAddBook: Bool
	@Query private var authors: [Author]
	@State private var tempAuthor = Author()
	@State private var tempTitle = ""

    var body: some View {
		VStack {
			TextField("Book Title", text: $tempTitle)
			TextField("Author First Name", text: $tempAuthor.firstName)
			TextField("Author Last Name", text: $tempAuthor.lastName)
		}
		HStack {
			Button("Add") {
				if let author = findAuthor(first: tempAuthor.firstName, last: tempAuthor.lastName) {
					let newBook = Book(title: tempTitle, author: author)
					modelContext.insert(newBook)
				} else {
					modelContext.insert(tempAuthor)
					let newBook = Book(title: tempTitle, author: tempAuthor)
					modelContext.insert(newBook)
				}
				showingAddBook.toggle()
			}
			Button("Cancel") {
				showingAddBook.toggle()
			}
		}
    }
	
	func findAuthor(first: String, last: String) -> Author? {
		for author in authors {
			if author.firstName == first &&
				author.lastName == last
			{
				return author
			}
		}
		return nil
	}

}

#Preview {
	@State var showingAddBook = false
	return AddBookView(showingAddBook: $showingAddBook)
}
