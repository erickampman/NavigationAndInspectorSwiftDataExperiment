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
	var body: some View {
		VStack(alignment: .leading) {
			TextField("Title", text: $book.title)
			Text("by")
			Text(book.author.id)
		}
		.padding()
	}
}

#Preview {
	@State var navigationPath = NavigationPath()
	return BookView(book: Book(title: "My Book", author: Author(firstName: "Foo", lastName: "Barr")), navigationPath: $navigationPath)
}
