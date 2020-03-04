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
    @IBOutlet weak var scrollView: UIScrollView!

    fileprivate var imagePicker: UIImagePickerController!
    fileprivate  var viewModel: RecipeAddViewModel? = RecipeAddViewModel()
    fileprivate let pickerView = CustomPickerView()
    internal var recipes: Recipes?

    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()

        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - ViewController methods

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
        self.registerKeyboardNotifications()

        if (recipes != nil) {
            self.showRecipeDetails()
        }

    }

    fileprivate func showRecipeDetails()
    {
        recipeTitle.text = recipes?.title
        recipeIngredients.text = recipes?.ingredients
        recipeSteps.text = recipes?.steps
        recipeCategory.text = recipes?.category
        if let image = recipes?.image
        {
            recipeImage.image = UIImage(data:image)
        }

    }

    // MARK: - Keyborad Notification

    fileprivate func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }


    // MARK: - IBOutlet actions

    @IBAction func addImagePressed(_ sender: UIButton) {
        self.view.endEditing(true)
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
        sender.setTitle("", for: .normal)

    }

    // MARK: - Bar actions

    @IBAction func rightBarButtonAction(_ sender: Any) {
        //save recipe
        self.view.endEditing(true)
        if let oldRecipes = recipes {
            viewModel?.updateRecipes(oldReceipe:oldRecipes,recipeTitle: recipeTitle.text, recipeIngredients: recipeIngredients.text, recipeSteps: recipeSteps.text, recipeCategory: recipeCategory.text, recipeImage: recipeImage.image)
        } else {
            viewModel?.saveRecipes(recipeTitle: recipeTitle.text, recipeIngredients: recipeIngredients.text, recipeSteps: recipeSteps.text, recipeCategory: recipeCategory.text, recipeImage: recipeImage.image)
        }
        self.navigationController?.popToRootViewController(animated: true)


    }

    @IBAction func leftBarButtonAction(_ sender: Any) {
        //back action
        self.navigationController?.popToRootViewController(animated: true)
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
