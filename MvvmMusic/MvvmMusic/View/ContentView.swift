//
//  ContentView.swift
//  MvvmMusic
//
//  Created by Stefan Bayne on 11/15/22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        NavigationView {
            VStack() {
                SearchBar()
                EmptyStateView()
            }
            .navigationTitle("Music Search")
        }
    }
}

struct EmptyStateView: View {
    var body: some View {
        
        let thisBackground = LinearGradient(colors: [Color("Pale"), .white], startPoint: .center, endPoint: .topTrailing)
        
        ZStack {
            thisBackground.ignoresSafeArea() // best approach for setting a bg
            VStack {
                Spacer()
                
                Image(systemName: "music.quarternote.3")
                    .font(.system(size: 60))
                    .padding(.bottom)
                Text("Begin Searching for Music...")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            .padding()
            .foregroundColor(Color("DarkGreen"))
        }
    }
}

/*
 Allows us to embed UI view inside swiftui view.
 Necessary for wrapping custom UIView.
 */
struct SearchBar: UIViewRepresentable {
    typealias UIViewType = UISearchBar
    
    // creates the searchbar
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Look for any song you like..."
        return searchBar
    }
    
    // necessary for override.
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        // TODO
    }
    
    // creates delegate for searchbar
    func makeCoordinator() -> SearchBarCoordinator {
        return SearchBarCoordinator()
    }
    
    // type coordinator method will return
    class SearchBarCoordinator: NSObject, UISearchBarDelegate {
        // TODO
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
