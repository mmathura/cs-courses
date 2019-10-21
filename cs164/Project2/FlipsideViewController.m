//
//  FlipsideViewController.m
//  project2
//
//  Created by Mitch Mathura on 2014-05-18.
//  Copyright (c) 2014 Mitch Mathura. All rights reserved.
//

#import "FlipsideViewController.h"

@interface FlipsideViewController ()

@end

@implementation FlipsideViewController

@synthesize slider1 = _slider1;
@synthesize slider2 = _slider2;
@synthesize switchGameMode = _switchGameMode;
@synthesize label1 = _label1;
@synthesize label2 = _label2;

- (IBAction)switchGameMode:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (_switchGameMode.on) {
        [defaults setObject: @"Evil" forKey:@"gamemode"];
        // NSLog(@"Evil mode");
    }
    else {
        [defaults setObject: @"Good" forKey:@"gamemode"];
        // NSLog(@"Normal mode");
    }
    
    [defaults synchronize];
    
}

- (IBAction)slider1:(id)sender {
    
    _label1.text = [NSString stringWithFormat: @"%d", (int)[(UISlider*)sender value]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: _label1.text forKey:@"wordlength"];
    [defaults synchronize];    
}

- (IBAction)slider2:(id)sender {
    
    _label2.text = [NSString stringWithFormat: @"%d", (int)[(UISlider*)sender value]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: _label2.text forKey:@"numberofguesses"];
    [defaults synchronize];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSMutableDictionary *defaultValues = [[NSMutableDictionary alloc] init];
    [defaultValues setObject:@"1" forKey:@"wordlength"];
    [defaultValues setObject:@"1" forKey:@"numberofguesses"];
    [defaultValues setObject:@"Evil" forKey:@"gamemode"];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults registerDefaults:defaultValues];
    
    _label1.text = [defaults stringForKey:@"wordlength"];
    _label2.text = [defaults stringForKey:@"numberofguesses"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
