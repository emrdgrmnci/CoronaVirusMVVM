//
//  DetailViewController.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 2.04.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit
import SDWebImage

class MainDetailViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var confirmedCasesLabel: UILabel!
    @IBOutlet weak var totalDeathsLabel: UILabel!
    @IBOutlet weak var totalRecoveredLabel: UILabel!
    @IBOutlet weak var todayCasesLabel: UILabel!
    @IBOutlet weak var todayDeathsLabel: UILabel!
    @IBOutlet weak var criticalCasesLabel: UILabel!
    
    var detailViewModel: MainDetailViewModelInterface!
    private var networkReachability = NetworkReachability()
    
    // MARK: - View's Lifecycle
    
    override func viewDidAppear(_ animated: Bool) {
        //MARK: - NetworkReachability
        if !networkReachability.isReachable {
            let alert = UIAlertController(title: "Oops!", message: "You're offline! Check your network connection.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailViewModel.delegate = self
        detailViewModel.load()
    }
}

extension MainDetailViewController: MainDetailViewModelDelegate {
    func prepareDetailViewInfos(_ presentation: MainDetailPresentation) {
        let imageURL = URL(string: presentation.countryFlagImage)
        backgroundImageView.sd_setImage(with: imageURL,
                                        placeholderImage: UIImage(named: "placeholder.png"))
        confirmedCasesLabel.text = presentation.confirmedCasesLabelText
        totalDeathsLabel.text = presentation.totalDeathsLabelText
        totalRecoveredLabel.text = presentation.totalRecoveredLabelText
        todayCasesLabel.text = presentation.todayCasesLabelText
        todayDeathsLabel.text = presentation.todayDeathsLabelText
        criticalCasesLabel.text = presentation.criticalCasesLabelText
    }
}
