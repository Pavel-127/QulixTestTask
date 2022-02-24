//
//  InfoViewController.swift
//  QulixTestApp
//
//  Created by macbook on 22.02.22.
//

import UIKit

class InfoViewController: UIViewController {
    
    private(set) var movies: [Movies] = []
    
    private var deskription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "test"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.backgroundColor = .white
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Deskription"
        sendMoviesReqest()
        view.addSubview(deskription)
        set()
        self.deskription.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        
    }
    private func sendMoviesReqest() {
        Network.sh.request(urlPath: "movie/popular") { [weak self] (mowiesModel) in
            guard let self = self else { return }
            self.movies = mowiesModel.results
            mowiesModel.results.forEach {
                Swift.debugPrint($0.overview ?? "No")
            }
            
        } errorHendler: {
            print("errorHendler")
        }
    }
    
    func set() {
        self.deskription.text = movies.description
    }
}

