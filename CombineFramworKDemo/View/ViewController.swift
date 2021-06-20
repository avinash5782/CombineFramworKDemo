//
//  ViewController.swift
//  CombineFramworKDemo
//
//  Created by Avinash on 20/06/21.
//

import UIKit
import Combine
class ViewController: UITableViewController{
    
    var user :[userData] = []
    var dataModel : viewModelClass!
    var mytableView: UITableView!
    var subscriber :AnyCancellable?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mytableView = UITableView()
        self.view.addSubview(self.mytableView)
        setupViewMOdel()
        
    }
    
    func setupViewMOdel() {
        let apiManger = ApiManager()
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")
        dataModel = viewModelClass(apiMange: apiManger, Url: url!)
        obsrableData()
        fetchData()

    }
    func fetchData() {
        dataModel.fetdata()
    }
    func obsrableData() {
        print("called")
       subscriber =  dataModel.passthroughobj.sink(receiveCompletion: { (value) in
            switch value {
            case .failure( _):  print("data recieved")
            case .finished:  print("data recieved")
            }
        }) { (data) in
            self.user = data
            print("data recieved")
            self.tableView.reloadData()
        }
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "TestCell")
        let userdata = user[indexPath.item]
        cell.textLabel?.text = userdata.name
        cell.detailTextLabel?.text = userdata.email
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count
    }

}


