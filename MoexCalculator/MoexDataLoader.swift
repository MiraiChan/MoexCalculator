import Combine
import Foundation

//Loader of current exchange rates from the Moscow Exchange website
final class MoexDataLoader {
    
    private static let endpoint = URL(string: "http://iss.moex.com/iss/statistics/engines/currency/markets/selt/rates.json?iss.meta=off")!
    
    func fetch(_ endpoint: URL = endpoint) -> AnyPublisher<CurrencyRates, Error> {
        
        URLSession.shared.dataTaskPublisher(for: endpoint)
            .map { $0.data }
            .decode(type: MoexQuote.self, decoder: JSONDecoder())
            .map { $0.currencyRates }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

//The structure into which data from the Moscow Exchange website is decoded
struct MoexQuote: Decodable {
    let wap_rates: RawQuotes
}

//A calculated currency Rates property that converts raw data into a dictionary of the Currency Rates type
extension MoexQuote {
    
    var currencyRates: CurrencyRates {
        
        // Initializing the output dictionary. The ruble-to-ruble exchange rate is always 1.
        var result: CurrencyRates = [.RUR: 1.0]
        
        // Finding the indexes of the fields with the name of the currency and the quote from the columns array
        guard
            let currencyNameIndex = wap_rates.columns.map ({ $0.lowercased() }).firstIndex(of: "shortname"),
            let priceIndex = wap_rates.columns.map ({ $0.lowercased() }).firstIndex(of: "price")
        else { return result }
        
        // Iterating through arrays of attributes for each currency
        wap_rates.data.forEach { quoteArray in
            
            // If the name of the currency and the quote are in the array, then convert them to the desired type and save them.
            guard
                quoteArray.indices.contains(currencyNameIndex),
                quoteArray.indices.contains(priceIndex),
                let rate = Double(quoteArray[priceIndex]),
                let currency = Currency(rawValue: String(quoteArray[currencyNameIndex].prefix(3)).uppercased())
            else { return }
            
            result[currency] = rate
        }
        
        return result
    }
}

// A structure that decodes raw data into arrays of strings
struct RawQuotes: Decodable {
    
    // Decoded fields
    enum CodingKeys: String, CodingKey {
        case columns, data
    }
    
    // Names of currency attribute fields
    let columns: [String]
    
    // Arrays of currency attributes
    let data: [[String]]
    
    init(from decoder: Decoder) throws {
        
        // Decode the columns attribute into an array of strings
        let container = try decoder.container(keyedBy: CodingKeys.self)
        columns = try container.decode([String].self, forKey: .columns)
        
        var result = [[String]]()
        var arraysContainer = try container.nestedUnkeyedContainer(forKey: .data)
        
        // The data attribute containing [Any] arrays requires processing by a special function to convert [Any] to [String]
        while !arraysContainer.isAtEnd {
            var singleArrayContainer = try arraysContainer.nestedUnkeyedContainer()
            let array = singleArrayContainer.decode(fromArray: &singleArrayContainer)
            result.append(array)
        }
        
        data = result
    }
}

// A utility function that converts [Any] to [String]. The UnkeyedDecodingContainer allows to decode array values.
extension UnkeyedDecodingContainer {
    
    func decode(fromArray container: inout UnkeyedDecodingContainer) -> [String] {
        
        // Initialize the output array
        var result = [String]()
        
        // Iterating over the values of the input array in a loop
        while !container.isAtEnd {
            
            // The values of the String type as they are
            if let value = try? container.decode(String.self) {
                result.append(value)
                
                // Converting Int values to a string
            } else if let value = try? container.decode(Int.self) {
                result.append("\(value)")
                
                // Converting values of the Double type to a string
            } else if let value = try? container.decode(Double.self) {
                result.append("\(value)")
            }
        }
        return result
    }
}
