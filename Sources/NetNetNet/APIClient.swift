//
//  APIClient.swift
//  
//
//  Created by Carlos Cáceres González on 15/10/24.
//

import Foundation

//@available(iOS 15.0, *)
//class Client {
//    func sendRequest<R: Codable>(method: HTTPMethods, endpoint: String) async throws -> R {
//        guard let url = URL(string: "") else {
//            throw NetErrors.runtimeError("Bad URL")
//        }
//        
//        var request = URLRequest(url: url)
//        
//        request.httpMethod = method.rawValue
//        
//        switch method {
//        case .post:
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            
//        default:
//            break
//        }
//        
//        let (data, response) = try await URLSession.shared.data(for: request)
//        
//        guard let httpResponse = response as? HTTPURLResponse else {
//            throw NetErrors.runtimeError("Invalid response")
//        }
//
//        guard (200...299).contains(httpResponse.statusCode) else {
//            throw NetErrors.runtimeError("Error response code: \(httpResponse.statusCode)")
//        }
//        
//        guard let reponse = try? JSONDecoder().decode(R.self, from: data) else {
//            throw NetErrors.runtimeError("Error decoding response")
//        }
//        
//        return reponse
//    }
//}
