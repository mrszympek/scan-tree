//  Created by Kamil Zajac on 16/09/2019.
//  Copyright (c) 2019 KamilZając. All rights reserved.

import UIKit
import AVFoundation
import QRCodeReader

protocol HomeRoutingLogic: Router {
    func navigateToProductDetails()
    func showQRCodeScanner()
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing {
    @objc weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
    
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            
            $0.showTorchButton        = false
            $0.showSwitchCameraButton = false
            $0.showOverlayView        = true
            $0.rectOfInterest         = CGRect(x: 0.1, y: 0.25, width: 0.8, height: 0.5)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()

    // MARK: Routing
    
    @objc func routeToProductDetails(withSegue segue: UIStoryboardSegue?) {
        guard let destinationVC = segue?.destination as? ProductDetailsViewController,
        var destinationDS = destinationVC.router?.dataStore,
            let dataStore = dataStore else {
                return
        }
        passDataToProductDetails(sourceDS: dataStore, destinationDS: &destinationDS)
    }

    // MARK: Navigation
    
    func navigateToProductDetails() {
        viewController?.performSegue(withIdentifier: "ProductDetails", sender: nil)
    }
    
    func showQRCodeScanner() {
        readerVC.delegate = viewController
        
        // Presents the readerVC as modal form sheet
        readerVC.modalPresentationStyle = .formSheet
        
        viewController?.present(readerVC, animated: true, completion: nil)
    }

    // MARK: Passing data
    
    func passDataToProductDetails(sourceDS: HomeDataStore, destinationDS: inout ProductDetailsDataStore) {
        destinationDS.selectedProduct = sourceDS.selectedProduct
    }

}
