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
            
            XCTAssertFalse(success)
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
            
            XCTAssertFalse(success)
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
            
            XCTAssertFalse(success)
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
    
    /*
    
    func testGetRecipeShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctData, error: nil)
        let recipeSessionFake = RecipeSessionResponse(fakeResponse: fakeResponse)
        let recipeLoader = RecipeLoader(recipeSession: recipeSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeLoader.getRecipes(ingredientsList: ingredientsList) { (success, recipeResult) in
            
             XCTAssertTrue(success)
             XCTAssertNotNil(recipeResult)
            XCTAssertEqual(recipeResult?.hits[0].recipe.label, "Blackberry + Apple Cocktail")
             XCTAssertEqual(recipeResult?.hits[0].recipe.image, "https://edamam-product-images.s3.amazonaws.com/web-img/ccc/cccff7df44dd1afa256d874c04a0882c.jpg")
             XCTAssertEqual(recipeResult?.hits[0].recipe.yield, Int(2.0))
             XCTAssertEqual(recipeResult?.hits[0].recipe.url, "http://www.lottieanddoof.com/2012/09/lottie-doof-kelly-4/")
             expectation.fulfill()
             }
             wait(for: [expectation], timeout: 0.01)
        }
     */
    
    
    func testGetRecipeShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctData, error: nil)
        let recipeSessionFake = RecipeSessionFake(data: FakeResponseData.correctData, response: FakeResponseData.responseOK, error: nil)
        let recipeLoader = RecipeLoader(recipeSession: recipeSessionFake)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        recipeLoader.getRecipes(ingredientsList: ingredientsList) { (success, recipeResult) in
            
             XCTAssertTrue(success)
             XCTAssertNotNil(recipeResult)
            XCTAssertEqual(recipeResult?.hits[0].recipe.label, "Blackberry + Apple Cocktail")
             XCTAssertEqual(recipeResult?.hits[0].recipe.image, //"https://edamam-product-images.s3.amazonaws.com/web-img/ccc/cccff7df44dd1afa256d874c04a0882c.jpg"
                            "https://edamam-product-images.s3.amazonaws.com/web-img/ccc/cccff7df44dd1afa256d874c04a0882c.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjECwaCXVzLWVhc3QtMSJIMEYCIQCer47AXhQHcAtwupORbsjjen35TLTit6X8D59U1wE0FQIhAO3cWWuNuyrNVuVye%2BRNPpuGB7qgrQGlxDr2T%2FWzp4T7KrkFCDUQABoMMTg3MDE3MTUwOTg2Igxy5whrsswvhCt6nJcqlgV%2FEXo%2F%2FIs%2Fp8NwIbNLypkByHmRAHE0q75p2SFHnGCxjjaLrQ2OXouBspNTxDyV%2FEl15EnttJ4y7xWz8dQcsEQJP%2BBW75CCWJngH3I4eelm%2B1T8PO6%2BcLyYx%2FJWMo2ZrQakO9x4h%2BZ352Ch5KLi8HHUHmL4BpDlCd8VKxw93QUBomhMimsesOwnorIbMYnTJOVfJ1XmqPye3o4aFqq0Q3H76YbTayqgjYRDEzqt0IfRU%2BX5r8j0HcTGsTEJ%2Bg60jkNMdemQCCBfyEeOnERfMb3u0cX1leePD5jWbPYgSGEERpJECfhtqvTBWdEHmDP2FiMzXFjIo9oaZMyOnuxl7c1aEInRBaFjAruoxnd51TZaNZRC33kPoDlTMZ%2BOFHxrzS5BcaTGx1sOJHXeQisnxEu4YEtxjt1dI0IzWhFmjjXimYI1XRaEsYd9jTKHPZHj7kooNRChdIRg1Nu%2Fhn0cxQpOy%2BjWWtedh9ycD8AvZPSunccVtsD2WWqexlHPvFXbBvCE%2FeLbKZ8Up7kKzhsCjmExoY80kdPmrflImb52BHjc93Hartdtapp9%2F9IDFeFbJEIyMzdmcxlM0KGyGMaB1bjwIK%2BPX%2FJUqCOdnvHLpcECDRd8jL2ykUzP28mnl8BlGGPGK5SdTVWSL%2FQfUGz0FyrKK03%2F8U1d1CraA%2BhS2xL8xiPRLxgoZUXwBUSS08Dru2fAhcSZkY%2BvOXr0G03evRCo6exyUhFYh7wqopWZA0XCitltcFIfcuOASL5Y2t2p7VEOTQ%2B%2FdCBhZCT5K5YE4PEkHMmfAnmV%2BQPa0BQInhBfjiZS1fhvz%2FAvqDicEalcHj3VvOqN9I5uoCAjw3pxapbiA8ao4jFR54Boo7WRFb2pj7m17SCb2DD0ub2vBjqwAQ35X753ZoFXRfmNgeulnseZcJr1SzWcgiNwzwGOx%2BoEAgsEjeZ1cqkF1kNl2vvWcWKG3k8nxzAzSjCZgwlM23QYw%2FUlJJ6ooeNW0MGuOJxN0GJ4b8%2FQgg7Qt402XK9xbw9qDpMUe14efnRRk3sOXeMzar%2FQTAqZfrxbIQOB2TOo6FAm6rZkok0PHrgfh6PynrlWtY58M%2BjiFmlMRyqP88M0vzyMPmh1d85C%2BZ%2B1uQcE&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20240311T210709Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFJCZLNZ7U%2F20240311%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=b33c5a677cfa1c9c88bdde2c8c67d2f9ae812d1d4ca971f51169051f1cb898cc")
             XCTAssertEqual(recipeResult?.hits[0].recipe.yield, Int(2.0))
             XCTAssertEqual(recipeResult?.hits[0].recipe.url, "http://www.lottieanddoof.com/2012/09/lottie-doof-kelly-4/")
             expectation.fulfill()
             }
             wait(for: [expectation], timeout: 0.01)
        }
    
    
    
    }
    

