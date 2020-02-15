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

public struct IP2LocationRecord : CustomStringConvertible {
    public let iso : Optional<String>
    public let country : Optional<String>
    public let region : Optional<String>
    public let city : Optional<String>
    public let isp : Optional<String>
    public let domain: Optional<String>
    public let zipCode : Optional<String>
    public let latitude : Optional<Float>
    public let longitude : Optional<Float>
    public let timeZone : Optional<String>
    public let netSpeed : Optional<String>
    public let IDDCode : Optional<String>
    public let areaCode : Optional<String>
    public let weatherStationCode : Optional<String>
    public let weatherStationName : Optional<String>
    public let mcc : Optional<String>
    public let mnc : Optional<String>
    public let mobileBrand : Optional<String>
    public let elevation : Optional<Float>
    public let usageType : Optional<String>

    
    public var description: String {
        var description = "Record - "

        if self.iso != nil {
            description.append("ISO: \(self.iso!), ")
        }
        

        if self.country != nil {
            description.append("Country: \(self.country!), ")
        }
        
        if self.region != nil {
            description.append("Region: \(self.region!), ")
        }

        if self.city != nil {
            description.append("City: \(self.city!), ")
        }
        
        if self.isp != nil {
            description.append("ISP: \(self.isp!), ")
        }
        
        if self.domain != nil {
            description.append("Domain: \(self.domain!), ")
        }
        
        if self.zipCode != nil {
            description.append("ZipCode: \(self.zipCode!), ")
        }

        if self.latitude != nil {
            description.append("Latitude: \(self.latitude!), ")
        }
        
        if self.longitude != nil {
            description.append("Longitude: \(self.longitude!), ")
        }

        if self.timeZone != nil {
            description.append("Time Zone: \(self.timeZone!), ")
        }
        
        if self.netSpeed != nil {
            description.append("NetSpeed: \(self.netSpeed!), ")
        }
        
        if self.IDDCode != nil {
            description.append("IDD: \(self.IDDCode!), ")
        }
        
        if self.weatherStationCode != nil {
            description.append("Weather Station Code: \(self.weatherStationCode!), ")
        }

        if self.weatherStationName != nil {
            description.append("Weather Station Name: \(self.weatherStationName!), ")
        }
        
        if self.mcc != nil {
            description.append("MCC: \(self.mcc!), ")
        }

        if self.mnc != nil {
            description.append("MNC: \(self.mnc!), ")
        }
        
        if self.mobileBrand != nil {
            description.append("Mobile Brand: \(self.mobileBrand!), ")
        }
        
        if self.elevation != nil {
            description.append("Elevation: \(self.elevation!), ")
        }

        if self.usageType != nil {
            description.append("Usage Type: \(self.usageType!), ")
        }

        return description
    }
}

// Datasebase Header
struct DatabaseHeader  {
    let type : UInt8
    let column : UInt8
    let day: UInt8
    let month : UInt8
    let year : UInt8
    let ipv4Count : UInt32
    let ipv4BaseAddr : UInt32
    let ipv6Count : UInt32
    let ipv6BaseAddr : UInt32
    let ipv4IndexBaseAddr : UInt32
    let ipv6IndexBaseAddr : UInt32
    
    lazy var ipv4ColumnSize : UInt32 = UInt32(self.column << 2)
    lazy var ipv6ColumnSize : UInt32 = UInt32(16 + UInt32(self.column - 1 << 2))
}

