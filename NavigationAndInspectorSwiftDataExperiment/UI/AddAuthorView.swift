//
//  AddAuthorView.swift
//  NavigationAndInspectorExperiment
//
//  Created by Eric Kampman on 4/26/24.
//

import SwiftUI
import SwiftData

struct AddAuthorView: View {
	@Environment(\.modelContext) private var modelContext
	@Query private var authors: [Author]
	@Binding var showingAddAuthor: Bool
	@State private var tempAuthor = Author(firstName: "", lastName: "")

    var body: some View {
		VStack {
			TextField("First Name", text: $tempAuthor.firstName)
			TextField("Last Name", text: $tempAuthor.lastName)
		}
		HStack {
			Button("Add") {
				if let _ = findAuthor(first: tempAuthor.lastName, last: tempAuthor.lastName) {
					// already present -- HUD?
				} else {
					modelContext.insert(tempAuthor)
				}
				showingAddAuthor.toggle()
			}
			Button("Cancel") {
				showingAddAuthor.toggle()
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
	@State var showingAddAuthor = false
	return AddAuthorView(showingAddAuthor: $showingAddAuthor)
}
