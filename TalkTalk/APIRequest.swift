//
//  ApiRequest.swift
//  TalkTalk
//
//  Created by PeterKuo on 2022/5/5.
//

import Foundation
import UIKit

protocol APIRequest {
    associatedtype Response
    var path: String { get }
    var urlRequest: URLRequest { get }
    var queryItems: [URLQueryItem]? { get }
    var httpMethod: HTTPMethod { get }
    var httpBody: Data? { get }
    func decodeResponse(data: Data) throws -> Response
}

enum HTTPMethod: String {
    case get
    case post
    case put
    case delete
}

enum DeleteRequestError: Error {
    case statusCodeInvalid
}

extension APIRequest {
    var host: String { "https://orange-sea.site/talk" }
    var httpBody:Data? { nil }
    var queryItems: [URLQueryItem]? { nil }
    var httpMethod: HTTPMethod { .post }
}

func sendRequest<Request: APIRequest>(_ request: Request, completion: @escaping (Result<Request.Response, Error>) -> Void) {
    let task = URLSession.shared.dataTask(with: request.urlRequest) { data, response, error in
        if let data = data {
            do {
                let decodedResponse = try request.decodeResponse(data: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(error))
            }
        } else if let error = error {
            completion(.failure(error))
        }
    }
    task.resume()
}

extension APIRequest {
    var urlRequest: URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        components.queryItems = queryItems
        var request = URLRequest(url: components.url!)
        request.httpMethod = httpMethod.rawValue
        if let httpBody = httpBody {
            request.httpBody = httpBody
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return request
    }
}

extension APIRequest where Response: Decodable {

    func send(completion: @escaping (Result<Response, Error>) -> Void) {
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            do {
                if let data = data {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decoded = try decoder.decode(Response.self, from: data)
                    completion(.success(decoded))
                } else if let error = error {
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func sendForDelete(completion: @escaping (Error?) -> Void) {
            URLSession.shared.dataTask(with: urlRequest) { _, response, error in
                if let httpResponse = response as? HTTPURLResponse,
                   httpResponse.statusCode == 204 {
                    completion(nil)
                } else if let error = error {
                    completion(error)
                } else {
                    completion(DeleteRequestError.statusCodeInvalid)
                }
            }.resume()
        }
}


struct UserInfo: Codable {
    var userID: String
    var realName: String
    var nickName: URL
    var gender: String?
    var age: String?
    var starSign: String?
    var interest: String?
    var sexualOrientation: String?
    var bloodType: String?
    var personalImageUUID: String?
}

struct BasicResult: Codable {
    var result: Bool
}

struct PairResult: Codable {
    var user1ID: String
    var user2ID: String
}

