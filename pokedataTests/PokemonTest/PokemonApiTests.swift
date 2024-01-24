//
//  PokemonApiTests.swift
//  pokedataTests
//
//  Created by Camiilo on 24/01/24.
//

import XCTest
import Combine
@testable
import pokedata

class PokemonApiTests: XCTestCase {

    var pokemonApi: PokemonApi!
    var cancellables: Set<AnyCancellable> = []

    override func setUpWithError() throws {
        try super.setUpWithError()
        pokemonApi = PokemonApi()
    }

    override func tearDownWithError() throws {
        pokemonApi = nil
        cancellables.removeAll()
        try super.tearDownWithError()
    }

    func testFetchPokemon_Success() {
        // Arrange
        let expectation = expectation(description: "Pokemons fetched successfully")

        // Act
        var receivedPokemon: [Pokemon]?
        var receivedError: Error?

        pokemonApi.fetchPokemon(offset: 0, limit: 1)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    receivedError = error
                }
                expectation.fulfill()
            }, receiveValue: { pokemon in
                receivedPokemon = pokemon
            })
            .store(in: &cancellables)

        // Assert
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(receivedError, "Error fetching Pokemon: \(receivedError?.localizedDescription ?? "")")
        XCTAssertNotNil(receivedPokemon, "Pokemon list should not be nil")
        XCTAssertEqual(receivedPokemon?.count, 1, "Unexpected number of Pokemon")
    }

}
