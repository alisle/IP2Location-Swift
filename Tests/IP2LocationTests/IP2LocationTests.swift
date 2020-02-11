import XCTest
@testable import IP2Location

final class IP2LocationTests: XCTestCase {
    var database: IP2DBLocate!
    
    
    override func setUp() {
        super.setUp()
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        let resourceURL = thisDirectory.appendingPathComponent("sample.bin")
        
        do {
            database = try IP2DBLocate(file: resourceURL)
        } catch {
            self.database = nil
        }
    }
    func testFindBaseLine() {
        measure {
            
            let _ = self.database.find("10.10.10.1")!
            let _ = self.database.find("140.82.113.3")!
            let _ = self.database.find("8.8.8.8")!
            let _ = self.database.find("212.58.249.213")!
            let _ = self.database.find("171.161.203.100")!
        }
    }

    func testValidIP() {
        let record = self.database.find("8.8.8.8")!
        print("Got record: \(record)")
        
        XCTAssertEqual("US", record.iso)
        XCTAssertEqual("United States", record.country)
        
    }
    
    func testInvalidIP() {
        XCTAssertNil(self.database.find("testing"))
    }


    static var allTests = [
        ("testFindBaseLine", testFindBaseLine),
        ("testInvalidIP", testInvalidIP),
        ("testValidIP", testValidIP),
    ]
}
