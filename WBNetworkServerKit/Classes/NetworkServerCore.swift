//
//  NetworkServerCore.swift
//  NetworkServerKit
//
//  Created by WuQiaoqiao on 2020/10/21.
//

import UIKit
import Moya

@objcMembers public class NetworkServerCore: NSObject {
	
	public static let sharedInstance = NetworkServerCore()
	
	public var baseUrl : String = ""
	
	public var kTimeoutInterval : TimeInterval = 15
	
	public class func requestPost(parameters : [String: Any], headers: [String: String] = [:], path: String, finishedBlock: @escaping (_ resultModel : Response?, _ error: Error?)->()) {
	
		AppApi.request(parameters: parameters, headers: headers, path: path, method: Moya.Method.post).request { (resultModel) in
			
			finishedBlock(resultModel, nil)
		} error: { (error) in
			 
			finishedBlock(nil, error)
		}
	}
	
	public class func requestGet(parameters : [String: Any], headers: [String: String] = [:], path: String, finishedBlock: @escaping (_ resultModel : Response?, _ error: Error?)->()) {
	
		AppApi.request(parameters: parameters, headers: headers, path: path, method: Moya.Method.get).request { (resultModel) in
			
			finishedBlock(resultModel, nil)
		} error: { (error) in
			 
			finishedBlock(nil, error)
		}
	}
}
