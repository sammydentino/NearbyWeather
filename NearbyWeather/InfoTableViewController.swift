//
//  InfoTableViewController.swift
//  NearbyWeather
//
//  Created by Erik Maximilian Martens on 16.04.17.
//  Copyright © 2017 Erik Maximilian Martens. All rights reserved.
//

import UIKit
import SafariServices

class InfoTableViewController: UITableViewController {
    
    //MARK: - Assets

    @IBOutlet weak var appTitleLabel: UILabel!
    @IBOutlet weak var appVersionLabel: UILabel!
    
    @IBOutlet weak var legendEntryLabel_1: UILabel!
    @IBOutlet weak var legendEntryLabel_2: UILabel!
    @IBOutlet weak var legendEntryLabel_3: UILabel!
    @IBOutlet weak var legendEntryLabel_4: UILabel!
    
    @IBOutlet weak var supportNoteLabel: UILabel!
    @IBOutlet weak var supportAddressLabel: UILabel!
    
    @IBOutlet weak var sourceNoteLabel: UILabel!
    @IBOutlet weak var sourceAddressLabel: UILabel!
    
    @IBOutlet weak var developerName_0: UILabel!
    
    
    //MARK: - ViewController Life Cycle
    
    /* View */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = NSLocalizedString("InfoTVC_NavigationItemTitle", comment: "")
        
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configure()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        var urlStringValue: String?
        if indexPath.section == 2 && indexPath.row == 0 {
            urlStringValue = "http://www.erikmartens.de/contact.html"
            
        }
        if indexPath.section == 2 && indexPath.row == 1 {
            urlStringValue = "https://github.com/erikmartens/NearbyWeather"
        }
        if indexPath.section == 3 && indexPath.row == 0 {
            urlStringValue = "http://www.erikmartens.de"
        }
        
        guard let urlString = urlStringValue,
            let url = URL(string: urlString) else {
                return
        }
        let safariController = SFSafariViewController(url: url)
        if #available(iOS 10, *) {
            safariController.preferredControlTintColor = .nearbyWeatherStandard
        } else {
            safariController.view.tintColor = .nearbyWeatherStandard
        }
        present(safariController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1: return NSLocalizedString("InfoTVC_TableViewSectionHeader2", comment: "")
        case 2: return NSLocalizedString("InfoTVC_TableViewSectionHeader3", comment: "")
        case 3: return NSLocalizedString("InfoTVC_TableViewSectionHeader4", comment: "")
        default: return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    // MARK: - Interface Setup
    
    private func configure() {
        navigationController?.navigationBar.styleStandard(withTransluscency: false, animated: true)
        navigationController?.navigationBar.addDropShadow(offSet: CGSize(width: 0, height: 1), radius: 10)
        configureText()
    }
    
    private func configureText() {
        appTitleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        appTitleLabel.text! = NSLocalizedString("InfoTVC_AppTitle", comment: "")
        
        legendEntryLabel_1.font = UIFont.preferredFont(forTextStyle: .subheadline)
        legendEntryLabel_1.text! = NSLocalizedString("InfoTVC_Legend_Temperature", comment: "")
        legendEntryLabel_2.font = UIFont.preferredFont(forTextStyle: .subheadline)
        legendEntryLabel_2.text! = NSLocalizedString("InfoTVC_Legend_CloudCover", comment: "")
        legendEntryLabel_3.font = UIFont.preferredFont(forTextStyle: .subheadline)
        legendEntryLabel_3.text! = NSLocalizedString("InfoTVC_Legend_Humidity", comment: "")
        legendEntryLabel_4.font = UIFont.preferredFont(forTextStyle: .subheadline)
        legendEntryLabel_4.text! = NSLocalizedString("InfoTVC_Legend_WindSpeed", comment: "")
        
        appVersionLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        appVersionLabel.text! = NSLocalizedString("InfoTVC_AppVersion", comment: "")
        
        supportNoteLabel.font = UIFont.preferredFont(forTextStyle: .body)
        supportNoteLabel.text! = NSLocalizedString("InfoTVC_Support", comment: "")
        
        supportAddressLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        supportAddressLabel.textColor = .nearbyWeatherStandard
        
        sourceNoteLabel.font = UIFont.preferredFont(forTextStyle: .body)
        sourceNoteLabel.text! = NSLocalizedString("InfoTVC_Source", comment: "")
        
        sourceAddressLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        sourceAddressLabel.textColor = .nearbyWeatherStandard
        
        developerName_0.font = UIFont.preferredFont(forTextStyle: .body)
    }
}
