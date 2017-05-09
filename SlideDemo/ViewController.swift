//
//  ViewController.swift
//  SlideDemo
//
//  Created by M on 02/05/17.
//  Copyright © 2017 AJ. All rights reserved.
//

import UIKit
import SideMenu
import MapKit

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var tableView: UITableView!
    
    let allTableData = ["Type above to search text",
                       "Reading from private effective user settings",
                       "Note that these continue to work on the Navigation Controller",
                       "View Controller",
                       "Table View Controller",
                       "Content View Controller",
                       "Map View Controller",
                       "Demo View Controller"]
    
    var filteredTableData = NSMutableArray()
    
    var isFiltered: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.tableFooterView = UIView()

        setupSideMenu()
        setDefaults()
        
        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
        tracker.set(kGAIScreenName, value: "Map View Controller")
        
        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
        tracker.send(builder.build() as [NSObject : AnyObject])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    fileprivate func setupSideMenu() {
        // Define the menus
        SideMenuManager.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
        
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
        // Set up a cool background image for demo purposes
//        SideMenuManager.menuAnimationBackgroundColor = UIColor(patternImage: UIImage(named: "background")!)
    }
    
    fileprivate func setDefaults() {
        SideMenuManager.menuWidth = 60
        SideMenuManager.menuFadeStatusBar = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty
        {
            isFiltered = false
        }
        else
        {
            isFiltered = true;
            filteredTableData.removeAllObjects()
            
            for strItem in allTableData {
                if strItem.contains(searchText) {
                    filteredTableData.add(strItem)
                }
            }
        }
        
        self.tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltered {
            return filteredTableData.count
        } else {
            return allTableData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath)
        
        if isFiltered {
            cell.textLabel?.text = (filteredTableData.object(at: indexPath.row) as! String)
        } else {
            cell.textLabel?.text = allTableData[indexPath.row] 
        }
        
        return cell
    }
}

