//
//  ContentView.swift
//  MvvmMusic
//
//  Created by Stefan Bayne on 11/15/22.
//

import SwiftUI

/*
 Main View!
 */
struct ContentView: View {
    
    @ObservedObject var viewModel: SongListViewModel
    
    var body: some View {
        
        NavigationView {
            VStack {
                SearchBar(searchTerm: $viewModel.searchTerm)
                if viewModel.songs.isEmpty {
                    EmptyStateView()
                } else {
                    List(viewModel.songs) { song in
                        SongView(song: song)
                            .listRowBackground(Color("Pale"))
                    }
                    .listStyle(InsetListStyle())
                }
            }
            .navigationTitle("Apple Music")
            .background(Color("Pale"))
        }
    }
}

/*
 Reusable view declarations!!!
 */


/*
 This view is for the songs!!
 */
struct SongView: View {
    @ObservedObject var song: SongViewModel
    
    var body: some View {
        HStack {
            ArtWorkView(image: song.artwork)
                .padding(.trailing)
            VStack(alignment: .leading) {
                Text(song.trackName)
                    .font(.headline)
                    .foregroundColor(Color("DarkGold"))
                Text(song.artistName)
                    .font(.subheadline)
                    .foregroundColor(Color("LightGreen"))
            }
        }
        .padding()
    }
}

/*
 This view displays the artwork.
 */
struct ArtWorkView: View {
    let image: Image?
    
    var body: some View {
        ZStack {
            if image != nil {
                image
            } else {
                Color("Gold")
                Image(systemName: "music.quarternote.3")
                    .font(.largeTitle)
                    .foregroundColor(Color("LightGreen"))
            }
        }
        .frame(width: 50, height: 50)
        .shadow(radius: 5)
        .padding(.trailing, 5)
    }
}

/*
 When the list is empty, this view appears.
 */
struct EmptyStateView: View {
    var body: some View {
        
        //        let thisBackground = LinearGradient(colors: [Color("Pale"), .white], startPoint: .center, endPoint: .topTrailing)
        
        ZStack {
            Color("Pale").ignoresSafeArea() // best approach for setting a bg
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
            .foregroundColor(Color("LightGreen"))
        }
    }
}

/*
 Allows us to embed UI view inside swiftui view.
 Necessary for wrapping custom UIView.
 */
struct SearchBar: UIViewRepresentable {
    typealias UIViewType = UISearchBar
    
    @Binding var searchTerm: String
    
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
        return SearchBarCoordinator(searchTerm: $searchTerm)
    }
    
    // type coordinator method will return
    class SearchBarCoordinator: NSObject, UISearchBarDelegate {
        @Binding var searchTerm: String
        
        init(searchTerm: Binding<String>) {
            self._searchTerm = searchTerm
        }
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchTerm = searchBar.text ?? ""
            UIApplication.shared.windows.first { $0.isKeyWindow}?.endEditing(true)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: SongListViewModel())
    }
}
