//
//  projectTableViewController.h
//  banana
//
//  Created by Gaël on 22/02/2015.
//  Copyright (c) 2015 gael. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface projectTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

{
    
    AppDelegate * app;
    NSManagedObjectContext * context;
}

//@property(nonatomic) UITableView * maListe;
//@property(nonatomic) NSArray * tableData;

@end