// Defines the capabilities of the bin file.
struct Capabilites {
    // These are used to figure out offsets and what the capabilities are.
    private let countryPosition: [UInt8] = [ 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 ]
    private let regionPosition: [UInt8] =  [ 0, 0, 0, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3 ]
    private let cityPosition :  [UInt8] = [ 0, 0, 0, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4 ]
    private let ispPosition :  [UInt8] = [ 0, 0, 3, 0, 5, 0, 7, 5, 7, 0, 8, 0, 9, 0, 9, 0, 9, 0, 9, 7, 9, 0, 9, 7, 9 ]
    private let latitudePosition :  [UInt8] = [ 0, 0, 0, 0, 0, 5, 5, 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 ]
    private let longitudePosition :  [UInt8] = [ 0, 0, 0, 0, 0, 6, 6, 0, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6 ]
    private let domainPosition :  [UInt8] = [ 0, 0, 0, 0, 0, 0, 0, 6, 8, 0, 9, 0, 10, 0, 10, 0, 10, 0, 10, 8, 10, 0, 10, 8, 10 ]
    private let zipcodePosition :  [UInt8] = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 7, 7, 7, 0, 7, 7, 7, 0, 7, 0, 7, 7, 7, 0, 7 ]
    private let timezonePosition :  [UInt8] = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 8, 7, 8, 8, 8, 7, 8, 0, 8, 8, 8, 0, 8 ]
    private let netspeedPosition :  [UInt8] = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 11, 0, 11, 8, 11, 0, 11, 0, 11, 0, 11 ]
    private let iddcodePosition :  [UInt8] = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 12, 0, 12, 0, 12, 9, 12, 0, 12 ]
    private let areacodePosition :  [UInt8] = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 13, 0, 13, 0, 13, 10, 13, 0, 13 ]
    private let weatherstationcodePosition :  [UInt8] = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 14, 0, 14, 0, 14, 0, 14 ]
    private let weatherstationnamePosition :  [UInt8] = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 15, 0, 15, 0, 15, 0, 15 ]
    private let mccPosition :  [UInt8] = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 16, 0, 16, 9, 16 ]
    private let mncPosition :  [UInt8] = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 17, 0, 17, 10, 17 ]
    private let mobilebrandPosition :  [UInt8] = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 18, 0, 18, 11, 18 ]
    private let elevationPosition :  [UInt8] = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 19, 0, 19 ]
    private let usagetypePosition :  [UInt8] = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12, 20 ]
    
    let countryOffset :  UInt32
    let regionOffset : UInt32
    let cityOffset : UInt32
    let ispOffset : UInt32
    let domainOffset : UInt32
    let zipcodeOffset : UInt32
    let latitudeOffset : UInt32
    let longitudeOffset : UInt32
    let timezoneOffset : UInt32
    let netspeedOffset : UInt32
    let iddcodeOffset : UInt32
    let areacodeOffset : UInt32
    let weatherStationCodeOffset : UInt32
    let weatherStationNameOffset : UInt32
    let mccOffset : UInt32
    let mncOffset : UInt32
    let mobilebrandOffset : UInt32
    let elevationOffset : UInt32
    let usagetypeOffset : UInt32

    // Whether the bin has these capabilites
    let country : Bool
    let region : Bool
    let city : Bool
    let isp : Bool
    let domain: Bool
    let zipCode : Bool
    let latitude : Bool
    let longitude : Bool
    let timeZone : Bool
    let netSpeed : Bool
    let IDDCode : Bool
    let areaCode : Bool
    let weatherStationCode : Bool
    let weatherStationName : Bool
    let mcc : Bool
    let mnc : Bool
    let mobilebrand : Bool
    let elevation : Bool
    let usagetype : Bool
    
    init(_ type: UInt8) {
        let type = Int(type)
        
        // Figure out the capabilites and the offsets
        if countryPosition[type] != 0 {
            countryOffset = UInt32(countryPosition[type] - 2) << 2
            country = true
        } else {
            countryOffset = 0
            country = false
        }
        
        if regionPosition[type] != 0 {
            regionOffset = UInt32(regionPosition[type]-2) << 2
            region = true
        } else {
            regionOffset = 0
            region = false
        }
        
        if cityPosition[type] != 0 {
            cityOffset = UInt32(cityPosition[type]-2) << 2
            city = true
        } else {
            cityOffset = 0
            city = false
        }

        
        if ispPosition[type] != 0 {
            ispOffset = UInt32(ispPosition[type]-2) << 2
            isp = true
        } else {
            ispOffset = 0
            isp = false
        }

        if domainPosition[type] != 0 {
            domainOffset = UInt32(domainPosition[type]-2) << 2
            domain = true
        } else {
            domainOffset = 0
            domain = false
        }

        if zipcodePosition[type] != 0 {
            zipcodeOffset = UInt32(zipcodePosition[type]-2) << 2
            zipCode = true
        } else {
            zipcodeOffset = 0
            zipCode = false
        }

        if latitudePosition[type] != 0 {
            latitudeOffset = UInt32(latitudePosition[type]-2) << 2
            latitude = true
        } else {
            latitudeOffset = 0
            latitude = false
        }

        if longitudePosition[type] != 0 {
            longitudeOffset = UInt32(longitudePosition[type]-2) << 2
            longitude = true
        } else {
            longitudeOffset = 0
            longitude = false
        }

        if timezonePosition[type] != 0 {
            timezoneOffset = UInt32(timezonePosition[type]-2) << 2
            timeZone = true
        } else {
            timezoneOffset = 0
            timeZone = false
        }
        
        if netspeedPosition[type] != 0 {
            netspeedOffset = UInt32(netspeedPosition[type]-2) << 2
            netSpeed = true
        } else {
            netspeedOffset = 0
            netSpeed = false
        }
        
        if iddcodePosition[type] != 0 {
            iddcodeOffset = UInt32(iddcodePosition[type]-2) << 2
            IDDCode = true
        } else {
            iddcodeOffset = 0
            IDDCode = false
        }
        
        if areacodePosition[type] != 0 {
            areacodeOffset = UInt32(areacodePosition[type]-2) << 2
            areaCode = true
        } else {
            areacodeOffset = 0
            areaCode = false
        }

        if weatherstationcodePosition[type] != 0 {
            weatherStationCodeOffset = UInt32(weatherstationcodePosition[type]-2) << 2
            weatherStationCode = true
        } else {
            weatherStationCodeOffset = 0
            weatherStationCode = false
        }

        if weatherstationnamePosition[type] != 0 {
            weatherStationNameOffset = UInt32(weatherstationnamePosition[type]-2) << 2
            weatherStationName = true
        } else {
            weatherStationNameOffset = 0
            weatherStationName = false
        }

        if mccPosition[type] != 0 {
            mccOffset = UInt32(mccPosition[type]-2) << 2
            mcc = true
        } else {
            mccOffset = 0
            mcc = false
        }

        if mncPosition[type] != 0 {
            mncOffset = UInt32(mncPosition[type]-2) << 2
            mnc = true
        } else {
            mncOffset = 0
            mnc = false
        }

        if mobilebrandPosition[type] != 0 {
            mobilebrandOffset = UInt32(mobilebrandPosition[type]-2) << 2
            mobilebrand = true
        } else {
            mobilebrandOffset = 0
            mobilebrand = false
        }

        if elevationPosition[type] != 0 {
            elevationOffset = UInt32(elevationPosition[type]-2) << 2
            elevation = true
        } else {
            elevationOffset = 0
            elevation = false
        }

        if usagetypePosition[type] != 0 {
            usagetypeOffset = UInt32(usagetypePosition[type]-2) << 2
            usagetype = true
        } else {
            usagetypeOffset = 0
            usagetype = false
        }


    }
}



