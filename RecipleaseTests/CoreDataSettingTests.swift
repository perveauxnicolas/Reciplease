//
//  CoreDataSettingTests.swift
//  RecipleaseTests
//
//  Created by Perveaux Nicolas on 08/03/2024.
//
import XCTest
@testable import Reciplease

final class CoreDataSettingTests: XCTestCase {
    // MARK: - Properties
    var coreDataStack: MockCoreDataStack!
    var coreDataSetting: CoreDataSetting!

    // MARK: - Tests Life Cycle

    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        coreDataSetting = CoreDataSetting(coreDataStack: coreDataStack)
    }
    override func tearDown() {
        super.tearDown()
        coreDataSetting = nil
        coreDataStack = nil
    }

    // MARK: - Tests
    func testAddRecipeMethods_WhenAnEntityIsCreated_ThenShouldBeCorrectlySaved() {
        coreDataSetting.createRecipe(title: "My Recipe", ingredients: "Ingredients", yield: 8, time: 0, image: "https://www.edamam.com/web-img/de7/de75049edc890303d8fd1293d35938b2.jpg", url: "http://www.seriouseats.com/recipes/2009/09/adult-brownie-chocolate-salt-coffee-andronicos-supermarket-san-francisco-recipe.html")
        XCTAssertTrue(!coreDataSetting.recipes.isEmpty)
        XCTAssertTrue(coreDataSetting.recipes.count == 1)
        XCTAssertTrue(coreDataSetting.recipes[0].title == "My Recipe")
        XCTAssertTrue(coreDataSetting.recipes[0].ingredients == "Ingredients")
        XCTAssertTrue(coreDataSetting.recipes[0].yield == 8)
        XCTAssertTrue(coreDataSetting.recipes[0].time == 0)
        XCTAssertTrue(coreDataSetting.recipes[0].image == "https://www.edamam.com/web-img/de7/de75049edc890303d8fd1293d35938b2.jpg")
        XCTAssertTrue(coreDataSetting.recipes[0].url == "http://www.seriouseats.com/recipes/2009/09/adult-brownie-chocolate-salt-coffee-andronicos-supermarket-san-francisco-recipe.html")
        
        let recipeIsFavorite = coreDataSetting.checkIfRecipeIsFavorite(recipeTitle: "My Recipe", url: "http://www.seriouseats.com/recipes/2009/09/adult-brownie-chocolate-salt-coffee-andronicos-supermarket-san-francisco-recipe.html")
        XCTAssertTrue(coreDataSetting.recipes.count > 0)
        XCTAssertTrue(recipeIsFavorite)
        
    }
    
    func testDeleteRecipeMethod_WhenAnEntityIsCreated_ThenShouldBeCorrectlyDeleted() {
        coreDataSetting.createRecipe(title: "My Recipe One", ingredients: "Ingredients", yield: 8, time: 0, image: "https://www.edamam.com/web-img/de7/de75049edc890303d8fd1293d35938b2.jpg", url: "http://www.seriouseats.com/recipes/2009/09/adult-brownie-chocolate-salt-coffee-andronicos-supermarket-san-francisco-recipe.html")
        
        coreDataSetting.createRecipe(title: "My Recipe Two", ingredients: "Ingredients", yield: 6, time: 0, image: "https://www.edamam.com/web-img/ef8/ef85302a1ac4ac3a94f22ca566ddeea2.jpg", url: "https://food52.com/recipes/67029-milk-chocolate-cocoa")
        
        coreDataSetting.deleteRecipe(recipeTitle: "My Recipe One", url: "http://www.seriouseats.com/recipes/2009/09/adult-brownie-chocolate-salt-coffee-andronicos-supermarket-san-francisco-recipe.html")
        
        let recipeIsFavoriteOne = coreDataSetting.checkIfRecipeIsFavorite(recipeTitle: "My Recipe One", url: "http://www.seriouseats.com/recipes/2009/09/adult-brownie-chocolate-salt-coffee-andronicos-supermarket-san-francisco-recipe.html")
        XCTAssertFalse(recipeIsFavoriteOne)
        
        let recipeIsFavoriteTwo = coreDataSetting.checkIfRecipeIsFavorite(recipeTitle: "My Recipe Two", url: "https://food52.com/recipes/67029-milk-chocolate-cocoa")
        XCTAssertTrue(recipeIsFavoriteTwo)
        XCTAssertFalse(coreDataSetting.recipes.isEmpty)
    }
    
    func testDeleteAllRecipesMethod_WhenAnEntityIsCreated_ThenShouldBeCorrectlyAllDeleted() {
        coreDataSetting.createRecipe(title: "My Recipe", ingredients: "Ingredients", yield: 8, time: 0, image: "https://www.edamam.com/web-img/de7/de75049edc890303d8fd1293d35938b2.jpg", url: "http://www.seriouseats.com/recipes/2009/09/adult-brownie-chocolate-salt-coffee-andronicos-supermarket-san-francisco-recipe.html")
        coreDataSetting.deleteAllRecipes()
        XCTAssertTrue(coreDataSetting.recipes.isEmpty)
        
        let recipeIsFavorite = coreDataSetting.checkIfRecipeIsFavorite(recipeTitle: "My Recipe", url: "http://www.seriouseats.com/recipes/2009/09/adult-brownie-chocolate-salt-coffee-andronicos-supermarket-san-francisco-recipe.html")
        XCTAssertFalse(recipeIsFavorite)
    }
}
