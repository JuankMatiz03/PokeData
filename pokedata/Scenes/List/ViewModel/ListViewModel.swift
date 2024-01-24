//
//  ListViewModel.swift
//  pokedata
//
//  Created by Camiilo on 20/01/24.
//

import Foundation
import Combine
import CoreData

class ListViewModel: ObservableObject {
    
    private let context = CoreDataManager.shared.persistentContainer.viewContext

    @Published var pokemons: [Pokemon] = []
    @Published var loadingError: Error?
    @Published var filterState: FilterState
    
    private let pokemonLoader: PokemonLoader
    private let filterService: FilterService
    private var cancellables: Set<AnyCancellable> = []
    private let pageSize = 20
    
  
    let isConnected = Reachability.shared.isConnectedToNetwork()


    /// Inicializador que recibe un protocolo pokemonLoader y el filter service
    /// - Parameters:
    ///   - pokemonLoader: protocolo
    ///   - filterService: servicio apra el filtrado
    
    init(pokemonLoader: PokemonLoader, filterService: FilterService) {
        self.pokemonLoader = pokemonLoader
        self.filterService = filterService
        self.filterState = FilterState()

        // Reacciona a los cambios en el filtro utilizando
        filterState.$searchText
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                self?.loadPokemons(page: 1)
            }
            .store(in: &cancellables)
    }

    // Metodo para cargar los pokemones paginados
    func loadPokemons(page: Int) {
        let offset = (page - 1) * pageSize
        let limit = pageSize
        
        if isConnected {
              loadPokemonsFromCoreData()
              return
        }

        pokemonLoader.fetchPokemon(offset: offset, limit: limit)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.handleError(error)
                }
            } receiveValue: { [weak self] listPokemons in
                let filteredPokemons = self?.applyFilter(to: listPokemons)
                self?.updatePokemons(with: filteredPokemons ?? [])
                self?.savePokemonsToCoreData(pokemons: filteredPokemons ?? [])
            }
            .store(in: &cancellables)
    }
    
    // Se cargan los datos desde el coreData
    func loadPokemonsFromCoreData() {
         do {
             let fetchRequest: NSFetchRequest<PokemonEntity> = PokemonEntity.fetchRequest()
             let pokemonsFromCoreData = try context.fetch(fetchRequest)
             let convertedPokemons = pokemonsFromCoreData.map { Pokemon(name: $0.name ?? "", url: $0.imageUrl ?? "") }

             DispatchQueue.main.async {
                 self.updatePokemons(with: convertedPokemons)
             }
         } catch {
             DispatchQueue.main.async {
                 self.handleError(error)
             }
         }
     }
    
    // Se almacena en la entidad PokemonEntity un pokemon para su persistencia
    private func savePokemonsToCoreData(pokemons: [Pokemon]) {
        do {
            for pokemon in pokemons {
                let pokemonEntity = PokemonEntity(context: context)
                pokemonEntity.name = pokemon.name
                pokemonEntity.imageUrl = pokemon.url
            }

            try context.save()
        } catch {
            handleError(error)
        }
    }

    // Metodo para aplicar el filtrado
    // retorna el pokemon filtrado
    private func applyFilter(to pokemons: [Pokemon]) -> [Pokemon] {
        guard !filterState.searchText.isEmpty else {
            return pokemons
        }

        return pokemons.filter {
            $0.name.lowercased().contains(filterState.searchText.lowercased())
        }
    }

    // Metodo para actualiza la lista de pokemones
    private func updatePokemons(with pokemons: [Pokemon]) {
        self.pokemons = pokemons
    }

    // Metodo para el manejo de errores
    private func handleError(_ error: Error) {
        self.loadingError = error
    }
}
