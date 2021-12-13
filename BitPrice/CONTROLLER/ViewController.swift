//
//  ViewController.swift
//  BitPrice
//
//  Created by Maikon Ferreira on 11/12/21.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CoinManagerDelegate {
   

    //MARK: - OUTLETS
    @IBOutlet weak var bitCoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    
    //MARK: - VARS
    var coinManager = CoinManager()
    
    
    //MARK: - PICKER VIEW DATASOURCE
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let numberOfComponents = coinManager.currencyArray.count
        print(numberOfComponents)
        return numberOfComponents
       
    }
    
    
  
    //MARK: - PICKER VIEW DELEGATE FUNCS
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let titles = coinManager.currencyArray[row]
        return titles
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row)
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCurrenyPrice(for: selectedCurrency)
        currencyLabelUpdated(currency: selectedCurrency)
        
    }
  
    
    //MARK: - FUNCAO PRECO
    func didUpdatePrice(price: String) {
        
        DispatchQueue.main.async {
            self.bitCoinLabel.text = price
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }

    //MARK: - FUNCAO CURRENCYLABEL
    func currencyLabelUpdated(currency: String) {
        currencyLabel.text = currency
    }
    
    
    //MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        coinManager.delegate = self
        currencyPicker.setValue(UIColor.white, forKey: "textColor")
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
        
    }

}


