//
//  AddEditViewController.swift
//  Carangas
//
//  Copyright © 2018 Eric Brito. All rights reserved.
//

import UIKit

class AddEditViewController: UIViewController {
    
    var car: Car!
    
    @IBOutlet weak var tfBrand: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var scGasType: UISegmentedControl!
    @IBOutlet weak var btAddEdit: UIButton!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if car != nil {
            tfBrand.text = car.brand
            tfName.text = car.name
            tfPrice.text = "\(car.price)"
            scGasType.selectedSegmentIndex = car.gasType
        }
    }
    
    @IBAction func addEdit(_ sender: UIButton) {
        var operation = RESTOperation.update
        if car == nil {
            car = Car()
            operation = .save
        }
        
        car.brand = tfBrand.text!
        car.name = tfName.text!
        car.gasType = scGasType.selectedSegmentIndex
        
        let formatter = NumberFormatter()
        let price = formatter.number(from: tfPrice.text!)?.intValue ?? 0
        
        car.price = price
        
        REST.applyOperation(operation, car: car) { [weak self] (success) in
            DispatchQueue.main.async {
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
}
