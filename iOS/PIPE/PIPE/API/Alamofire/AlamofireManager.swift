//
//  AlamofireManager.swift
//  PIPE
//
//  Created by C.A.V.S.S on 2023/05/29.
//

import Foundation
import Alamofire

class AlamofireManager {
    static let instance = AlamofireManager() // 단일 인스턴스를 저장하는 정적 프로퍼티
    
    // 생성자를 private로 선언하여 외부에서 인스턴스 생성 방지
    private init(){
        
    }
    
   
    func getXML(
        url : String,
        data: @escaping (Codable) -> Void,
        error: @escaping (AFError) -> Void
    ){
        let xmlURL = "https://example.com/data.xml" // XML 데이터 소스의 URL
               
//        AF.request(url, method: .get)
//            .validate()
//            .responseData { response in
//                switch response.result {
//                case .success(let data):
//                    let parser = XMLParser(data: data)
//                    parser.delegate = self
//                    parser.parse()
//                case .failure(let error):
//                    print("Error: \(error)")
//                }
//        }
        
        AF.request(url, method: .get)
            .validate()
            .responseData { response in
            switch response.result {
            case .success(let value):
                // 성공적으로 데이터를 가져왔을 때 처리할 코드
                if let xmlString = String(data: value, encoding: .utf8) {
                    // XML 데이터를 사용하여 원하는 작업을 수행합니다.
                    data(xmlString)
                }
            case .failure(let responseError):
                // 요청 실패 시 처리할 코드
                error(responseError)
            }
        }
    }
    
    func getRequestJSON<T: Decodable>(
        url: String,
        data: @escaping (T) -> Void,
        error: @escaping (AFError) -> Void
    ) {
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                // 성공적으로 데이터를 가져왔을 때 처리할 코드
                data(value)
            case .failure(let responseError):
                // 요청 실패 시 처리할 코드
                error(responseError)
            }
        }
    }
    
}

//
//enum SEGUE_ID {
//    static let USER_LIST_VC = "goToUserListVC"
//    static let PHOTO_COLLECTION_VC = "goToPhotoCollectionVC"
//}
//
//enum API {
//
//    static let BASE_URL : String = "https://api.unsplash.com/"
//
//    // 요건 여러분 꺼로 하셔야 됩니다!! 😅
//    static let CLIENT_ID : String = "JOvX6IMkB3JjvXu2J7eWYsoSmwy33IGvlhTBneG1rLk"
//
//}
//
//enum NOTIFICATION {
//    enum API {
//        static let AUTH_FAIL = "authentication_fail"
//    }
//}
//
//final class AlamofireManager {
//    // 싱글턴 적용
//       static let shared = AlamofireManager()
//
//       // 인터셉터
//       let interceptors = Interceptor(interceptors:[BaseInterceptor()])
//       // 로거 설정
//       let monitors = [MyLogger(), MyApiStatusLogger()] as [EventMonitor]
//
//       // 세션 설정
//       var session : Session
//
//       private init() {
//           session = Session(
//               interceptor: interceptors,
//               eventMonitors: monitors
//           )
//       }
//
//}
//
//
//final class MyLogger : EventMonitor {
//
//    let queue = DispatchQueue(label: "MyLogger")
//
//    func requestDidResume(_ request: Request) {
//        print("MyLogger - requestDidResume()")
//        debugPrint(request)
//    }
//
//    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
//        print("MyLogger - request.didParseResponse()")
//        debugPrint(response)
//    }
//
//
//}
//
//
//final class MyApiStatusLogger : EventMonitor {
//
//    let queue = DispatchQueue(label: "MyApiStatusLogger")
//
////    func requestDidResume(_ request: Request) {
////        print("MyApiStatusLogger - requestDidResume()")
//////        debugPrint(request)
////    }
//
//    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
//
//        guard let statusCode = request.response?.statusCode else { return }
//
//        print("MyApiStatusLogger - request.didParseResponse() / statusCode : \(statusCode)")
//
//
////        debugPrint(response)
//    }
//
//
//}
//
//class BaseInterceptor: RequestInterceptor {
//
//    //
//    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
//
//        print("BaseInterceptor - adapt() called")
//
//        var request = urlRequest
//
//        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Accept")
//
////        // 공통 파라매터 추가
////        var dictionary = [String:String]()
////
////        dictionary.updateValue(API.CLIENT_ID, forKey: "client_id")
////
////        do {
////            request = try URLEncodedFormParameterEncoder().encode(dictionary, into: request)
////        } catch {
////            print(error)
////        }
//
//        completion(.success(request))
//
//    }
//
//
//    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
//        print("BaseInterceptor - retry() called")
//
//        guard let statusCode = request.response?.statusCode else {
//            completion(.doNotRetry)
//            return
//        }
//
//        let data = ["statusCode" : statusCode]
//
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATION.API.AUTH_FAIL), object: nil, userInfo: data)
//
//        completion(.doNotRetry)
//    }
//
//}
//
//
//// 검색관련 api
//enum MySearchRouter: URLRequestConvertible {
//
//    case searchPhotos(term: String)
//    case searchUsers(term: String)
//
//    var baseURL: URL {
//        return URL(string: API.BASE_URL + "search/")!
//    }
//
//    var method: HTTPMethod {
//
////        return .get
//
//        switch self {
//        case .searchPhotos, .searchUsers:
//            return .get
//        }
////        switch self {
////        case .searchPhotos:
////            return .get
////        case .searchUsers:
////            return .post
////        }
//    }
//
//    var endPoint: String {
//        switch self {
//        case .searchPhotos:
//            return "photos/"
//        case .searchUsers:
//            return "users/"
//        }
//    }
//
//    var parameters : [String: String] {
//
//        //        switch self {
//        //        case let .searchUsers(term):
//        //            return ["query1" : term + ""]
//        //        case let .searchPhotos(term):
//        //            return ["query2" : term]
//        //        }
//        switch self {
//        case let .searchUsers(term), let .searchPhotos(term):
//            return ["query" : term]
//        }
//
//    }
//
//    func asURLRequest() throws -> URLRequest {
//
//        let url = baseURL.appendingPathComponent(endPoint)
//
//        print("MySearchRouter - asURLRequest() url : \(url)")
//
//        var request = URLRequest(url: url)
//
//        request.method = method
//
//        request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
//
//        return request
//    }
//}
