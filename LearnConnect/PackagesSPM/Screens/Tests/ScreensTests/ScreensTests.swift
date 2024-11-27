import XCTest
@testable import Screens
@testable import DataProvider
@testable import Managers
@testable import FirebaseCore

final class ScreensTests: XCTestCase {
    
    private var viewModel: HomeViewModel!
    private var mockRouter: MockRouter!
    private var mockDataProvider: MockDataProvider!
    private var mockAnalytic: MockAnalyticProvider!
    
    override func setUp() {
        super.setUp()
        mockRouter = MockRouter()
        mockDataProvider = MockDataProvider()
        mockAnalytic = MockAnalyticProvider()
        viewModel = HomeViewModel(router: mockRouter, dataProvider: mockDataProvider, baseAnalyticsProvider: mockAnalytic)
    }
    
    override func tearDown() {
        viewModel = nil
        mockRouter = nil
        mockDataProvider = nil
        super.tearDown()
    }
    
    func testViewDidLoad_callsGetCoursesId() {
        // Arrange
        let expectation = self.expectation(description: "Fetch courses ID is called")
        mockDataProvider.fetchCoursesIdHandler = {
            expectation.fulfill()
        }
        
        // Act
        viewModel.getCoursesId(id: "dasdasd")
        
        // Assert
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testDidSelectRowAt_pushesCourseDetail() {
        // Arrange
        let testContent: [CourseContents] = [
            .init(
                videURL: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
                id: 1,
                type: "video",
                title: "Node js Dersleri 1.Ders Giriş",
                description: "Node js Dersleri Giriş 1.",
                thumbnail: "https://i.ytimg.com/vi/sFMvqMHUryY/hqdefault.jpg"
            )
        ]
        viewModel.response = [
            CourseResponse(name: "Test", description: "Desc", thumbnail: "Image", id: 1, contents: testContent)
        ]
        
        // Act
        viewModel.didSelectRowAt(indexPath: IndexPath(row: 0, section: 0))
        
        mockRouter.pushCourseDetail(contents: testContent)
        // Assert
        XCTAssertTrue(mockRouter.didPushCourseDetail)
        XCTAssertEqual(mockRouter.pushedContent, testContent)
    }
    
    func testConfigureCellItems_populatesCellItems() {
        // Arrange
        let testResponse = [
            CourseResponse(name: "Test 1", description: "Desc 1", thumbnail: "Image 1", id: 1),
            CourseResponse(name: "Test 2", description: "Desc 2", thumbnail: "Image 2", id: 2)
        ]
        viewModel.response = testResponse
        
        // Act
        viewModel.configureCellItems()
        
        // Assert
        XCTAssertEqual(viewModel.numberOfRowsInSection, 2)
        XCTAssertEqual(viewModel.cellForRowAt(indexPath: IndexPath(row: 0, section: 0))?.name, "Test 1")
        XCTAssertEqual(viewModel.cellForRowAt(indexPath: IndexPath(row: 1, section: 0))?.name, "Test 2")
    }
}

// MARK: - Mock Classes
final class MockRouter: HomeRouter {
    var didPushCourseDetail = false
    var pushedContent: [CourseContents] = []
    
    func pushCourseDetail(contents: [CourseContents]) {
        didPushCourseDetail = true
        pushedContent = contents
    }
}

final class MockDataProvider: DataProviderProtocol {
    
    var fetchCoursesIdHandler: (() -> Void)?
    
    func request<T>(for request: T, result: DataProviderResult<T.ResponseType>?) where T : DecodableResponseRequest {
        if let handler = fetchCoursesIdHandler {
            handler()
        }
    }
}

final class MockAnalyticProvider: BaseAnaltyicsProviderProtocol {
    func clickEvent(name: AnalyticsClickName) {
        // Simulate tracking logic
        print("Analytics Event Tracked: \(name.value)")
    }
}