final public class IP2DBLocate {
    var header : DatabaseHeader!
    var capabilites : Capabilites!
    var data : Data!
    
    enum Error: Swift.Error, Equatable {
        case invalidFile
        case unableToReadData
        case invalidBinFile
    }

    public init(file: URL) throws {
        if !file.isFileURL || !FileManager.default.fileExists(atPath: file.path) {
            throw Error.invalidFile
        }
        
        print("loading file \(file.path)")
        
        do {
            let handle = try FileHandle(forReadingFrom: file)
            self.data = handle.readDataToEndOfFile()
        } catch {
            throw Error.unableToReadData
        }
            
        
        if let header = loadHeader(data) {
            self.header = header
        } else {
            throw Error.invalidBinFile
        }
        
        self.capabilites = Capabilites(header.type)
    }

    
    private func readUInt32(_ data: inout Data, advance: Bool = true) -> UInt32 {
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 4)
        defer {
            buffer.deallocate()
        }
        
        data.copyBytes(to: buffer, count: 4)
        
        let value =  UnsafeRawPointer(buffer).load(as: UInt32.self)
        
        if advance {
            data = data.subdata(in: data.startIndex + 4..<data.endIndex)
        }
        
        return value.littleEndian
        
    }
    private func readString(data: Data, offset: UInt32) -> String {
        let startOffset = data.startIndex + Int(offset)
        let length = Int(data[startOffset])
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: length + 1)
        defer {
            buffer.deallocate()
        }
        
        data.copyBytes(to: buffer, from: startOffset + 1..<startOffset + length + 1)
        buffer[length] = 0
        
        return String(cString: buffer)
    }
    
    private func readFloat(data: Data, offset: UInt32) -> Float32 {
        let pattern = data.withUnsafeBytes { $0.load(fromByteOffset: Int(offset), as: UInt32.self)}
        let float = Float(bitPattern: pattern)
        
        return float
    }
    
    func loadHeader(_ data : Data) -> DatabaseHeader? {
        var updated = data.advanced(by: 5)
        
        let header =  DatabaseHeader(
            type: data[0],
            column: data[1],
            day: data[2],
            month: data[3],
            year: data[4],
            ipv4Count: readUInt32(&updated),
            ipv4BaseAddr: readUInt32(&updated),
            ipv6Count: readUInt32(&updated),
            ipv6BaseAddr: readUInt32(&updated),
            ipv4IndexBaseAddr: readUInt32(&updated),
            ipv6IndexBaseAddr: readUInt32(&updated))
            
        return header
    }
    
    func calculateIndex(_ ip: UInt32 ) -> UInt32 {
        if self.header.ipv4IndexBaseAddr > 0 {
            var index = ip
            index = ((index >> 16) << 3) + (self.header.ipv4IndexBaseAddr - 1)
            return index
        }
        
        return 0
    }
    
    func convert(_ address: String) -> UInt32? {
        var addr = in_addr()
        if inet_pton(AF_INET, address, &addr) == 1 {
            return addr.s_addr.bigEndian
        }
            
        return nil
    }
    
    func convert(_ address: UInt32) -> String? {
        let length = Int(INET_ADDRSTRLEN) + 2
        var address = address.bigEndian
        var buffer : Array<CChar> = Array(repeating: 0, count: length)
        let hostCString = inet_ntop(AF_INET, &address, &buffer, socklen_t(length))
        return String.init(cString: hostCString!)
    }
    
    private func parseRecord(_ relativePointer: Data) -> IP2LocationRecord {
        var iso : Optional<String> = nil
        var country : Optional<String> = nil
        var region : Optional<String> = nil
        var city : Optional<String> = nil
        var isp : Optional<String> = nil
        var domain: Optional<String> = nil
        var zipCode : Optional<String> = nil
        var latitude : Optional<Float> = nil
        var longitude : Optional<Float> = nil
        var timeZone : Optional<String> = nil
        var netSpeed : Optional<String> = nil
        var IDDCode : Optional<String> = nil
        var areaCode : Optional<String> = nil
        var weatherStationCode : Optional<String> = nil
        var weatherStationName : Optional<String> = nil
        var mcc : Optional<String> = nil
        var mnc : Optional<String> = nil
        var mobileBrand : Optional<String> = nil
        var elevation : Optional<Float> = nil
        var usageType : Optional<String> = nil

        let dataString : (Data, UInt32) -> String = { (relativePointer, relativeOffset) in
            let absoluteOffset = relativePointer.withUnsafeBytes { $0.load(fromByteOffset: Int(relativeOffset), as: UInt32.self)}
            return self.readString(data: self.data, offset: absoluteOffset)
        }
        
        if self.capabilites.country {
            let countryOffset = relativePointer.withUnsafeBytes { $0.load(fromByteOffset: Int(self.capabilites!.countryOffset), as: UInt32.self)}
            iso = dataString(relativePointer, self.capabilites!.countryOffset)
            country = self.readString(data: self.data, offset: countryOffset + 3)
        }
        
        if self.capabilites.region {
            region = dataString(relativePointer, self.capabilites!.regionOffset)
        }
        
        if self.capabilites.city {
            city = dataString(relativePointer, self.capabilites!.cityOffset)
        }
        
        if self.capabilites.isp {
            isp = dataString(relativePointer, self.capabilites!.ispOffset)
        }

        
        if self.capabilites.latitude {
            latitude = readFloat(data: relativePointer, offset: self.capabilites!.latitudeOffset)
        }
        
        if self.capabilites.longitude {
            longitude = readFloat(data: relativePointer, offset: self.capabilites!.longitudeOffset)
        }
        
        if self.capabilites.domain {
            domain = dataString(relativePointer, self.capabilites!.domainOffset)
        }
        
        if self.capabilites.zipCode {
            zipCode = dataString(relativePointer, self.capabilites!.zipcodeOffset)
        }

        if self.capabilites.timeZone {
            timeZone = dataString(relativePointer, self.capabilites!.timezoneOffset)
        }

        if self.capabilites.netSpeed {
            netSpeed = dataString(relativePointer, self.capabilites!.netspeedOffset)
        }
        
        if self.capabilites.IDDCode {
            IDDCode = dataString(relativePointer, self.capabilites!.iddcodeOffset)
        }
        
        if self.capabilites.areaCode {
            areaCode = dataString(relativePointer, self.capabilites!.areacodeOffset)
        }
        
        if self.capabilites.weatherStationCode {
            weatherStationCode = dataString(relativePointer, self.capabilites!.weatherStationCodeOffset)
        }

        if self.capabilites.weatherStationName {
            weatherStationName = dataString(relativePointer, self.capabilites!.weatherStationNameOffset)
        }
        
        if self.capabilites.mcc {
            mcc = dataString(relativePointer, self.capabilites!.mccOffset)
        }
        
        if self.capabilites.mnc {
            mnc = dataString(relativePointer, self.capabilites!.mncOffset)
        }

        if self.capabilites.mobilebrand {
            mobileBrand = dataString(relativePointer, self.capabilites!.mobilebrandOffset)
        }

        if self.capabilites.elevation {
            let elevationString = dataString(relativePointer, self.capabilites!.elevationOffset)
            elevation = Float(elevationString)!
        }

        
        if self.capabilites.usagetype {
            usageType = dataString(relativePointer, self.capabilites!.usagetypeOffset)
        }

        
        
        return IP2LocationRecord(
            iso: iso,
            country: country,
            region: region,
            city: city,
            isp: isp,
            domain: domain,
            zipCode: zipCode,
            latitude: latitude,
            longitude: longitude,
            timeZone: timeZone,
            netSpeed: netSpeed,
            IDDCode: IDDCode,
            areaCode: areaCode,
            weatherStationCode: weatherStationCode,
            weatherStationName: weatherStationName,
            mcc: mcc,
            mnc: mnc,
            mobileBrand: mobileBrand,
            elevation: elevation,
            usageType: usageType
        )

    }
    
    public func find(_ address: String) -> IP2LocationRecord? {
        guard let ip = convert(address) else {
            return nil
        }
        
        return search(ip: ip)
    }
    

    private func search(ip: UInt32) -> IP2LocationRecord? {
        let columnSize = Int(self.header.ipv4ColumnSize)
        let index = Int(calculateIndex(ip))
        
        var low = (index > 0 ) ? Int(self.data.withUnsafeBytes { $0.load(fromByteOffset: index, as: UInt32.self) }) : 0
        var high = (index > 0) ? Int(self.data.withUnsafeBytes { $0.load(fromByteOffset: index + 4, as: UInt32.self )}) : Int(self.header.ipv4Count)
                        
        while low <= high {
            let pivot = Int((low + high) >> 1)
            let bottom = Int(self.header.ipv4BaseAddr - 1) + (pivot * columnSize)
            let top = bottom + columnSize
            let from = self.data.withUnsafeBytes { $0.load(fromByteOffset: bottom, as: UInt32.self) }
            let to = self.data.withUnsafeBytes { $0.load(fromByteOffset: top, as: UInt32.self) }
            
            if ip >= from && to > ip {
                return parseRecord(self.data[bottom + 4 ..< top])
            } else if ip < from {
                high = pivot - 1
            } else {
                low = pivot + 1
            }
        }
        
        return nil
    }
}



