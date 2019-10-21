//
//  HistoryViewController.m
//  project2
//
//  Created by Mitch Mathura on 2014-05-18.
//  Copyright (c) 2014 Mitch Mathura. All rights reserved.
//

#import "HistoryViewController.h"
#import "History.h"

@interface HistoryViewController ()

@end


@implementation HistoryViewController

@synthesize topscore = _topscore;
@synthesize nguesses = _nguesses;
@synthesize stargetword = _stargetword;
@synthesize ntotal = _ntotal;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _ntotal = 0;
    
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"highscore.plist"];
    
    NSLog(@"%@", plistPath);
    
    // load plist flie into dictionary
    
    // NSMutableArray *highscore = [[NSMutableArray alloc] initWithContentsOfFile:
    //                         [[NSBundle mainBundle] pathForResource:@"highscore" ofType:@"plist"]];
    
    NSMutableArray *highscore = [[NSMutableArray alloc] initWithContentsOfFile: plistPath];
    
    // append new score data
    
    [highscore addObject: [NSString stringWithFormat: @"%@ %d", _stargetword, _nguesses]];
    
    NSLog(@"high score = %@", highscore);
    
    // sort scores 
   
    // NSSortDescriptor *scoreDescriptor = [[NSSortDescriptor alloc] initWithKey: /* @"score" */ nil ascending:NO];
    // NSArray *sortDescriptors = @[scoreDescriptor];
    // NSArray *sortedArray = [highscore sortedArrayUsingDescriptors:sortDescriptors];
    
    // print plist file to view
    
    for (id w in highscore /* sortedArray */) {
        
        // NSLog(@"topscore = %@", w);
        
        // listview UI
        
        _topscore.text = [NSString stringWithFormat:@"%@ %@", self.topscore.text, w];
        
        _ntotal++;
        
        if (_ntotal == 10) break;

    }
    
    History *h = [[History alloc] init];
    [h save: highscore]; // pass h.s. array to save function
    // [h retrieve];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getscoredata: (NSString*) stargetword and: (int) nguesses {
    
    _stargetword = stargetword;
    _nguesses = nguesses;
    
    // NSLog(@"Score data %@ -> %d", _stargetword, _nguesses);

}


@end
