import UIKit

class CalenderCollectionViewInteractor: NSObject {
    weak var collectionView: CalenderCollectionView?
    
    var calendarAA = Calendar.current
    
    private lazy var dateFormatter: DateFormatter = {
      let dateFormatter = DateFormatter()
      dateFormatter.calendar = Calendar(identifier: .gregorian)
      dateFormatter.setLocalizedDateFormatFromTemplate("MM/dd")
      return dateFormatter
    }()
    
    private(set) var days: [Day]?
        
    func configure(_ collectionView: CalenderCollectionView) {
        self.collectionView = collectionView
        
        collectionView.dataSource = self
    }
    
    func setDay(_ days: [Day]?) {
        self.days = days
        
        collectionView?.reloadData()
    }
}

extension CalenderCollectionViewInteractor: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let days = days else {
            return 0
        }
        
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let days = days, !days.isEmpty else {
            return UICollectionViewCell()
        }
        
        let cell = collectionView
            .dequeueReusableCell(
                withReuseIdentifier: String(describing: CalendarCell.self),
                for: indexPath
            ) as? CalendarCell
        
        if let cell = cell {
            cell.dateText = dateFormatter.string(from: days[indexPath.row].date)
            return cell
        }
        
        return UICollectionViewCell()
    }
}
