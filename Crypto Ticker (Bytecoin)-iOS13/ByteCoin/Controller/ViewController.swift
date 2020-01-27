//
//  ViewController.swift
//  ByteCoin
//
//  Created by Suman Sigdel on 01/01/2020
//  Copyright © 2020 Suman Sigdel. All rights reserved.
//


import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CoinManagerDelegate {
   

    var coinManager = CoinManager()
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return coinManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        coinManager.getBitcoinPrice(for: coinManager.currencyArray[row])
        coinManager.getEthereumPrice(for: coinManager.currencyArray[row])
        currencyLabel.text = coinManager.currencyArray[row]
        ethCurrencyLabel.text = coinManager.currencyArray[row]
        
    }
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    
    @IBOutlet weak var ethLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var ethCurrencyLabel: UILabel!
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func didChangeCurrency(bitPrice: Double) {
        
        DispatchQueue.main.async {
            self.bitcoinLabel.text = String(bitPrice)
        
            
        }
        

    }
    
    func didChangeEthCurrency(ethPrice: Double) {
        
        DispatchQueue.main.async {
            
            self.ethLabel.text = String(ethPrice)
            
        }
        
       
        
    }



}


    
    


