//
//  HistoryViewController.h
//  project2
//
//  Created by Mitch Mathura on 2014-05-18.
//  Copyright (c) 2014 Mitch Mathura. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HistoryViewControllerDeligate.h"
#import "History.h"

@interface HistoryViewController : UIViewController <HistoryViewControllerDeligate>

@property (nonatomic, weak) IBOutlet UILabel *topscore;
@property (nonatomic, assign, readwrite) int nguesses;
@property (nonatomic, assign, readwrite) int ntotal;
@property NSString *stargetword;

-(void) getscoredata: (NSString*) stargetword and: (int) nguesses;

@end
