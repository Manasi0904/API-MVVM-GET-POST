//
//  ViewController.swift
//  FetchPOST2
//
//  Created by Kumari Mansi on 10/12/24.
//



import UIKit
class ViewController: UIViewController {
    @IBOutlet var storeListTableView: UITableView!
   
    var storeViewModels: [StoreViewModel] = []
    var customDetailUIView: CustomDetailUIView?
    override func viewDidLoad() {
        super.viewDidLoad()
        storeListTableView.layer.cornerRadius = 10
        storeListTableView.delegate = self
        storeListTableView.dataSource = self
        storeListTableView.separatorStyle = .none

        
        storeListTableView.register(UINib(nibName: "StoreListTableViewCell", bundle: nil), forCellReuseIdentifier: "StoreListTableViewCell")
        ApiService.shared.fetchStoreData { gettingdata in
            switch gettingdata {
            case .success(let stores):
                self.storeViewModels = stores.map { StoreViewModel(store: $0) }
                DispatchQueue.main.async {
                    self.storeListTableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching stores: \(error.localizedDescription)")
            }
        }
    }
}
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeViewModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreListTableViewCell", for: indexPath) as! StoreListTableViewCell
        let viewModel = storeViewModels[indexPath.row]
        cell.configure(with: viewModel)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(102)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedViewModel = storeViewModels[indexPath.row]
        showFullScreenPopup(with: selectedViewModel)
    }
    private func showFullScreenPopup(with viewModel: StoreViewModel) {
    customDetailUIView = CustomDetailUIView(frame: self.view.bounds)
        if let popup = customDetailUIView {
            popup.storeViewModel = viewModel
            self.view.addSubview(popup)

        }
    }
}

