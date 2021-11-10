import UIKit

class TableViewListController: UITableViewController {
    
    var timer =  MainTimerUse()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        affairName = ListOfAffairs[selectedIndex]["Name"]  as!  String
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    @IBAction func addAffairPress(_ sender: UIBarButtonItem) {
        if ListOfAffairs.count == 1 {
        }
        let alertController = UIAlertController(title: "Enter the name of  the affair", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "New affair"
        }
        let alertAction1 = UIAlertAction(title: "Cancel", style:.destructive) {
            (alert) in
        }
        
        let alertAction2 = UIAlertAction(title: "Create", style: .cancel) {
            (alert) in
            guard let newAffairName = alertController.textFields?[0].text else {
                return
            }
            addAffair(newAffairName)
            self.tableView.reloadData()
        }
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        present(alertController, animated: true, completion: nil)
    }
    @IBAction func chooseTheAffaireButtonPress(_ sender: UIBarButtonItem) {
        if ListOfAffairs.count > 0 {
            guard let vc = storyboard?.instantiateViewController(identifier: "TimerVC") else { return  }
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
       
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListOfAffairs.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        let currentList = ListOfAffairs[indexPath.row]
        let currentName = currentList["Name"] as? String ?? ""
        let currentTime = currentList["Time"] as? Int ?? 0
        let curentTimeString = timer.conversionOfTimeFromSecondsToString(currentTime)
        cell.textLabel?.text = currentName + "     " + curentTimeString
        if (currentList["isSelected"] as? Bool) == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
  

   
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
   


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteAffairs(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        changeState(index: indexPath.row)
        tableView.reloadData()

    }
  
 
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
  

 
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}