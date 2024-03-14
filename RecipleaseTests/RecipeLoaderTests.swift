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
        ingredientsList = ["apple"]
    }
    
    
    // MARK: - Tests
    
    func testGetRecipesShouldPostFailedCallback() {
        // Given
        let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)
        let recipeSessionFake = RecipeSessionErrorResponse(fakeResponse: fakeResponse)
        let recipeLoader = RecipeLoader(recipeSession: recipeSessionFake)
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeLoader.getRecipes(ingredientsList: ingredientsList) { (success, recipeResult) in
            
            // Then
            XCTAssertNil(recipeResult)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testGetRecipesShouldPostFailedCallbackIfResponseCorrectAndDataNil() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil, error: FakeResponseData.networkError)
        let recipeSessionFake = RecipeSessionErrorResponse(fakeResponse: fakeResponse)
        let recipeLoader = RecipeLoader(recipeSession: recipeSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeLoader.getRecipes(ingredientsList: ingredientsList) { (success, recipeResult) in
            
            XCTAssertTrue(success)
            XCTAssertNil(recipeResult)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipesShouldPostFailedCallbackIfNoData() {
        let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.networkError)
        let recipeSessionFake = RecipeSessionErrorResponse(fakeResponse: fakeResponse)
        let recipeLoader = RecipeLoader(recipeSession: recipeSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeLoader.getRecipes(ingredientsList: ingredientsList) { (success, recipeResult) in
            
            XCTAssertTrue(success)
            XCTAssertNil(recipeResult)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipesShouldPostFailedCallbackIfIncorrectResponse() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: nil, error: FakeResponseData.networkError)
        let recipeSessionFake = RecipeSessionErrorResponse(fakeResponse: fakeResponse)
        let recipeLoader = RecipeLoader(recipeSession: recipeSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeLoader.getRecipes(ingredientsList: ingredientsList) { (success, recipeResult) in
            
            XCTAssertTrue(success)
            XCTAssertNil(recipeResult)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipesShouldPostFailedCallbackIfIncorrectData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData, error: FakeResponseData.networkError)
        let recipeSessionFake = RecipeSessionOkResponse(fakeResponse: fakeResponse)
        let recipeLoader = RecipeLoader(recipeSession: recipeSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeLoader.getRecipes(ingredientsList: ingredientsList) { (success, recipeResult) in
            
            XCTAssertTrue(success)
            XCTAssert((recipeResult != nil))
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    
    func testGetRecipeShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctData, error: nil)
        let recipeSessionFake = RecipeSessionResponse(fakeResponse: fakeResponse)
        let recipeLoader = RecipeLoader(recipeSession: recipeSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeLoader.getRecipes(ingredientsList: ingredientsList) { (success, recipeResult) in
            
            XCTAssertTrue(success)
            XCTAssertNotNil(recipeResult)
            XCTAssertEqual(recipeResult?.hits[0].recipe.label, "Blackberry + Apple Cocktail")
       //    XCTAssertEqual(recipeResult?.hits[0].recipe.image, "https://edamam-product-images.s3.amazonaws.com/web-img/ccc/cccff7df44dd1afa256d874c04a0882c.jpg")
           XCTAssertEqual(recipeResult?.hits[0].recipe.yield, Int(2.0))
           XCTAssertEqual(recipeResult?.hits[0].recipe.url, "http://www.lottieanddoof.com/2012/09/lottie-doof-kelly-4/")
            /*      */
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
   
    
    
    
}
    

