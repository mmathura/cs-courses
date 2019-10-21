//
//  MainViewController.m
//  project2
//
//  Created by Mitch Mathura on 2014-05-18.
//  Copyright (c) 2014 Mitch Mathura. All rights reserved.
//

#include <stdlib.h>
#import "MainViewController.h"

@interface HistoryViewController() {

}

@end

@interface MainViewController() {
    
@private

    int nguesses;
    int nwordlength;
    int index;
    int nguessed;
    int ncharclass;
    int mode;
    
    NSString *tmpstr;
    NSString *stargetword;
    NSString *nstargetword;

    NSMutableString *stargetstring;
    NSMutableString *smatchedletters;
    NSMutableString *stempstring;

    NSMutableArray *temp;
    
    NSDictionary *dict;
    
    NSMutableDictionary *mdict;
    NSMutableDictionary *ccdict;
    
}

@end

@implementation MainViewController

@synthesize textField = _textField;
@synthesize start = _start;
@synthesize display = _display;
@synthesize letters = _letters;
@synthesize guesses = _guesses;


- (IBAction)start:(id)sender {
    
    self.textField.text = @"";
    self.letters.text = @"";
    self.display.text = @"";
    
    tmpstr = @"";

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString* sd = [defaults stringForKey:@"wordlength"];
    NSString* sg = [defaults stringForKey:@"numberofguesses"];
    NSString* sm = [defaults stringForKey:@"gamemode"];
    
    if ([sm isEqualToString: @"Good"]) {
        
        mode = 0;
    
    }
    else if ([sm isEqualToString: @"Evil"]) {
        
        mode = 1;
        
    }
    
    NSLog(@"Mode = %@ -> %d", sm, mode);

    nguesses = [sg intValue];
    nwordlength = [sd intValue];
    index = 0;
    nguessed = 0;
    
    _guesses.text = [NSString stringWithFormat:@"%d", nguesses];
    
    dict = @{@"A":@NO, @"B":@NO, @"C":@NO, @"D":@NO, @"E":@NO, @"F":@NO,
             @"G":@NO, @"H":@NO, @"I":@NO, @"J":@NO, @"K":@NO, @"L":@NO,
             @"M":@NO, @"N":@NO, @"O":@NO, @"P":@NO, @"Q":@NO, @"R":@NO,
             @"S":@NO, @"T":@NO, @"U":@NO, @"V":@NO, @"W":@NO, @"X":@NO,
             @"Y":@NO, @"Z":@NO};
    
    mdict = [dict mutableCopy];
    
    for (int i = 0; i < [sd intValue]; i++) {
        _display.text = [NSString stringWithFormat:@"%@%@", self.display.text, @"-"];
    }

}

