# NetworkingLayer
===========

Installation
-----------

You can easily install this package with the Swift Package Manager from your project.
Just copy the git url : git@github.com:Thicondriustf/NetworkingLayer.git in the bar search of the Swift Package Manager popup and choose the correct version / branch you want.
Then click on **Add Package** and now you can use it on your project.

Making Requests
-----------

To simply make a request with only an url, you can use the object Request with its initializer : 

```swift
// For and url like https://httpbin.org/get, base url is https://httpbin.org/ and path is get
let simpleService = Request(baseURL: URL(string: "https://httpbin.org/")!, method: .get, path: "get")
URLSessionProvider().request(service: simpleService) { response in
    // Your code here
}
``` 

To make more complicated request, you can use the **ServiceProtocol**. You can then create structs or enums which inherit from it : 

```swift
struct ComplicatedRequest: ServiceProtocol {
    var baseURL: URL
    var path: String
    var method: HTTPMethod
    var params: JSON?
    var headers: HTTPHeaders?
    var uploadImages: [HTTPImage]
}
``` 

or : 

```swift
enum Requests: ServiceProtocol {
    case requestOne
    case requestTwo(variable: String)
    
    var baseURL: URL {
        return URL(string: "your base url")!
    }
    
    var path: String {
        switch self {
        case .requestOne:
            return "request/one"
        case .requestTwo(variable: let variable):
            return "request/two/" + variable
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var params: JSON? {
        return nil
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var uploadImages: [HTTPImage] {
        return []
    }
}
``` 

Note: params, headers and uploadImages are not mandatory under ServiceProtocol but are useful for more complicated request.
Upload images is used to make multipart data request.
