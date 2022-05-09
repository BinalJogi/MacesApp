//
//  RoomsViewController.swift
//  MacesApp
//
//  Created by Binal Jogi on 06/05/2022.
//

import UIKit
import Combine

class RoomsViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel:RoomsViewModel?
    private var bindings = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = RoomsViewModel(roomsRepository: RoomsRepository())
        
        activityIndicator.startAnimating()

        viewModel?.submitAction(action: .loadRooms(ApiRequest(baseUrl: EndPoint.baseUrl, path: Path.rooms, params: [:])))
        
        setupBinding()
    }
    
    private func setupBinding() {
        viewModel?.$state.receive(on: RunLoop.main).sink(receiveValue: { states in
            switch states {
            case .showActivityIndicator:
                print("")
            case .showRooms:
                self.tableView.isHidden = false
                self.tableView.reloadData()
            case .showError(_):
                print("")
            case .none:
                print("")
            }
        }).store(in: &bindings)
    }
}

extension RoomsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfRooms ?? 0

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? RoomsTableViewCell else {
            return UITableViewCell()
        }
        
        if let room = viewModel?.getRoom(for:indexPath.section) {
            cell.configureData(room: room)
        }
        
        return cell
    }
}

