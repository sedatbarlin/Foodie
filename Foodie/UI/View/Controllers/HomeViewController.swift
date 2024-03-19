//
//  HomeViewController.swift
//  Foodie
//
//  Created by Sedat on 15.12.2023.
//

import UIKit
import Kingfisher

//MARK: Anasayfadaki öğelerin bağlanması ve köprülerin kurulması 
 
final class HomeViewController: UIViewController{
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    let viewModel = HomeViewModel() //HomeViewModel'a köprü
    let detailViewModel = FoodDetailViewModel() //FoodDetailViewModel'a köprü
    var foodList = [Foods]() // Model Foods'a köprü
    var collectionViewCell = FoodsCollectionViewCell() //FoodsCollectionViewCell'a köprü (içeriklerin gösterilmesi)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        configureCollectionView()
        setSearchBar()
        setViewModel()
    }
    
    private func setCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    private func configureCollectionView(){
        let collectionDesign = UICollectionViewFlowLayout() //Anasayfadaki collectionview dizaynı ölçüleri
        collectionDesign.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionDesign.minimumLineSpacing = 10
        collectionDesign.minimumInteritemSpacing = 10
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = (screenWidth - 40) / 2
        collectionDesign.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.6)
        collectionView.collectionViewLayout = collectionDesign
        configureButton() //button
    }
    private func setSearchBar(){
        searchBar.delegate = self
    }
    private func setViewModel(){
        _ = viewModel.foodList.subscribe(onNext: { list in //bir arkaplan iş parçacığı var yani yemek listemin yüklenmesini istiyorum
            self.foodList = list
            DispatchQueue.main.async {
                self.collectionView.reloadData() //hata ne olursa olsun içerikleri gönder reloadData()
            }
        })
    }
    private func configureButton(){
        collectionViewCell.cartButton?.tintColor = UIColor(red: 113/255, green: 156/255, blue: 111/255, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) { //segment kontrolüm ve button rengim
        viewModel.loadFoods()
        segmentedControl.selectedSegmentIndex = 0
        configureButton()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { //Detay ekranında görüntüleme
        if segue.identifier == "toDetay" {
            if let yemek = sender as? Foods {
                let goToViewController = segue.destination as! FoodDetailViewController
                goToViewController.food = yemek
            }
        }
    }
    
    @IBAction private func categoryControl(_ sender: UISegmentedControl) { //SegmentControl sayesinde ürünlerin listelenmesi
        let selectedIndex = sender.selectedSegmentIndex
        switch selectedIndex{
        case 0: viewModel.loadFoods()
        case 1: viewModel.segmentedFoodList(idList: viewModel.meals) //yemekler
        case 2: viewModel.segmentedFoodList(idList: viewModel.deserts) //tatlılar
        case 3: viewModel.segmentedFoodList(idList: viewModel.drinks) //içecekler
        default:
            break
        }
    }
}
