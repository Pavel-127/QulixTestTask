//
//  ViewController.swift
//  QulixTestApp
//
//  Created by macbook on 22.02.22.
//

import UIKit

class ViewController: UITableViewController {
    
    private(set) var movies: [Movies] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Popular Movies"
        self.tableView.register(TableViewCell.self,
                                forCellReuseIdentifier: TableViewCell.reuseIdentifier )
        self.sendMoviesReqest()
    }
    
    private func sendMoviesReqest() {
        Network.sh.request(urlPath: "movie/popular") { [weak self] (mowiesModel) in
            guard let self = self else { return }
            self.movies = mowiesModel.results
            self.tableView.reloadData()
            
            mowiesModel.results.forEach {
                Swift.debugPrint($0.title)
            }
            
        } errorHendler: {
            print("errorHendler")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath) as? TableViewCell ?? TableViewCell()
        
        cell.setCellData(name: movies[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = InfoViewController()
        navigationController?.pushViewController(detailController, animated: true)
    }
}
