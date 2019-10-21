//
//  FlipsideViewController.h
//  project2
//
//  Created by Mitch Mathura on 2014-05-18.
//  Copyright (c) 2014 Mitch Mathura. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController

@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;

@property (nonatomic, weak) IBOutlet UISlider *slider1;
@property (nonatomic, weak) IBOutlet UISlider *slider2;

@property (nonatomic, weak) IBOutlet UISwitch *switchGameMode;

@property (nonatomic, weak) IBOutlet UILabel *label1;
@property (nonatomic, weak) IBOutlet UILabel *label2;

- (IBAction)done:(id)sender;

@end
