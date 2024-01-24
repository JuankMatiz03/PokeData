//
//  AbilityTest.swift
//  pokedataTests
//
//  Created by Camiilo on 24/01/24.
//

import XCTest
import Combine
@testable
import pokedata

final class AbilityApiTests: XCTestCase {
    
    var abilityApi: AbilityApi!
    var cancellables: Set<AnyCancellable> = []

    override func setUpWithError() throws {
        try super.setUpWithError()
        abilityApi = AbilityApi()
    }

    override func tearDownWithError() throws {
        abilityApi = nil
        cancellables.removeAll()
        try super.tearDownWithError()
    }

    func testFetchAbility() {
        // Arrange
        let abilityURL = "https://pokeapi.co/api/v2/ability/1"
        let expectation = expectation(description: "Ability fetched successfully")
        
        // Mock response with valid data
        let mockData = Data()  // Replace this with your mock data
        let mockURL = try! XCTUnwrap(URL(string: abilityURL))
        URLProtocolMock.testURLs = [mockURL: mockData]

        // Act
        var receivedAbilities: [Ability]?
        var receivedError: Error?
        
        abilityApi.fetchAbility(abilityURL: abilityURL)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    receivedError = error
                }
                expectation.fulfill()
            }, receiveValue: { abilities in
                receivedAbilities = abilities
            })
            .store(in: &cancellables)
        
        // Assert
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(receivedError, "Errorr al consumir las habilidades del pokemon: \(receivedError?.localizedDescription ?? "")")
        XCTAssertNotNil(receivedAbilities, "Las habilidades no pueden ser nulas")
    }
}
