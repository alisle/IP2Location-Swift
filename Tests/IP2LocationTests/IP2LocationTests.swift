import XCTest
@testable import IP2Location

final class IP2LocationTests: XCTestCase {
    var sample = """
    "0","16777215","-","-","-","-","0.000000","0.000000"
    "16777216","16777471","US","United States of America","California","Los Angeles","34.052230","-118.243680"
    "16777472","16778239","CN","China","Fujian","Fuzhou","26.061390","119.306110"
    "16778240","16779263","AU","Australia","Victoria","Melbourne","-37.814000","144.963320"
    "18958848","18959103","JP","Japan","Ibaraki","Kamisu","35.883000","140.667000"
    """
    
    override func setUp() {
        super.setUp()
    }
    
    
    func testLoadStringValid() throws {
        let db = try IP2Location(string: sample)
        XCTAssertNotNil(db)
    }
    
    func testLoadStringInvalidTo()  {
        XCTAssertThrowsError(try IP2Location(string: "\"I am not a number\",\"16777215\",\"-\",\"-\",\"-\",\"-\",\"0.000000\",\"0.000000\"")) {
            let error = $0 as! IP2Location.Error
            XCTAssertTrue(error == IP2Location.Error.invalidRow)
        }
    }

    
    func testLoadStringInvalidFrom()  {
        XCTAssertThrowsError(try IP2Location(string: "\"0\",\"I am also not a number\",\"-\",\"-\",\"-\",\"-\",\"0.000000\",\"0.000000\"")) {
            let error = $0 as! IP2Location.Error
            XCTAssertTrue(error == IP2Location.Error.invalidRow)
        }
    }
    
    func testLoadStringInvalidLatitude() {
        XCTAssertThrowsError(try IP2Location(string: "\"0\",\"0\",\"-\",\"-\",\"-\",\"-\",\"Not a number\",\"0.000000\"")) {
            let error = $0 as! IP2Location.Error
            XCTAssertTrue(error == IP2Location.Error.invalidRow)
        }
    }
    
    func testLoadStringInvalidLongitude() {
        XCTAssertThrowsError(try IP2Location(string: "\"0\",\"0\",\"-\",\"-\",\"-\",\"-\",\"0.00\",\"Absolutely not a number\"")) {
            let error = $0 as! IP2Location.Error
            XCTAssertTrue(error == IP2Location.Error.invalidRow)
        }
    }
    
    func testFindWithUIntMiss() throws {
        let db = try IP2Location(string: sample)!
        let location = db.get(18959110)
        
        XCTAssertNil(location)
    }
    
    
    func testFindWithUIntHitMiddle() throws {
        let db = try IP2Location(string: sample)!
        let location = db.get(16778243)
        
        XCTAssertNotNil(location)
        XCTAssertEqual(location!.iso, "AU")
        XCTAssertEqual(location!.country, "Australia")
        XCTAssertEqual(location!.region, "Victoria")
        XCTAssertEqual(location!.city, "Melbourne")
        XCTAssertEqual(location!.latitude, -37.814000)
        XCTAssertEqual(location!.longitude, 144.963320)
    }

    func testFindWithUIntHitStart() throws {
        let db = try IP2Location(string: sample)!
        let location = db.get(16777218)
        
        XCTAssertNotNil(location)
        XCTAssertEqual(location!.iso, "US")
        XCTAssertEqual(location!.country, "United States of America")
        XCTAssertEqual(location!.region, "California")
        XCTAssertEqual(location!.city, "Los Angeles")
        XCTAssertEqual(location!.latitude, 34.052230)
        XCTAssertEqual(location!.longitude, -118.243680)
    }
    
    func testFindWithUIntHitEnd() throws {
        let db = try IP2Location(string: sample)!
        let location = db.get(18959102)
        
        XCTAssertNotNil(location)
        XCTAssertEqual(location!.iso, "JP")
        XCTAssertEqual(location!.country, "Japan")
        XCTAssertEqual(location!.region, "Ibaraki")
        XCTAssertEqual(location!.city, "Kamisu")
        XCTAssertEqual(location!.latitude, 35.883000)
        XCTAssertEqual(location!.longitude, 140.667000)
    }
    
    func testFindWithInvalidString() throws {
        let db = try IP2Location(string: sample)!
        let location = db.get("I am not a valid IP Address")
        XCTAssertNil(location)
    }
    
    func testFindWithValidIP() throws {
        let db = try IP2Location(string: sample)!
        let location = db.get("1.0.3.248")

        XCTAssertNotNil(location)
        XCTAssertEqual(location!.iso, "CN")
        XCTAssertEqual(location!.country, "China")
        XCTAssertEqual(location!.region, "Fujian")
        XCTAssertEqual(location!.city, "Fuzhou")
        XCTAssertEqual(location!.latitude, 26.061390)
        XCTAssertEqual(location!.longitude, 119.306110)
    }

    static var allTests = [
        ("testLoadStringValid", testLoadStringValid),
        ("testLoadStringInvalidTo", testLoadStringInvalidTo),
        ("testLoadStringInvalidFrom", testLoadStringInvalidFrom),
        ("testLoadStringInvalidLatitude", testLoadStringInvalidLatitude),
        ("testLoadStringInvalidLongitude", testLoadStringInvalidLongitude),
        ("testFindWithUIntMiss", testFindWithUIntMiss),
        ("testFindWithUIntHitMiddle", testFindWithUIntHitMiddle),
        ("testFindWithUIntHitStart", testFindWithUIntHitStart),
        ("testFindWithUIntHitEnd", testFindWithUIntHitEnd),
        ("testFindWithInvalidString", testFindWithInvalidString),
        ("testFindWithValidIP", testFindWithValidIP),
    ]
}
