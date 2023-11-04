import UIKit
import SwiftUI

class 🄷ostingViewController: UIHostingController<🄼ainView> {
    private let model = 📨ShareExtensionModel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: 🄼ainView(self.model))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model.setUp(self.extensionContext)
    }
}
