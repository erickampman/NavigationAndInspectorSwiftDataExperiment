//
//  ContentView.swift
//  NavigationAndInspectorSwiftDataExperiment
//
//  Created by Eric Kampman on 4/26/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
	@State private var navigationPath = NavigationPath()
	@Query private var books: [Book]
	@Query private var authors: [Author]

    var body: some View {
        NavigationSplitView {
			VStack(alignment: .leading) {
				NavigationLink("Books", value: books)
					.navigationDestination(for: [Book].self) { book in
						BookListView(navigationPath: $navigationPath)
					}
			}
			.padding([.bottom], 10)
			
			VStack(alignment: .leading) {
				NavigationLink("Authors", value: authors)
					.navigationDestination(for: [Author].self) { author in
						AuthorListView(navigationPath: $navigationPath)
					}
			}
			.padding([.bottom], 10)
#if !os(macOS)
			.navigationTitle("My Library")
#endif

#if os(macOS)
				.navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
        } detail: {
            Text("Detail View")
        }
		.onAppear {
			self.setupData()
		}
#if os(macOS)
		.navigationTitle("My Library")
#endif
    }
	
	func setupData() {
		let timJones = Author(firstName: "Tim", lastName: "Jones")
		let sallyFoo = Author(firstName: "Sally", lastName: "Foo")
		let johnDoe = Author(firstName: "John", lastName: "Doe")
		
		if authors.isEmpty {
			modelContext.insert(timJones)
			modelContext.insert(sallyFoo)
			modelContext.insert(johnDoe)
		}
		if books.isEmpty {
			let jonesBook = Book(title: "Jones Book", author: timJones)
			let jonesBook2 = Book(title: "Jones Book II", author: timJones)
			let sallyBook = Book(title: "Sally Forth", author: sallyFoo)
			let sallyBook2 = Book(title: "Sally Fifth", author: sallyFoo)
			let anonymousBook = Book(title: "Anonymous", author: johnDoe)

			modelContext.insert(jonesBook)
//			timJones.books.append(jonesBook)
			modelContext.insert(jonesBook2)
//			timJones.books.append(jonesBook2)
			modelContext.insert(sallyBook)
//			sallyFoo.books.append(sallyBook)
			modelContext.insert(sallyBook2)
//			sallyFoo.books.append(sallyBook)
			modelContext.insert(anonymousBook)
//			johnDoe.books.append(anonymousBook)
		}
	}


//    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
