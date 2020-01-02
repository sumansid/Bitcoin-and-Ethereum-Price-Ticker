//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Suman Sigdel on 01/01/2020
//  Copyright © 2020 Suman Sigdel. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didChangeCurrency(price: Double)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)\(currency)"
        performRequest(with: urlString)
    
    }
    
    func performRequest(with urlString: String) {
        // to do
        // create url
        if let url = URL(string: urlString){
            // create a url session
            let session = URLSession(configuration: .default)
            // give the session a task
            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            // start the task
            task.resume()
            
            
        }
        

    }
    func handle(data: Data?, response: URLResponse?, error: Error?) {
        if error != nil {
            print(error!)
            return
        }
        if let jsonData = data {
            if let price = parseJSON(btcPrice: jsonData){
                delegate?.didChangeCurrency(price: price)
                
            }

        }
        
    }
    
    func parseJSON(btcPrice: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(BTCData.self, from: btcPrice)
            return decodedData.last
        } catch {
            print(error)
            return nil
            
        }
        
        
        
    }
   
    
}
