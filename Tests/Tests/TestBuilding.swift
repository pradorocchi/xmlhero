import XCTest
@testable import XmlHero

final class TestBuilding:XCTestCase
{
    private let kResourceName:String = "mockElements.xml"
    private let kWaitExpectation:TimeInterval = 2
    
    //MARK: tests
    
    func testBuildingXml()
    {
        let buildExpectation:XCTestExpectation = expectation(
            description:"build xml")
        
        let bundle:Bundle = Bundle(for:TestElements.self)
        var string:String?
        
        Xml.object(
            fileName:kResourceName,
            bundle:bundle)
        { (xml:[String:Any]?, error:XmlError?) in
            
            guard
            
                let xml:[String:Any] = xml
            
            else
            {
                return
            }
            
            Xml.data(object:xml)
            { (data:Data?, error:XmlError?) in
                
                guard
                    
                    let data:Data = data,
                    let dataString:String = String(
                        data:data,
                        encoding:String.Encoding.utf8)
                
                else
                {
                    return
                }
                
                string = dataString
                buildExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout:kWaitExpectation)
        { (error:Error?) in
            
            XCTAssertNotNil(
                string,
                "failed building xml")
            
            guard
                
                let xmlString:String = string
            
            else
            {
                return
            }
            
            XCTAssertGreaterThan(
                xmlString.count,
                0)
        }
    }
    
    func testBuildingString()
    {
        let buildExpectation:XCTestExpectation = expectation(
            description:"build xml")
        
        let bundle:Bundle = Bundle(for:TestElements.self)
        var string:String?
        
        Xml.object(
            fileName:kResourceName,
            bundle:bundle)
        { (xml:[String:Any]?, error:XmlError?) in
            
            guard
                
                let xml:[String:Any] = xml
                
            else
            {
                return
            }
            
            Xml.string(object:xml)
            { (xmlString:String?, error:XmlError?) in
                
                string = xmlString
                buildExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout:kWaitExpectation)
        { (error:Error?) in
            
            XCTAssertNotNil(
                string,
                "failed building xml")
            
            guard
                
                let xmlString:String = string
                
            else
            {
                return
            }
            
            XCTAssertGreaterThan(
                xmlString.count,
                0)
        }
    }
}