- (IBAction)textField:(id)sender {

}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _textField.delegate = self;
    
    // self.textField.hidden = YES; // hide text input field
    
    // get word length and number of guesses
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString* sd = [defaults stringForKey:@"wordlength"];
    NSString* sg = [defaults stringForKey:@"numberofguesses"];
    NSString* sm = [defaults stringForKey:@"gamemode"];
    
    // create objects for game play 
    
    if ([sm isEqualToString: @"Good"]) {
        
        mode = 0;
        
    }
    else if ([sm isEqualToString: @"Evil"]) {
        
        mode = 1;
        
    }

    // NSLog(@"Dashes =  %@", sd);
    // NSLog(@"Guesses = %@", sg);
    
    NSLog(@"Mode = %@ -> %d", sm, mode);
    
    // display dashes
    
    for (int i = 0; i < [sd intValue]; i++) {
        _display.text = [NSString stringWithFormat:@"%@%@", self.display.text, @"-"];
    }
    
    nguesses = [sg intValue];
    nwordlength = [sd intValue];
    
    index = 0;
    nguessed = 0;
    ncharclass = 0;
    
    tmpstr = @"";
    
    smatchedletters = [NSMutableString string];
    stargetstring = [NSMutableString string];
    stempstring = [NSMutableString string];

    // NSLog(@"nGuesses = %d", nguesses);
    
    dict = @{@"A":@NO, @"B":@NO, @"C":@NO, @"D":@NO, @"E":@NO, @"F":@NO,
             @"G":@NO, @"H":@NO, @"I":@NO, @"J":@NO, @"K":@NO, @"L":@NO,
             @"M":@NO, @"N":@NO, @"O":@NO, @"P":@NO, @"Q":@NO, @"R":@NO,
             @"S":@NO, @"T":@NO, @"U":@NO, @"V":@NO, @"W":@NO, @"X":@NO,
             @"Y":@NO, @"Z":@NO};
    
    mdict = [dict mutableCopy];
    
    [self.textField becomeFirstResponder];
        
    // load plist flie into dictionary
    
    NSMutableArray *words = [[NSMutableArray alloc] initWithContentsOfFile:
                             [[NSBundle mainBundle] pathForResource:@"small" ofType:@"plist"]];
    
    // NSMutableArray *temp = [[NSMutableArray alloc] init];
    
    temp = [[NSMutableArray alloc] init];
    
    for (NSString *w in words) { // print plist file
        // example: NSNumber *n = [s length];
        if ([w length] == nwordlength) {
            [temp addObject: w]; // create a sub list of words with n length
            // NSLog(@"%@ %d", w, [w length]);
        }
    }
    
    int n = arc4random() % [temp count]; // get rand num
    
    NSLog(@"%@ Count => %d Random Index -> %d Target = %@", temp, [temp count], n, [temp objectAtIndex: n]);
    
    _guesses.text = [NSString stringWithFormat:@"%d", nguesses];
    
    stargetword = [temp objectAtIndex: n];
    
    for (int i = 0; i < [stargetword length]; i++) { // init with dashes
        
        [smatchedletters insertString:@"-" atIndex: i];
        [stargetstring insertString:@" " atIndex: i];
        [stempstring insertString:@" " atIndex: i];

    }
    
    // NSLog(@"Init Str = %@", smatchedletters);
    
    ccdict = [NSMutableDictionary dictionary];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSMutableDictionary *eq_class_dict = [[NSMutableDictionary alloc] init]; // store equivalence classes
    NSMutableArray *eq_class_arr = [[NSMutableArray alloc] init]; // store equivalence classes - counts
    
    int nmatched;

    // NSLog(@"%@", string);
    
    char ch = [string characterAtIndex:0];
    
    // NSLog(@"Character => %c", c);
    
    if ((ch >= 'A' && ch <= 'Z') && nguesses > 0) {
        
        if (index < nwordlength) { // save letters in tmp str and update display
            
            self.display.text = @""; // clear display
            
            tmpstr = [NSString stringWithFormat:@"%@ %@", tmpstr, string]; // get str fr txt field
            
            self.display.text = [NSString stringWithFormat:@"%@ %@", self.display.text, tmpstr]; // app str
            
            index++;
            
            // fill in dashes at end of string
            
            for (int i = 0; i < (nwordlength - index); i++) {
                _display.text = [NSString stringWithFormat:@"%@ %@", self.display.text, @" - "];
            }
            
            // NSLog(@"%@", self.display.text);
            
            // update dictionary -- track letter already choosen
        
            if ([[mdict objectForKey:string] isEqual: @NO]) {
                [mdict setObject:@YES forKey:string];
            }
            
            // chech if ch matches starget word
            
            nmatched = 0;
            
            for (int i = 0; i < [stargetword length]; i++) {
                
                if (ch == [stargetword characterAtIndex: i]) {
                    
                    // NSLog(@"[%d] = %c", i, ch);
                    
                    nmatched++;
                    
                }
            
            }
            
            if (nmatched > 0) { // matched
                
                smatchedletters = [NSMutableString stringWithString: @""]; // clear
                
                // search through mdict -- display letters that match
                
                nguessed = 0;
                
                for (int i = 0; i < [stargetword length]; i++) {
                    
                    // NSLog(@"key: %@, val: %@", key, [mdict objectForKey: key]);
                    
                    NSString *t = [NSString stringWithFormat: @"%c", [stargetword characterAtIndex: i]];
                    
                    if ([[mdict objectForKey: t] isEqual: @YES]) {
                        smatchedletters = [NSMutableString stringWithFormat:@"%@%@", smatchedletters, t];
                        nguessed++; // duplicate letters
                        NSLog(@"%@ - %d", t, nguessed);
                    }
                    else {
                        smatchedletters = [NSMutableString stringWithFormat:@"%@%c", smatchedletters, '-'];
                        NSLog(@"%c", '-');
                    }

                } // no match
                
                // update display
                
                // NSLog(@"Matched = %d", nmatched);
                
            }
            
            NSMutableArray *wcc = [[NSMutableArray alloc] init]; // word in char class

            for (int i = 0; i < [temp count]; i++) { // iterate through word list
                
                NSString* s = [NSString stringWithString: [temp objectAtIndex:i]]; // save word in s
                
                for (int j = 0; j < [s length]; j++) {
                    
                    // compare ch to every other char in word s
                    
                    if (ch == [s characterAtIndex:j]) { // match
                        
                        // add char to tmp str
                        
                        [stempstring replaceCharactersInRange: NSMakeRange(j,1) withString: [NSString stringWithFormat:@"%c", ch]];
                        
                        // list word s
                        
                        // NSLog(@"-> %@", s);
                        
                    }
                    else {
                        
                        // add a dash
                        
                        [stempstring replaceCharactersInRange: NSMakeRange(j,1) withString: [NSString stringWithFormat:@"%c", '-']];
                        
                        // NSLog(@"-> %@", s);

                    }
                }
                
                // NSLog(@"\nChar class tempstr => %@\n => %@", stempstring, s);
                
                // add char classes to dictionary first
                
                [ccdict setObject: [NSMutableArray array] forKey: stempstring]; // add tmp str to dictionary keys
                
            }
            
            for (int i = 0; i < [temp count]; i++) { // iterate through word list
                
                NSString* s = [NSString stringWithString: [temp objectAtIndex:i]]; // save word in s
                
                for (int j = 0; j < [s length]; j++) {
                    
                    // compare ch to every other char in word s
                    
                    if (ch == [s characterAtIndex:j]) { // match
                        
                        // add char to tmp str
                        
                        [stempstring replaceCharactersInRange: NSMakeRange(j,1) withString: [NSString stringWithFormat:@"%c", ch]];
                        
                        // list word s
                        
                        // NSLog(@"-> %@", s);
                        
                    }
                    else {
                        
                        // add a dash
                        
                        [stempstring replaceCharactersInRange: NSMakeRange(j,1) withString: [NSString stringWithFormat:@"%c", '-']];
                        
                        // NSLog(@"-> %@", s);
                        
                    }
                }
                
                // add word to value array
                
                wcc = [ccdict objectForKey: stempstring];
                
                [wcc addObject: s]; // add word to char class
                
            }

            // update display
            
            self.display.text = smatchedletters;
            
            // NSLog(@"%@", smatchedletters);
            
            NSLog(@"%@", ccdict); // char classes with words
            
            // use count method to count num words in each equiv class

            for (id key in ccdict) {
                
                NSNumber *n = [NSNumber numberWithInt:[[ccdict objectForKey: key] count]];
                
                [eq_class_dict setObject: n forKey: key];
                
                [eq_class_arr addObject: n];
                
                // NSLog(@"Class %@ Count: %@", key, n);
            
            }
            
            // number of char class families
            
            // int keyCount = [[ccdict allKeys] count];
            
            // NSLog(@"Char classes = %d", keyCount);
            
            // clear data structure
            
            // [wcc removeAllObjects];
            // [ccdict removeAllObjects];

        }
        
        NSLog(@"%@", eq_class_dict);
        
        // find empty char class family
        
        // int x = [[eq_class_dict allKeys] count ] - 1;
        
        // NSMutableArray *char_class_family = [[NSMutableArray alloc] init];
        
        // char_class_family = [NSMutableArray arrayWithArray:[eq_class_dict allKeys]];
        
        // [char_class_family removeObjectAtIndex: x];
        
        // NSLog(@"%@ = Empty char class %@",[eq_class_dict allKeys], [[eq_class_dict allKeys] objectAtIndex: x]);
        
        // NSLog(@"%@",char_class_family);
        
        
        // get sub set of dict -- eq class dict
        
        // NSDictionary *subdict = [NSDictionary dictionaryWithObjects: [eq_class_dict objectsForKeys:char_class_family notFoundMarker: @""] forKeys: char_class_family];
        
        // NSLog(@"%@", subdict);
        
        
        // NSLog(@"%@", eq_class_arr);

        
        // picks largest eq class -- n word families
        
        NSNumber *max =[eq_class_arr valueForKeyPath:@"@max.self"];
        
        NSLog(@"Max char class = %@", max);
        
        if (max != nil) { // (null) exception
        
            NSArray* ar = [eq_class_dict allKeysForObject: max];
        
            NSString* skey = [ar objectAtIndex:0];
        
            // NSLog(@"key = %@", skey);
            
            id val = [ccdict objectForKey: skey];
            
            NSLog(@"Sublist = %@", val);
            
            int nsd = arc4random() % ([max intValue] - 1); // get rand num
            
            nstargetword = [val objectAtIndex: nsd];
            
            NSLog(@"Index = %d word = %@", nsd, nstargetword);
            
            //
            // reveals letter
            //
            
            // max = [NSNumber numberWithInt: 1];
            
            if ([max isEqualToNumber: [NSNumber numberWithInt: 1]]) { // if max equlas 1
                
                // get array of keys
                
                NSArray *keyarr = [eq_class_dict allKeys];
                
                NSLog(@"%@ Key Count = %lu", keyarr, (unsigned long)[keyarr count]);
                
                // choose random key
                
                int nrk;
                
                if (([keyarr count] - 1)  > 0) { // divide zero
                    
                    nrk = arc4random() % ([keyarr count] - 1); // get rand num

                }
                else
                    nrk = 0;
                
                NSLog(@"Random index = %d", nrk);
                    
                // choose one ch class from dict based on key
                    
                id val2 = [ccdict objectForKey: [keyarr objectAtIndex: nrk]];
                    
                // display list of words
                    
                NSLog(@"Sublist = %@", val2);
                
                // use sub list as the word list
                
            }
        }
        
        // clear data structure
        
        [ccdict removeAllObjects];

        // dec nguesses;
        
        // if match susspend guesses
        
        nguesses--;
        
    }
    
    // update label -- letters already choosen
    
    _letters.text = @""; // set to empty string
    
    for (id key in mdict) {
        
        // NSLog(@"key: %@, val: %@", key, [mdict objectForKey: key]);
        
        if ([[mdict objectForKey:key] isEqual: @YES]) {
            _letters.text = [NSString stringWithFormat:@"%@%@", self.letters.text, key];
        }
        
    }
    
    // NSLog(@"%@", mdict);
    
    // update number of guesses label
    
    _guesses.text = [NSString stringWithFormat:@"%d", nguesses];
    
    int iswon = 0;
    
    NSLog(@"Num of guessed letters = %d", nguessed);

    if (nguessed == [stargetword length] && nguesses >= 0) { // game is won
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hangman"
                                                        message:@"Congratulations!"
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
        
        // game ends or is won display history
        
        HistoryViewController *hvc = [[HistoryViewController alloc] initWithNibName: @"HistoryViewController" bundle: nil];
        
        [self presentViewController:hvc animated: YES completion: nil];
        
        iswon++;

    }
    
    NSLog(@"Guesses left = %d", nguesses);
    
    if (nguesses == 0 && !iswon) { // ran out of guesses
        
        // display correct word
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hangman"
                              message:@"You have ran out of guesses! Start a new game."
                              delegate:nil
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil];
        [alert show];
        
        // game ends or is won display history
        
        HistoryViewController *hvc = [[HistoryViewController alloc] initWithNibName: @"HistoryViewController" bundle: nil];
        
        [self presentViewController:hvc animated: YES completion: nil];

    }

    return YES;
    
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField  {
    
    [self.textField resignFirstResponder];

    return YES;
    
}

-(BOOL)textFieldShouldClear:(UITextField *)textField    {

    return YES;

}

- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
    
}

@end

