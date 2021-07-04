//
//  ViewController.swift
//  CI-CD
//
//  Created by Kunal Tyagi on 27/06/21.
//

import UIKit
import AppCenterCrashes
import AppCenterAnalytics

class ViewController: UIViewController {

    @IBOutlet weak var montlyInvestmentTextField: UITextField!
    @IBOutlet weak var currentAgeTextField: UITextField!
    @IBOutlet weak var retirementAgeTextField: UITextField!
    @IBOutlet weak var interestRateTextField: UITextField!
    @IBOutlet weak var currentSavingsTextField: UITextField!
    @IBOutlet weak var resultsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Crashes.hasCrashedInLastSession {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Oops", message: "Sorry about that, an error occured.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "It's Ok.", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

    @IBAction func calculateAmount(_ sender: Any) {
        //Crashes.generateTestCrash()
        guard let currentAge = Int(currentAgeTextField.text ?? ""), let plannedRetirementAge = Int(retirementAgeTextField.text ?? ""), let monthlyInvestment = Float(montlyInvestmentTextField.text ?? ""), let currentSavings = Float(currentSavingsTextField.text ?? ""), let interestRate = Float(interestRateTextField.text ?? "") else { return }
        resultsLabel.text = "If you save $\(monthlyInvestment) every month for \(plannedRetirementAge - currentAge) years, and invest that money plus your current investment of $\(currentSavings) at a \(interestRate)% annual interest rate, you will have $X by the time you are \(plannedRetirementAge)"
        Analytics.trackEvent("calculate_retirement_amount", withProperties: [
            "currentAge" : String(currentAge),
            "retirementAge" : String(plannedRetirementAge)
        ])
    }
}

