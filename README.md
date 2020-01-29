# IP2Location-Swift
![Travis Output](https://travis-ci.com/alisle/IP2Location-Swift.svg?branch=master)

Minimal package to load an IP2Location  CSV file and search for IP Addresses. It's far from complete and there are  better solutions out there.


Example:

Using a String:

```swift
        let db = try IP2Location(string: sample)!
        let location = db.get("1.0.3.248")
```
