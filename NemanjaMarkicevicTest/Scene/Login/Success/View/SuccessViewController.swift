import UIKit

class SuccessViewController: UIViewController {

    // MARK: - @IBOutlet's
    
    @IBOutlet weak var successTitleLabel: UILabel!
    
    // MARK: - Properties
    
    // Message sent from login to be showned on current screen
    var message: String?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupView()
    }
    
    // MARK: - Helpers
    
    private func setupView() {
        successTitleLabel.textColor = UIColor.darkGray
        
        successTitleLabel.text = message
    }
}
