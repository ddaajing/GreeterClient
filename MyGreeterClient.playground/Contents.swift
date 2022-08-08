import Foundation

/// MyGreeterClient
class MyGreeterClient {
    let dateformatter = DateFormatter()

    // initialize
    init() {
        dateformatter.dateFormat = "HH.mm"
        dateformatter.locale = Locale.current
    }
  
    /// greeting
    ///
    /// - Parameters:
    ///   - by:         greeting date.
    /// - Returns: greeting message
    func greeting(by: Date?) -> String {
        let (valid, returnMsg) = convertToTimeString(by)
        if (valid) {
            return buildMessageByTime(returnMsg)
        }
        else {
            return returnMsg
        }
    }

    /// convert date To string
    ///
    /// - Parameters:
    ///   - by:         greeting date.
    /// - Returns: valid and date string tuple
    func convertToTimeString(_ by: Date? ) -> (Bool, String) {
        guard let date = by else {
            return (false, "No date avaliable")
        }

        let timeString = dateformatter.string(from: date)
        return (true, timeString)
    }

    /// build greeting message by time string
    ///
    /// - Parameters:
    ///   - timeString:         greeting time string.
    /// - Returns: valid greeting message
    func buildMessageByTime(_ timeString: String) -> String {
        let timeValue = Float(timeString)!

        if (timeValue > 6 && timeValue <= 12) {
            return "Good morning"
        }
        else if (timeValue > 12 && timeValue <= 18) {
            return "Good afternoon"
        }
        else {
            return "Good evening"
        }
    }
}


import XCTest

class MyGreeterClientTests: XCTestCase {
    var client: MyGreeterClient!

    override func setUp() {
        super.setUp()

        client = MyGreeterClient()
    }
    
    // helper test method
    func testByDate(_ date: Date?, expectMsg: String) {
        let testMsg = client.greeting(by:date)
        XCTAssertTrue(testMsg == expectMsg)
    }
    
    // test client not nil
    func testClientNotNil() {
        XCTAssertNotNil(client)
    }

    // test greetingByMorning
    func testGreetingByMorning() {
        let testDate = client.dateformatter.date(from: "6.12")
        testByDate(testDate!, expectMsg: "Good morning")
    }

    // test greetingByAfternoon
    func testGreetingByAfternoon() {
        let testDate = client.dateformatter.date(from: "12.30")
        testByDate(testDate!, expectMsg: "Good afternoon")
    }

    // test greetingByEvening
    func testGreetingByEvening() {
        let testDate = client.dateformatter.date(from: "19.00")
        testByDate(testDate!, expectMsg: "Good evening")
    }
    
    // test by no date
    func testByNoDate() {
        testByDate(nil, expectMsg: "No date avaliable")
    }
    
    // test greeting by now according to client's logic
    func testGreetingByNow() {
        let testDate = Date()
        
        // get expect message by client's logic
        var expectMsg = ""
        let (valid, returnMsg) = client.convertToTimeString(testDate)
        if (valid) {
            expectMsg = client.buildMessageByTime(returnMsg)
        }
        else {
            expectMsg = returnMsg
        }

        testByDate(testDate, expectMsg: expectMsg)
    }
}

MyGreeterClientTests.defaultTestSuite.run()


      
