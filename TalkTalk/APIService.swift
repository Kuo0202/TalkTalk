//
//  APIService.swift
//  TalkTalk
//
//  Created by PeterKuo on 2022/5/5.
//

import Foundation

//
struct RegisterUserBody: Encodable {
    let userID: String
    let realName: String
    let Email: String
}

struct RegisterUserRequest: APIRequest {

    typealias Response = BasicResult

    var path: String { "/register" }

    var userInfoBody: RegisterUserBody
    var httpMethod: HTTPMethod { .post }

    var httpBody: Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(userInfoBody)
    }

    func decodeResponse(data: Data) throws -> BasicResult {
        let result = try JSONDecoder().decode(BasicResult.self, from: data)
        return result
    }
}

//


struct UpdateUserRequest: APIRequest {
    typealias Response = BasicResult

    var path: String { "/updateInfo" }

    var updateUserBody: UserInfo
    var httpMethod: HTTPMethod { .put }

    var httpBody: Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(updateUserBody)
    }

    func decodeResponse(data: Data) throws -> BasicResult {
        let result = try JSONDecoder().decode(BasicResult.self, from: data)
        return result
    }
}

//
struct UserIDBody: Encodable {
    let userID: String
}

struct DeleteAccountRequest: APIRequest {

    typealias Response = BasicResult

    var path: String { "/updateInfo" }

    var deleteAccountBody: UserIDBody
    var httpMethod: HTTPMethod { .delete }

    var httpBody: Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(deleteAccountBody)
    }

    func decodeResponse(data: Data) throws -> BasicResult {
        let result = try JSONDecoder().decode(BasicResult.self, from: data)
        return result
    }
}

//
struct PaireRequest: APIRequest {
    typealias Response = PairResult

    var path: String { "/Paire" }

    var paireBody: UserIDBody
    var httpMethod: HTTPMethod { .post }

    var httpBody: Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(paireBody)
    }

    func decodeResponse(data: Data) throws -> PairResult {
        let result = try JSONDecoder().decode(PairResult.self, from: data)
        return result
    }
}

struct CancelPaireRequest: APIRequest {
    typealias Response = BasicResult

    var path: String { "/cancelPaire" }

    var paireBody: UserIDBody
    var httpMethod: HTTPMethod { .post }

    var httpBody: Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(paireBody)
    }

    func decodeResponse(data: Data) throws -> BasicResult {
        let result = try JSONDecoder().decode(BasicResult.self, from: data)
        return result
    }
}

//
struct GetAllUserRequest: APIRequest {
    typealias Response = [UserInfo]

    var path: String { "/alluser" }

    var httpMethod: HTTPMethod { .get }

    func decodeResponse(data: Data) throws -> [UserInfo] {
        let result = try JSONDecoder().decode( [UserInfo].self, from: data)
        return result
    }
}
