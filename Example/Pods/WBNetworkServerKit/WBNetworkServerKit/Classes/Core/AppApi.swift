//
//  AppApi.swift
//  NetworkServerKit
//
//  Created by WuQiaoqiao on 2020/10/21.
//

import UIKit
import Moya

/**
debugPrint

:param: message printMessage
:param: file    printFile
:param: method  printMethod
:param: line    printLine
*/
func DLog<T>(message: T, file: String = #file, method: String = #function, line: Int = #line) {
	
	#if DEBUG
	print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
	#endif
	
}

var kTimeoutInterval : TimeInterval  {
	
	return NetworkServerCore.sharedInstance.kTimeoutInterval
}

enum AppApi {
	
	case request(parameters : [String: Any] = [:], headers : [String: String] = [:], path: String, method: Moya.Method)
	 
}
 
extension AppApi : TargetType {
	
	var baseURL: URL {
		
		let url = NetworkServerCore.sharedInstance.baseUrl
		
		return URL(string: url)!;
	}
	
	var path: String {
		
		switch self {
			
			case .request( _, _, let path, _):
				
				return path
		}
	}
	
	var method: Moya.Method {
		
		switch self {
			case .request(_, _, _, let method):
				
				return method
		}
	}
	
	var sampleData: Data {
		return "".data(using: .utf8)!
	}
	
	var task: Task {
		
		let parameters = self.parameters
		
		self.networkDebugLog(title: "🚀🚀发送请求🚀🚀", domainName: self.baseURL.absoluteString, path: self.path, describe: "请求包文:", parameters: "\nParameters：\(parameters) \nHeaders：\(String(describing: self.headers))\nUUID:\("")")
		 
		var encodingType : ParameterEncoding = JSONEncoding.default
		
		switch headers?["Content-Type"] {
			case "application/x-www-form-urlencoded", "multipart/form-data":
				encodingType = URLEncoding.default
				
			case "application/json":
				encodingType = JSONEncoding.default
				
			default:
				encodingType = JSONEncoding.default
				break
		}
		
		if self.method == .post {
			 
			return .requestParameters(parameters: parameters, encoding: encodingType)
		}else
		{
			return .requestParameters(parameters: parameters, encoding:encodingType)
		}
		
	}
	
	var headers: [String : String]? {
		
		var headers : [String: String] = [:]
		
		switch self {
			case .request(_, let theHaders, _, _):
				
				headers = theHaders 
		}
		
		return headers
	}
	
	func networkDebugLog(title: String, domainName: String, path: String, describe: String, parameters: String) {
		
		
		let log : String = """
			\n----------------*****\(title)******----------------
			请求域名：\(domainName)
			路径：\(String.init(describing: path))
			\(describe)\(String.init(describing: parameters))
			-----------------***********END***********----------------
			"""
		DLog(message: log)
	}
}

extension AppApi {
	
	var parameters : [String : Any] {
		
		switch self {
			case .request(let parameters, _, _, _):
				
				return parameters
		}
	}
	
	func request(success:@escaping ((Response)->()) ,error:@escaping ((Error)->())){
		
		let requestTimeoutClosure = { (endpoint: Endpoint, done: @escaping MoyaProvider<AppApi>.RequestResultClosure) in
			do {
				var request = try endpoint.urlRequest()
				request.timeoutInterval = kTimeoutInterval
				done(.success(request))
			} catch { return }
		}
		
		let provide = MoyaProvider<AppApi>(requestClosure: requestTimeoutClosure)
		provide.request(self) { (result) in
			 
			switch result {
				
				case let .success(response):
					
					let json = try? response.mapJSON()

					self.networkDebugLog(title: "✅✅请求成功✅✅", domainName: self.baseURL.absoluteString, path: self.path, describe: "返回参数:", parameters: "response = \(response)\n data = \(String(describing: json)))")
					
					success(response)
					
				case let .failure(err):
					
					self.networkDebugLog(title: "❌❌请求错误❌❌", domainName: self.baseURL.absoluteString, path: self.path, describe: "报错信息:", parameters: "\(String(describing: err.localizedDescription))")
					
					error(err)
			}
		}
		
	}
}
