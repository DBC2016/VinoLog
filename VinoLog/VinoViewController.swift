//
//  VinoViewController.swift
//  VinoLog
//
//  Created by Demond Childers on 5/20/16.
//  Copyright © 2016 Demond Childers. All rights reserved.
//

import UIKit

class VinoViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
        @IBOutlet weak private var vinoCollectionView :UICollectionView!

        let backendless = Backendless.sharedInstance()
        var currentUser = BackendlessUser()
        var vinosArray = [Vinos]()
    
        
        //MARK: - COLLECTION VIEW METHODS
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vinosArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! VinoCollectionViewCell
        let currentVino = vinosArray[indexPath.row]
        cell.vinoNameLabel.text = currentVino.vinoName
        cell.dateCreatedLabel.text = "\(currentVino.created)"
        return cell
    }

        //MARK: - Interactivity Methods
        
        
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            let destController = segue.destinationViewController as! DetailViewController
            destController.currentUser = currentUser
            if segue.identifier == "logToDetailSegue" {
                //
                let indexPath = vinoCollectionView.indexPathsForSelectedItems()![0]
                let selectedEntry = vinosArray[indexPath.row]
                destController.vinoSelected = selectedEntry
                vinoCollectionView.deselectItemAtIndexPath(indexPath, animated: true)
                
            } else if segue.identifier == "addDetailSegue" {
                destController.vinoSelected = nil
                
            }
            
        }
    
    
    //OBJ C REF CODE
//    -(CGSize) collectionView: (UICollectionView *)UICollectionView layout:(UICollectionViewLayout *)UICollectionViewLayout sizeforItemAtIndexPath: (NSIndexPath *)indexpath {
//    return CGSizeMake(141.0, 168.0);
    
    
        
        
        func findRequests() {
            let dataQuery = BackendlessDataQuery()
            
            var error: Fault?
            let bc = backendless.data.of(Vinos.ofClass()).find(dataQuery, fault:  &error)
            if error == nil {
                vinosArray = bc.getCurrentPage() as! [Vinos]
                vinoCollectionView.reloadData()
                print("Found \(vinosArray.count)")
            } else {
                print("Find Error \(error)")
                
            }
            
        }
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        findRequests()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    



}
