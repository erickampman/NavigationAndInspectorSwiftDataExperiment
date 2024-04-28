//
//  AuthorListView.swift
//  NavigationAndInspectorExperiment
//
//  Created by Eric Kampman on 4/26/24.
//

import SwiftUI
import SwiftData

struct AuthorListView: View {
	@Environment(\.modelContext) private var modelContext
	@Query private var authors: [Author]
	@Binding var navigationPath: NavigationPath
	@State private var selection = Author?.none
	@State private var inspecting = false
	@State private var showingAddAuthor = false

    var body: some View {
		VStack(alignment: .leading) {
			HStack {
				Text("Authors")
					.font(.title2)
				Button("Add Author", systemImage: "plus") {
					showingAddAuthor.toggle()
				}
#if os(macOS)
				/* gave up on getting swipe to work for macOS */
				Button("Delete", systemImage: "trash") {
					inspecting = false
					modelContext.delete(selection!)
				}
				.disabled(selection == nil)
#endif
			}
			List(authors, id: \.self, selection: $selection) { author in
				Text(author.fullName)
					.swipeActions {
						Button("Delete", systemImage:"trash", role: .destructive) {
							inspecting = false
							modelContext.delete(author)
						}
					}
			}
			.onChange(of: selection) {
				inspecting = selection != nil
			}
		}
		.padding()
		.inspector(isPresented: $inspecting) {
			if (selection == nil) {
				EmptyView()
			} else {
				AuthorView(author: selection!, navigationPath: $navigationPath, inspecting: $inspecting)
			}
		}
		.sheet(isPresented: $showingAddAuthor) {
			AddAuthorView(showingAddAuthor: $showingAddAuthor)
		}
	}
}

#Preview {
	@State var navigationPath = NavigationPath()

    return AuthorListView(navigationPath: $navigationPath)
}
