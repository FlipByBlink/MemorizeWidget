import UIKit
import SwiftUI

class 📨HostingViewController: UIHostingController<📨RootView> {
    private let model = 📨ShareExtensionModel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: 📨RootView(self.model))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model.setUp(self.extensionContext)
    }
}
