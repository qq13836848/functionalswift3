//: Playground - noun: a place where people can play


import Foundation

enum Encoding {
    case ascii
    case nextstep
    case japaneseEUC
    case utf8
}

extension Encoding {
    var nsStringEncoding: String.Encoding {
        switch self {
        case .ascii: return String.Encoding.ascii
        case .nextstep: return String.Encoding.nextstep
        case .japaneseEUC: return String.Encoding.japaneseEUC
        case .utf8: return String.Encoding.utf8
        }
    }
}

extension Encoding {
    init?(encoding: String.Encoding) {
        switch encoding {
        case String.Encoding.ascii:
            self = .ascii
        case String.Encoding.nextstep:
            self = .nextstep
        case String.Encoding.japaneseEUC:
            self = .japaneseEUC
        case String.Encoding.utf8:
            self = .utf8
        default:
            return nil
        }
    }
}

extension Encoding {
    var localizedName: String {
        return String.localizedName(of: nsStringEncoding)
    }
}

enum LookupError: Error {
    case capitalNotFound
    case populationNotFound
}

enum PopulationResult {
    case success(Int)
    case error(LookupError)
}

let exampleSuccess: PopulationResult = .success(100)

let capitals = [String: String]()
let cities = [String: Int]()

func populationOfCapital(country: String) -> PopulationResult {
    guard let capital = capitals[country] else {
        return .error(.capitalNotFound)
    }
    guard let population = cities[capital] else {
        return .error(.populationNotFound)
    }
    return .success(population)
}

switch populationOfCapital(country: "France") {
case let .success(population):
    print("France's capital has \(population) thousand inhabitants")
case let .error(error):
    print("Error: \(error)")
}

let mayors = [String: String]()

func mayorOfCapital(country: String) -> String? {
    return capitals[country].flatMap({mayors[$0]})
}

enum MayorResult {
    case success(String)
    case error(Error)
}

enum Result<T> {
    case success(T)
    case error(Error)
}

//func populationOfCapital(country: String) -> Result<Int>
//func mayorOfCapital(country: String) -> Result<String>

func populationOfCapital1(country: String) throws -> Int {
    guard let capital = capitals[country] else {
        throw LookupError.capitalNotFound
    }
    guard let population = cities[capital] else {
        throw LookupError.populationNotFound
    }
    return population
}

do {
    let population = try populationOfCapital1(country: "France")
    print("France's population is \(population)")
} catch {
    print("Lookup error: \(error)")
}

enum Optional<Wrapped> {
    case none
    case some(Wrapped)
}

func ??<T>(result: Result<T>, handleError: (Error) -> T) -> T {
    switch result {
    case let .success(value):
        return value
    case let .error(error):
        return handleError(error)
    }
}




























