//
//  Copyright © 2016 Ryan Stutesman. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var startTimePicker: UIDatePicker!
    var endTimePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickers()
    }
    
    func setupPickers() {
        startTimePicker = UIDatePicker(frame: CGRect.zero)
        startTimePicker.datePickerMode = .time
        endTimePicker = UIDatePicker(frame: CGRect.zero)
        endTimePicker.datePickerMode = .time
    }
    
    func showErrorAlert(_ title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
