//
//  NotesViewController.swift
//  GamesTemple
//
//  Created by Furkan Sarı on 14.12.2022.
//

import UIKit

final class NotesViewController: BaseViewController {
    
    @IBOutlet weak var notesTableView: UITableView! {
        didSet {
            notesTableView.delegate = self
            notesTableView.dataSource = self
        }
    }
    var games = [Note]()
    var selectedGame : Note?
    //MARK: LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating()
        notesTableView.register(UINib(nibName: "NotesTableViewCell", bundle: nil), forCellReuseIdentifier: "NoteCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        games = NoteCoreDataManager().getNote()
        indicator.stopAnimating()
        notesTableView.reloadData()
    }
    
    
    @IBAction func addNotesButton(_ sender: Any) {
        performSegue(withIdentifier: "addNoteView", sender: nil)
    }
    
    
}
//MARK: NotesTableView
extension NotesViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = notesTableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as? NotesTableViewCell else { return UITableViewCell() }
        let model = games[indexPath.row]
        cell.configure(noteModel: model)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedGame = games[indexPath.row]
        performSegue(withIdentifier: "updateNoteView", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let noteObject = games[indexPath.row]
            games.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            NoteCoreDataManager().managedContext.delete(noteObject)
            
            do {
                try  NoteCoreDataManager().managedContext.save()
            } catch {
                showErrorAlert(message: "Favorite Game is not deleted!")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addNoteView" {
            let addNoteView = segue.destination as? AddNoteViewController
            addNoteView?.noteDelegate = self
            addNoteView?.buttonTitle = "Add Note"
        } else {
            let updateNoteView = segue.destination as? AddNoteViewController
            updateNoteView?.updateStatus = true
            updateNoteView?.updateNoteModel = selectedGame
            updateNoteView?.noteDelegate = self
            updateNoteView?.buttonTitle = "Update Note"
        }
        
    }
    
}
//MARK: NoteDelegate
extension NotesViewController : NoteDelegate {
    func noteOperations() {
        games = NoteCoreDataManager().getNote()
        notesTableView.reloadData()
    }
    
    
}
