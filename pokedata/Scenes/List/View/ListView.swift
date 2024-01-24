import SwiftUI

struct ListView: View {
    
    // MARK: - ViewModel
    
    @ObservedObject var viewModel: ListViewModel
    
    @StateObject var filterState = FilterState()

    let itemsPerPage = 20
    @State private var currentPage = 1

    // Inicializa el ListView con el ViewModel
    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        self.viewModel.loadPokemons(page: currentPage)
    }
    
    // MARK: - body

    var body: some View {
        NavigationView {
                Group {
                    // Muestra el contenido adecuado segunn el estado de la carga
                    content
                }
        }
    }

    // Vista de contenido que muestra la lista, el error o el indicador de carga
    private var content: some View {
        if viewModel.pokemons.isEmpty && viewModel.loadingError == nil {
            return AnyView(LoadingView())

        } else if let error = viewModel.loadingError {
            return AnyView(ErrorView(error: error, errorMessage: "Error cargando los Pokemon", onRetry: {
                self.viewModel.loadPokemons(page: currentPage)
            }))

        } else {
            return AnyView(
                ScrollView(.vertical, showsIndicators: true) {
                    VStack {
                        FilterView(filterState: viewModel.filterState) {
                            self.viewModel.loadPokemons(page: currentPage)
                        }
                        .padding(.top, 30)

                        LazyVGrid(
                            columns: [GridItem(.flexible(), spacing: 16),
                                      GridItem(.flexible(), spacing: 16)], spacing: 16) {
                                        ForEach(viewModel.pokemons, id: \.name) { pokemon in
                                            NavigationLink(destination: DetailView(viewModel: DetailViewModel(pokemon: pokemon))) {
                                                CellView(pokemon: pokemon)
                                            }
                                        }
                            }
                            .onAppear {
                                if self.shouldLoadNextPage() {
                                    currentPage += 1
                                    self.viewModel.loadPokemons(page: currentPage)
                                }
                            }

                        // Boton para cargar mas resultados
                        Button(action: {
                            currentPage += 1
                            self.viewModel.loadPokemons(page: currentPage)
                        }) {
                            Text("Cargar mas")
                                .padding()
                        }
                        .disabled(!shouldLoadNextPage())
                        .padding(.bottom, 20)
                    }
                }
            )
        }
    }

    // Metodo para hacer visible la data de la paginacion
    private func shouldLoadNextPage() -> Bool {
        guard let lastPokemon = viewModel.pokemons.last else {
            return false
        }
        let lastVisiblePokemonIndex = viewModel.pokemons.firstIndex(where: { $0.id == lastPokemon.id }) ?? 0
        return lastVisiblePokemonIndex + 1 == viewModel.pokemons.count
    }
}

// MARK: - ListView_Previews

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        let filterService = FilterService()
        let viewModel = ListViewModel(pokemonLoader: PokemonApi(), filterService: filterService)
        return ListView(viewModel: viewModel)
    }
}
