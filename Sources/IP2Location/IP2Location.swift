import SwiftCSV
import Foundation

public struct Location : CustomStringConvertible {
    public let from : UInt32
    public let to: UInt32
    public let iso: String
    public let country: String
    public let region : String
    public let city : String
    public let latitude : Double
    public let longitude : Double
    
    public var description: String {
        return "from: \(from), to: \(from), iso: \(iso), name: \(country), region: \(region), city: \(city)"
    }
}

final public class IP2Location {
    
    enum Error: Swift.Error, Equatable {
        case invalidCSV
        case invalidRow
        case fileNotFound
    }

    fileprivate var database : [Location]
    
    public convenience init?(file: URL, encoding: String.Encoding = .utf8) throws {
        do {
            let contents = try String(contentsOf: file, encoding: encoding)
            try self.init(string: contents)
        } catch {
            throw Error.fileNotFound
        }
        
    }
    
    public init?(string: String) throws {
        do {
            let csv = try CSV(string: string, delimiter: ",", loadColumns: false)
            database = try csv.enumeratedRows.map { row in
                
                guard let from = UInt32(row[0]) else {
                    throw Error.invalidRow
                }
                
                
                guard let to =  UInt32(row[1]) else {
                    throw Error.invalidRow
                }
                
                let ISO  = row[2]
                let name = row[3]
                let region = row[4]
                let city = row[5]

                guard let latitude = Double(row[6]) else {
                    throw Error.invalidRow
                }
                
                guard let longitude = Double(row[7]) else {
                    throw Error.invalidRow
                }
                
                return Location(
                    from: from,
                    to: to,
                    iso: ISO,
                    country: name,
                    region: region,
                    city: city,
                    latitude: latitude,
                    longitude: longitude
                )

            }
        } catch is CSVParseError {
            throw Error.invalidCSV
        }
    }
    
    
    private func search(address: UInt32, slice : ArraySlice<Location>) -> Location? {
        
        let start = slice.startIndex
        let end = slice.endIndex
        
        let pointer = ((end - start) / 2) + start

        if slice[pointer].from <= address && slice[pointer].to >= address {
            return slice[pointer]
        } else if slice.count == 1 {
            return nil
        } else if slice[pointer].from > address {
            return search(address: address, slice: slice[start..<pointer])
        } else if slice[pointer].to < address {
            return search(address: address, slice: slice[pointer..<end])
        }
        
        return nil
    }
    
    func get(_ addesss: UInt32) -> Location? {
        return search(address: addesss, slice: self.database[0..<self.database.endIndex])
    }
    
    public func get(_ address: String) -> Location? {
        var addr = in_addr()
        if inet_pton(AF_INET, address, &addr) == 1 {
            return self.get(addr)
        }
        
        return nil
    }
    
    public func get(_ address: in_addr) -> Location? {
        return self.get(address.s_addr.bigEndian)
    }
    
    static func getIPString(address: inout UInt32) -> String? {
        let length = Int(INET_ADDRSTRLEN) + 2
        var buffer : Array<CChar> = Array(repeating: 0, count: length)
        let hostCString = inet_ntop(AF_INET, &address, &buffer, socklen_t(length))
        return String.init(cString: hostCString!)
    }
}


