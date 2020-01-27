//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Suman Sigdel on 01/01/2020
//  Copyright © 2020 Suman Sigdel. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didChangeCurrency(bitPrice: Double)
    func didChangeEthCurrency(ethPrice: Double)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    func getBitcoinPrice(for currency: String) {
        let urlString = "\(baseURL)BTC\(currency)"
        performRequest(with: urlString)
    
    }
    func getEthereumPrice(for currency: String) {
        let ethUrlString = "\(baseURL)ETH\(currency)"
        performETHRequest(with: ethUrlString)
    
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
    
    func performETHRequest(with urlString: String){
        // to do
        // create url
        if let url = URL(string: urlString){
            // create a url session
            let session = URLSession(configuration: .default)
            // give the session a task
            let task = session.dataTask(with: url, completionHandler: handleETH(data:response:error:))
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
            if let bitPrice = parseJSON(btcPrice: jsonData) {
                print("The bitcoin price is \(bitPrice)")
                delegate?.didChangeCurrency(bitPrice: bitPrice)
                
                
            }
            
        }
        
    }
    
    func handleETH(data: Data?, response: URLResponse?, error: Error?) {
        if error != nil {
            print(error!)
            return
        }
        
        if let jsonData = data {
       
            if let ethPrice=parseJSON(ethPrice: jsonData){
                print("The eth price is \(ethPrice)")
                delegate?.didChangeEthCurrency(ethPrice: ethPrice)
                
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
    
    func parseJSON(ethPrice: Data) -> Double? {
          let decoder = JSONDecoder()
          do {
              let decodedData = try decoder.decode(ETHData.self, from: ethPrice)
              return decodedData.last
          } catch {
              print(error)
              return nil
              
          }
          
          
          
      }
   
    
}
