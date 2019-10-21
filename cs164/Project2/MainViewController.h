//
//  MainViewController.h
//  project2
//
//  Created by Mitch Mathura on 2014-05-18.
//  Copyright (c) 2014 Mitch Mathura. All rights reserved.
//

#import "FlipsideViewController.h"
#import "HistoryViewController.h"
#import "GameplayDeligate.h"
#import "GoodGameplay.h"
#import "EvilGameplay.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textField;

@property (nonatomic, weak) IBOutlet UIButton *start;

@property (nonatomic, weak) IBOutlet UILabel *guesses;

@property (nonatomic, weak) IBOutlet UILabel *letters;

@property (nonatomic, weak) IBOutlet UILabel *display;

@end


