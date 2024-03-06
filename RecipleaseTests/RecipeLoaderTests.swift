//
//  RecipeLoaderTests.swift
//  RecipleaseTests
//
//  Created by Perveaux Nicolas on 06/03/2024.
//

import XCTest
@testable import Reciplease

class RecipeLoaderTests: XCTestCase {
    
    // MARK: - Properties
    var ingredientsList: [String]!
    
    // MARK: - Tests Life Cycle
        override func setUp() {
        super.setUp()
        ingredientsList = ["apple", "chiken"]
    }
    
    // MARK: - Tests
    func testGetRecipesShouldPostFailedCallback() {
        let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)
        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
        let recipeLoader = RecipeLoader(recipeSession: recipeSessionFake)

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeLoader.getRecipes(ingredientsList: ingredientsList) { (success, recipeResult) in
            XCTAssertFalse(success)
            XCTAssertNil(recipeResult)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
   
    func testGetRecipesShouldPostFailedCallbackIfNoData() {
        let fakeResponse = FakeResponse(response: nil, data: FakeResponseData.incorrectData, error: nil)
        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
        let recipeLoader = RecipeLoader(recipeSession: recipeSessionFake)

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeLoader.getRecipes(ingredientsList: ingredientsList) { (success, recipeResult) in
            XCTAssertFalse(success)
            XCTAssertNil(recipeResult)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
  
    func testGetRecipesShouldPostFailedCallbackIfIncorrectResponse() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.correctData, error: nil)
        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
        let recipeLoader = RecipeLoader(recipeSession: recipeSessionFake)

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeLoader.getRecipes(ingredientsList: ingredientsList) { (success, recipeResult) in
            XCTAssertFalse(success)
            XCTAssertNil(recipeResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipesShouldPostFailedCallbackIfResponseCorrectAndDataNil() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil, error: nil)
        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
        let recipeLoader = RecipeLoader(recipeSession: recipeSessionFake)

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeLoader.getRecipes(ingredientsList: ingredientsList) { (success, recipeResult) in
            XCTAssertFalse(success)
            XCTAssertNil(recipeResult)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetRecipesShouldPostFailedCallbackIfIncorrectData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData, error: nil)
        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
        let recipeLoader = RecipeLoader(recipeSession: recipeSessionFake)

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeLoader.getRecipes(ingredientsList: ingredientsList) { (success, recipeResult) in
            XCTAssertFalse(success)
            XCTAssertNil(recipeResult)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetRecipeShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctData, error: nil)
        let recipeSessionFake = RecipeSessionFake(fakeResponse: fakeResponse)
        let recipeLoader = RecipeLoader(recipeSession: recipeSessionFake)

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeLoader.getRecipes(ingredientsList: ingredientsList) { (success, recipeResult) in
            XCTAssertTrue(success)
            XCTAssertNil(recipeResult)
            XCTAssertEqual(recipeResult?.hits[0].recipe.label, "Apple Chicken Quesadilla")
            XCTAssertEqual(recipeResult?.hits[0].recipe.image, "https://edamam-product-images.s3.amazonaws.com/web-img/fba/fbafcbc96e9796e0a9578a926066722f.jpg")
            XCTAssertEqual(recipeResult?.hits[0].recipe.yield, Int(12.0))
            XCTAssertEqual(recipeResult?.hits[0].recipe.url, "http://simplyrecipes.com/recipes/apple_chicken_quesadilla/")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
  
}
