//
//  BookListView.swift
//  NavigationAndInspectorExperiment
//
//  Created by Eric Kampman on 4/26/24.
//

import SwiftUI
import SwiftData

struct BookListView: View {
	@Environment(\.modelContext) private var modelContext
	@Binding var navigationPath: NavigationPath
	@Query(sort: \Book.author.lastName) private var books: [Book]
	@State private var selection = Book?.none
	@State private var inspecting = false
	@State private var showingAddBook = false
	
    var body: some View {
		VStack(alignment: .leading) {
			HStack {
				Text("Books")
					.font(.title2)
				Button("Add Book", systemImage: "plus") {
					showingAddBook.toggle()
				}
				Button("Modify", systemImage: "pencil") {
					inspecting.toggle()
				}
				.disabled(selection == nil)
#if os(macOS)
				/* gave up on getting swipe to work for macOS */
				Button("Delete", systemImage: "trash") {
					inspecting = false
					modelContext.delete(selection!)
				}
				.disabled(selection == nil)
#endif

			}
			List(books, id: \.self, selection: $selection) { book in
				Text(book.bookDescription)
					.swipeActions {
						Button("Delete", systemImage:"trash", role: .destructive) {
							inspecting = false
							modelContext.delete(book)
						}
					}
			}
		}
		.padding()
		.inspector(isPresented: $inspecting) {
			if (selection == nil) {
				EmptyView()
			} else {
				BookView(book: selection!, navigationPath: $navigationPath, inspecting: $inspecting)
			}
		}
		.sheet(isPresented: $showingAddBook) {
			AddBookView(showingAddBook: $showingAddBook)
		}

    }
}

#Preview {
	@State var navigationPath = NavigationPath()

    return BookListView(navigationPath: $navigationPath)
}
