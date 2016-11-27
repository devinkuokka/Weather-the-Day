//
//  WeeklyViewController.swift
//  WeatherTheDay
//
//  Created by Devin on 11/16/16.
//  Copyright © 2016 cse438. All rights reserved.
//

import UIKit

class WeeklyViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var gridView: UICollectionView!
    var headerView: UICollectionView!
    var headerTitles: [String] = ["Hour", "Real Temp", "Actual Feel", "% Rain", "Humidity"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setUpHeader()
        setUpDataGrid()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // SET UP
    //    func setUpHeader() {
    //
    //        var i = 0
    //        var j = 0;
    //        while (i < 80*5){
    //            let title = UILabel(frame: CGRect(x: i, y: 10, width: 80, height: 100))
    //            title.font.fontWithSize(8)
    //            title.textAlignment = .Center
    //            title.lineBreakMode = NSLineBreakMode.ByWordWrapping
    //            title.numberOfLines = 3
    //            title.textColor = UIColor.darkGrayColor()
    //            title.text = headerTitles[j]
    //            i += 82
    //            j += 1
    //            view.addSubview(title)
    //        }
    //    }
    
    
    func setUpDataGrid() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionHeadersPinToVisibleBounds = true;
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        flowLayout.minimumInteritemSpacing = 1;
        flowLayout.itemSize = CGSize(width: 80, height: self.view.bounds.height-100)
        
        gridView = UICollectionView(frame: self.view.bounds.offsetBy(dx: 0, dy: 100), collectionViewLayout: flowLayout)
        gridView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        gridView.dataSource = self
        gridView.delegate = self
        gridView.backgroundColor = UIColor.white
        
        view.addSubview(gridView)
        
    }
    
    // POPULATE TABLE WITH MOVIE TITLE AND POSTER
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.green
        
        if(indexPath.section % 2 == 1){
            cell.backgroundColor = UIColor.blue
        }
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
