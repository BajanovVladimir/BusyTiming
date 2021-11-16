import UIKit

class TableViewListController: UITableViewController {
    
    var timer =  MainTimerUse()
    var activity = ListOfActivityModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if activity.ListOfActivity.count > 0 {
            activity.activityName = activity.ListOfActivity[activity.selectedIndex].name
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    @IBAction func addActivityPress(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Enter the name of  the affair", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "New affair"
        }
        let alertAction1 = UIAlertAction(title: "Cancel", style:.destructive) {
            (alert) in
        }
        let alertAction2 = UIAlertAction(title: "Create", style: .cancel) {
            (alert) in
            guard let newName = alertController.textFields?[0].text else {
                return
            }
            self.activity.addActivity(nameOfActivity: newName)
            self.tableView.reloadData()
        }
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func chooseTheActivityButtonPress(_ sender: UIBarButtonItem) {
        if activity.ListOfActivity.count > 0 {
            let storyboard    = UIStoryboard(name:"Main",    bundle:   Bundle.main)
            let vc =  storyboard.instantiateViewController(identifier: "TimerVC") as! TimerViewController
            vc.activity  = activity
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activity.ListOfActivity.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        let currentList = activity.ListOfActivity[indexPath.row]
        let currentName = currentList.name
        let currentTime = currentList.time
        let curentTimeString = timer.conversionOfTimeFromSecondsToString(currentTime)
        cell.textLabel?.text = currentName + "     " + curentTimeString
        if currentList.isSelected == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
   
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            activity.deleteActivity(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        activity.changeState(index: indexPath.row)
        tableView.reloadData()
    }
  
}

