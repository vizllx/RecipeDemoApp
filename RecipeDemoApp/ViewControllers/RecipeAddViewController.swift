//
//  RecipeAddViewController.swift
//  RecipeDemoApp
//
//  Created by Sandeep Mukherjee on 03.03.20.
//  Copyright © 2020 Sandeep Mukherjee. All rights reserved.
//

import UIKit

class RecipeAddViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet weak var recipeTitle: UITextField!
    @IBOutlet weak var recipeCategory: UITextField!
    @IBOutlet weak var recipeIngredients: UITextField!
    @IBOutlet weak var recipeSteps: UITextField!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var addRecipeBtn: UIButton!

    var imagePicker: UIImagePickerController!
    fileprivate  var viewModel: RecipeAddViewModel? = RecipeAddViewModel()
    fileprivate let pickerView = CustomPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()


        // Do any additional setup after loading the view.
    }

    fileprivate func setupView()
    {
        self.imagePicker = UIImagePickerController()
        self.imagePicker.delegate = self
        self.recipeCategory.inputView = self.pickerView
        self.recipeCategory.inputAccessoryView = self.pickerView.toolbar
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.pickerView.toolbarDelegate = self
        self.pickerView.reloadAllComponents()

    }

    @IBAction func addImagePressed(_ sender: UIButton) {
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
        sender.setTitle("", for: .normal)

    }

    @IBAction func saveRecipePressed(_ sender: UIButton) {
        viewModel?.saveRecipes(recipeTitle: recipeTitle.text, recipeIngredients: recipeTitle.text, recipeSteps: recipeTitle.text, recipeCategory: recipeTitle.text, recipeImage: recipeImage.image)
    }

}

// MARK: -ImagePickerControllerDelegate
extension RecipeAddViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate
{

 func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let editedImage = info[.originalImage] as? UIImage {
            recipeImage.image = editedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }

}
// MARK: -TextFieldDelegate
extension RecipeAddViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
// MARK: -Picker Data Source & Delegate
extension RecipeAddViewController: UIPickerViewDataSource, UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.viewModel?.getCategories().count ?? 0
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let category = self.viewModel?.getCategories()
        return category?[row].name
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let category = self.viewModel?.getCategories()
        self.recipeCategory.text = category?[row].name
    }
}
// MARK: - CustomPicker Delegate

extension RecipeAddViewController: CustomPickerViewDelegate {

    func didTapDone() {
        let row = self.pickerView.selectedRow(inComponent: 0)
        self.pickerView.selectRow(row, inComponent: 0, animated: false)
        let category = self.viewModel?.getCategories()

        self.recipeCategory.text = category?[row].name
        self.recipeCategory.resignFirstResponder()
    }

    func didTapCancel() {
        self.recipeCategory.text = nil
        self.recipeCategory.resignFirstResponder()
    }
}
