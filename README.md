# IP2Location-Swift
![Travis Output](https://travis-ci.com/alisle/IP2Location-Swift.svg?branch=master)

Minimal package to load an IP2Location  BIN file and search for IP Addresses. Currently it only support V4 IP Addresses.


Example:

Using a String:

```swift
        let file = URL(string: "./ip2lodation.bin")
        let database = try IP2DBLocate(file: file)
        let record = self.database.find("8.8.8.8")!        
```


The returned record has the following fields:

```swift
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
}

```

