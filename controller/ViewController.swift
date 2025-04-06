//
//  ViewController.swift
//  WanderLog
//
//  Created by User on 02.04.25.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    var travelList:[TravelData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        loadData()
    }
    
    func loadData(){
        travelList = CoreDataManager.shared.fetchTravelData()
        self.tableview.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    func deleteTravelData(at indexPath: IndexPath) {
        let travelData = travelList[indexPath.row]
        CoreDataManager.shared.deleteTravel(travel: travelData)
        travelList.remove(at: indexPath.row)
        tableview.deleteRows(at: [indexPath], with: .automatic)
    }
    @objc
    func addButtonClicked(){
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
}

extension ViewController:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let cityName = travelList[indexPath.row].cityName ?? " "
        cell.textLabel?.text = cityName
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            let travelData = self.travelList[indexPath.row]
            CoreDataManager.shared.deleteTravel(travel: travelData)
            self.travelList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        deleteAction.backgroundColor = .red
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return config
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTravel = travelList[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailsVC = storyboard.instantiateViewController(withIdentifier: "TravelDetailsVC") as? TravelDetailsVC {
            detailsVC.travelData = selectedTravel
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    
}

