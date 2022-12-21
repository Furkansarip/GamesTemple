//
//  AddNoteViewController.swift
//  GamesTemple
//
//  Created by Furkan Sarı on 14.12.2022.
//

import UIKit
import AlamofireImage

protocol NoteDelegate {
    func noteOperations()
}

final class AddNoteViewController: BaseViewController {
    
    var noteDelegate : NoteDelegate?
    //MARK: IBOutlets
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var gameTextField: UITextField!
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var headerTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var noteViewButton: UIButton!
    //MARK: Variables
    var games : [NoteGamesModel]?
    var viewModel = NotesViewModel()
    let gamePicker = UIPickerView()
    var gameImageValue : String?
    var gameName : String?
    var starRating = 3.0
    var gameImage : String?
    var buttonTitle = "Add Note"
    var updateStatus = false
    var updateNoteModel : Note?
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        noteViewButton.setTitle(buttonTitle, for: .normal)
        if updateStatus {
            headerTextField.text = updateNoteModel?.header
            noteTextField.text = updateNoteModel?.noteText
            gameTextField.text = updateNoteModel?.gameName
            cosmosView.rating = updateNoteModel?.rating ?? 0.0
            gameTextField.isEnabled = false
            guard let imageURL = URL(string: updateNoteModel?.gameImage ?? "") else { return }
            gameImageView.af.setImage(withURL: imageURL)
        }
        cosmosView.settings.fillMode = .precise
        gameTextField.inputView = gamePicker
        gamePicker.delegate = self
        gamePicker.dataSource = self
        createToolbar()
        viewModel.delegate = self
        viewModel.fecthGames()
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButton))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cosmosView.didTouchCosmos = { rating in
            self.starRating = rating
        }
    }
    //MARK: Toolbar
    func createToolbar(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPicker))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        gameTextField.inputAccessoryView = toolbar
    }
    
    @objc func dismissPicker() {
        view.endEditing(true)
    }
    
    @objc func doneButton(){
        
        dismiss(animated: true)
        
    }
    //MARK: Add or Uptade Button functionality
    @IBAction func addNoteButton(_ sender: UIButton) { // Gelen case update ise buton adı değişiyor ve eşleşmeler yapılıyor.
        let buttonTitle = NoteOperations(rawValue: sender.titleLabel?.text ?? "")
        switch buttonTitle {
        case .addNote:
            if headerTextField.text != "" && gameTextField.text != "" && noteTextField.text != "" {
                NoteCoreDataManager().saveNote(rating:starRating , gameImage: gameImageValue ?? "", gameName: gameName ?? "", header: headerTextField.text! ,noteText: noteTextField.text!)
                noteDelegate?.noteOperations()
                dismiss(animated: true)
            } else {
                showErrorAlert(message: "Reason : Empty Value")
            }
        case .updateNote:
            if headerTextField.text != "" && gameTextField.text != "" && noteTextField.text != "" {
                updateNoteModel?.header = headerTextField.text
                updateNoteModel?.noteText = noteTextField.text
                updateNoteModel?.rating = starRating
                do {
                    try NoteCoreDataManager().managedContext.save()
                    noteDelegate?.noteOperations()
                    dismiss(animated: true)
                } catch {
                    showErrorAlert(message: "Note Update Failed!")
                }
            } else {
                showErrorAlert(message: "Reason : Empty Value")
            }
            
        case .none:
            showErrorAlert(message: "Button Title Error")
        }
        
    }
}

//MARK: UIPickerView Extensions
extension AddNoteViewController : UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return games?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return games?[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gameTextField.text = games?[row].name
        gameImageValue = games?[row].image ?? ""
        gameName = games?[row].name
        gameImage = games?[row].image ?? ""
        guard let imageURL = URL(string: gameImage ?? "") else { return }
        gameImageView.af.setImage(withURL: imageURL)
    }
}
//MARK: NotesViewDelegate
extension AddNoteViewController : NotesViewDelegate {
    func noteLoaded() {
        DispatchQueue.main.async {
            self.games = self.viewModel.games
            self.gamePicker.reloadInputViews()
        }
    }
    
    func noteFailed(error: ErrorModel) {
        showErrorAlert(message: error.rawValue)
    }
}
