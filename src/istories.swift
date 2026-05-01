import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension URLSession {
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        return try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: request) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data, let response = response {
                    continuation.resume(returning: (data, response))
                } else {
                    continuation.resume(throwing: URLError(.unknown))
                }
            }
            task.resume()
        }
    }
}

public class Istories{
    private let api = "https://istories.media/page-data"
    private let api_2 = "https://important-stories.com"
    private var headers: [String: String]
    
    public init() {
        self.headers = [
        "Accept":"*/*",
        "Connection":"keep-alive",
        "Accept-Encoding":"deflate, zstd",
        "Accept-Language":"en-US,en;q=0.9",
        "User-Agent":"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36"
        ]

    }
    
    public func get_page_data(path: String) async throws -> Any {
        //https://istories.media/page-data/stories/2026/04/23/mat-glavi-prezidentskoi-administratsii-antona-vaino-zarabotala-kredituya-oboronku/page-data.json
        //https://istories.media/page-data/radio/2025/12/22/razgovori-ovazhnikh/page-data.json
        //https://istories.media/page-data/news/2026/04/30/za-vremya-voini-chislo-zaklyuchennikh-v-sizo-sokratilos-bolee-chem-na-chetvert/page-data.json
        //https://istories.media/page-data/opinions/2026/04/27/pochemu-rossiyane-ekonomyat-yesli-ofitsialno-ikh-dokhodi-rastut/page-data.json
        //https://istories.media/page-data/cases/2025/11/20/delo-o-propagande/page-data.json
        //https://istories.media/page-data/workshops/2025/09/29/stazhirovka-v-data-otdele-vazhnikh-istorii-nabor-otkrit/page-data.json
        //https://istories.media/page-data/audio/2026/04/14/portret-lavrova-kak-glavnii-diplomat-rossii-vibral-putina-i-voinu/page-data.json
        let urlString = "\(api)\(path)page-data.json"
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: -1)
        }
        var request = URLRequest(url: url)
        request.timeoutInterval = 30.0
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONSerialization.jsonObject(with: data)
    }

    public func get_workshops() async throws -> Any {
        let urlString = "\(api)/workshops/page-data.json"
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: -1)
        }
        var request = URLRequest(url: url)
        request.timeoutInterval = 30.0
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONSerialization.jsonObject(with: data)
    }

    public func get_specprojects() async throws -> Any {
        let urlString = "\(api)/specprojects/page-data.json"
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: -1)
        }
        var request = URLRequest(url: url)
        request.timeoutInterval = 30.0
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONSerialization.jsonObject(with: data)
    }


    public func get_similar_materials(material_id: String, tags: [String],locale: String = "ru",limit: Int = 3) async throws -> Any {
        let urlString = "\(api)/similar_materials/"
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: -1)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 30.0
        let body: [String: Any] = ["material_id": material_id,"tags": tags,"locale": locale,"limit": limit]
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        
        let (responseData, _) = try await URLSession.shared.data(for: request)
        let json = try JSONSerialization.jsonObject(with: responseData)
        return json
    }

    public func get_news() async throws -> Any {
        let urlString = "\(api)/news/page-data.json"
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: -1)
        }
        var request = URLRequest(url: url)
        request.timeoutInterval = 30.0
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONSerialization.jsonObject(with: data)
    }

    public func get_charon() async throws -> Any {
        let urlString = "\(api)/charon/page-data.json"
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: -1)
        }
        var request = URLRequest(url: url)
        request.timeoutInterval = 30.0
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONSerialization.jsonObject(with: data)
    }

}
