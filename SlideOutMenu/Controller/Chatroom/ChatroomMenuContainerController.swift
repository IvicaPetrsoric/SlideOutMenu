import UIKit

class ChatroomMenuContainerController: UIViewController {

    private lazy var chatroomsMenuController = ChatroomsMenuController()
    
    private lazy var searchContainer: SearchContainerView = {
        let searchView = SearchContainerView(searchBarDelegate: self.chatroomsMenuController)
        searchView.backgroundColor = self.backgroundColor
        return searchView
    }()
    
    private let backgroundColor = #colorLiteral(red: 0.2980392157, green: 0.2078431373, blue: 0.2862745098, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = backgroundColor
        
        setupViews()
    }
    
    private func setupViews() {
        guard let chatroomsView = chatroomsMenuController.view else { return }
        
        view.addSubviews(chatroomsView, searchContainer)
               
        searchContainer.anchor(top: view.topAnchor, leading: view.leadingAnchor,
                               bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor,
                               padding: .init(top: 0, left: 0, bottom: -64, right: 0))
        
        chatroomsView.anchor(top: searchContainer.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor,
                             bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
    
}

