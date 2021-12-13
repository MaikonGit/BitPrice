//
//  CoinManager.swift
//  BitPrice
//
//  Created by Maikon Ferreira on 12/12/21.
//

import Foundation
//MARK: - PROTOCOL
protocol CoinManagerDelegate {
    func didUpdatePrice(price: String)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    //MARK: - ELEMENTS
    var delegate: CoinManagerDelegate?
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "E48A0ABC-6E8B-4EBA-85ED-1D47CBC85D92"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
  
    
    //MARK: - NETWORKING
    func getCurrenyPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        print(urlString)
        
        //Create URL
        if let url = URL(string: urlString) {
           
            //Create a URL Session
            let session = URLSession(configuration: .default)
            //Give a Sessio a task
            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            //Start the task
            task.resume()
        }
            
    }
    
    
    //MARK: - COMPLETION HANDLER
    func handle(data: Data?, response: URLResponse?, error: Error?) {
       //ERROR
        if error != nil {
            self.delegate?.didFailWithError(error: error!)
            return
        }
        // Unwraping data
        if let safeData = data {
            if let price = parseJSON(currencyData: safeData) {
                let priceString = String(round(price * 100) / 100)
                self.delegate?.didUpdatePrice(price: priceString)
                
            }
        }
    }
   
    
    //MARK: - JSON DECODING
    func parseJSON(currencyData: Data) -> Float? {
                      //JSONDecoder thats require data from struct
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: currencyData)
            let lastPrice = decodedData.rate
            return lastPrice
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
        //do, try e catch sao necessarios por causa do Throw
    }
}
