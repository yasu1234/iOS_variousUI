import UIKit

struct Day {
  let date: Date
  let number: String
}

struct MonthMetadata {
  let numberOfDays: Int
  let firstDay: Date
  let firstDayWeekday: Int
}

class CalenderViewController: UIViewController {
    @IBOutlet private weak var collectionview: CalenderCollectionView!
    
    private let collectionViewInteractor = CalenderCollectionViewInteractor()
    private let calendar = Calendar(identifier: .gregorian)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        setupUI()
    }
}

extension CalenderViewController {
    private func setupData() {
        let lastDate = lastDateOfMonth()
        let days = generateDaysInMonth()
        collectionViewInteractor.setDay(days)
    }
    
    private func lastDateOfMonth() -> Date {
        let component = calendar.dateComponents([.year, .month], from: Date())
        let firstDay = calendar.date(from: component)!
        let add = DateComponents(month: 1, day: 0)
        
        return calendar.date(byAdding: add, to: firstDay)!
    }
    
    private func generateDaysInMonth() -> [Day]? {
        guard let metaData = try? monthMetaData(for: Date()) else {
            return nil
        }
        
        let offsetInInitialRow = metaData.firstDayWeekday
        
        let days: [Day] = (1..<(metaData.numberOfDays + offsetInInitialRow))
            .map { day in
                let isSelectable = day >= metaData.firstDayWeekday
                let dayOffset = isSelectable ? day - offsetInInitialRow: -(offsetInInitialRow - day)
                
                return generateDay(
                    offsetBy: dayOffset,
                    baseDate: metaData.firstDay,
                    isSelectable: isSelectable
                )
            }
        return days
    }
    
    private func monthMetaData(for baseDate: Date) throws -> MonthMetadata? {
        guard let numberOfDaysInMonth = calendar.range(of: .day,
                                                       in: .month,
                                                       for: baseDate)?.count,
              let firstDayOfMonth = calendar.date(
                from: calendar.dateComponents([.year, .month],
                                              from: baseDate)
              ) else {
                  return nil
              }
        
        let firstDayWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        
        return MonthMetadata(numberOfDays: numberOfDaysInMonth,
                             firstDay: firstDayOfMonth,
                             firstDayWeekday: firstDayWeekday)
    }
    
    private func generateDay(offsetBy dayOffset: Int,
                             baseDate: Date,
                             isSelectable: Bool) -> Day {
        let date = calendar.date(byAdding: .day, value: dayOffset, to: baseDate) ?? baseDate
        
        return Day(date: date, number: "")
    }
}

extension CalenderViewController {
    private func setupUI() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionViewInteractor.configure(collectionview)
    }
}


extension CalenderViewController: StoryboardInstance {
    static func newInstance() -> CalenderViewController {
        let controller = UIStoryboard(name:CalenderViewController.storyboardName(), bundle: nil).instantiateViewController(withIdentifier: CalenderViewController.identifer()) as! CalenderViewController
        
        return controller
    }
    
    static func storyboardName() -> String {
        return "List"
    }
    
    static func identifer() -> String {
        return String(describing: CalenderViewController.self)
    }
}
