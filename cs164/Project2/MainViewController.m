//
//  MainViewController.m
//  project2
//
//  Created by Mitch Mathura on 2014-05-18.
//  Copyright (c) 2014 Mitch Mathura. All rights reserved.
//

#include <stdlib.h>
#import "MainViewController.h"
#import "GoodGameplay.h"

@interface HistoryViewController() {

}

@end

@interface MainViewController() {
    
@private

    int nguesses;
    int nwordlength;
    int index; // index of temp string for user input 
    int nmatchedchar;
    
    NSString *tmpstr;
    NSString *stargetword;

    NSMutableString *smatchedletters;

    NSMutableArray *temp;
    
    id<GameplayDeligate> gpm; // game play mode

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
    NSString *sd = [defaults stringForKey:@"wordlength"];
    NSString *sg = [defaults stringForKey:@"numberofguesses"];
    NSString *sm = [defaults stringForKey:@"gamemode"];
    
    NSLog(@"Mode = %@", sm);
    
    nguesses = [sg intValue];
    nwordlength = [sd intValue];
    
    // create new objects for game play
    
    if ([sm isEqualToString: @"Good"]) {
        
        gpm = [[GoodGameplay alloc] init];
    
    }
    else if ([sm isEqualToString: @"Evil"]) {
        
        gpm = [[EvilGameplay alloc] initWithWordLength: nwordlength];

    }
    
    index = 0;
    
    _guesses.text = [NSString stringWithFormat:@"%d", nguesses];
    
    // add initial dashes to display
    
    for (int i = 0; i < [sd intValue]; i++) {
        _display.text = [NSString stringWithFormat:@"%@%@", self.display.text, @"-"];
    }

}

- (IBAction)textField:(id)sender { // not sure what goes here

}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _textField.delegate = self;
    
    // self.textField.hidden = YES; // hide text input field
    
    // get word length and number of guesses
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *sd = [defaults stringForKey:@"wordlength"];
    NSString *sg = [defaults stringForKey:@"numberofguesses"];
    NSString *sm = [defaults stringForKey:@"gamemode"];
    
    // NSLog(@"Dashes =  %@", sd);
    // NSLog(@"Guesses = %@", sg);
    
    NSLog(@"Mode = %@", sm);
    
    nguesses = [sg intValue];
    nwordlength = [sd intValue];
    
    // create new objects for game play
    
    if ([sm isEqualToString: @"Good"]) {
        
        gpm = [[GoodGameplay alloc] init];
        
    }
    else if ([sm isEqualToString: @"Evil"]) {
        
        gpm = [[EvilGameplay alloc] initWithWordLength: nwordlength];

    }
    
    // display dashes
    
    for (int i = 0; i < [sd intValue]; i++) {
        _display.text = [NSString stringWithFormat:@"%@%@", self.display.text, @"-"];
    }
    
    index = 0;
    
    tmpstr = @"";
    
    smatchedletters = [NSMutableString string];

    // NSLog(@"nGuesses = %d", nguesses);
    
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
    
    // int n = arc4random() % [temp count]; // get rand num
    
    if ([sm isEqualToString: @"Good"]) {
    
        int n = [gpm getrandomnumber: (int)[temp count]];
    
        // NSLog(@"Random number - gpm = %d", n);
    
        NSLog(@"%@ Count => %lu Random Index -> %d Target = %@", temp, (unsigned long)[temp count], n, [temp objectAtIndex: n]);
        
        // choose stargetword at start of game
        
        stargetword = [temp objectAtIndex: n];
    
    }
    else { // evil - choose stargetword later
        
        NSLog(@"%@ Count => %lu", temp, (unsigned long)[temp count]);
    }
    
    // guesses lable - initial value
    
    _guesses.text = [NSString stringWithFormat:@"%d", nguesses];
    
    for (int i = 0; i < nwordlength /*[stargetword length]*/; i++) { // init with dashes
        
        [smatchedletters insertString:@"-" atIndex: i];
        
    }
    
    // NSLog(@"Init Str = %@", smatchedletters);
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    // NSLog(@"%@", string);
    
    char ch = [string characterAtIndex:0];
    
    // NSLog(@"Character => %c", ch);
    
    if ((ch >= 'A' && ch <= 'Z') && nguesses > 0) {
        
        if (index < nwordlength) { // save letters in tmp str and update display
            
            self.display.text = @""; // clear display
            
            tmpstr = [NSString stringWithFormat:@"%@%@", tmpstr, string]; // get str fr txt field
            
            self.display.text = [NSString stringWithFormat:@"%@%@", self.display.text, tmpstr]; // app str
            
            index++;
            
            // fill in dashes at end of string
            
            for (int i = 0; i < (nwordlength - index); i++) {
                _display.text = [NSString stringWithFormat:@"%@%@", self.display.text, @"-"];
            }
            
            // NSLog(@"%@", self.display.text);
            
            // track letter already choosen - save in dict
            
            [gpm updateDict: string];
            
            // determine eq class for word
            
            [gpm eqclassforwords: temp forChar: ch];
            
            // add word to eq class
            
            [gpm addwordtoeqclass: temp forChar: ch];
            
            // determine largest eq class
            
            [gpm largesteqclass];
            
            // remove all words in complement of largest eq class
            
            NSString* stemptargetword;

            if ((stemptargetword = [gpm getcomplementlargesteqclass]) != NULL) { // handle evil mode 
                
                stargetword = stemptargetword; // save the starget word in stemp
                
                // NSLog(@"Evil - stargetword = %@", stargetword);
                
            }
                        
            nmatchedchar = [gpm matchChar: ch withTargetWord: stargetword];
            
            // NSLog(@"Matched char(s) = %d", nmatchedchar);
            
        }
        
        // dec nguesses
        
        nguesses--;
        
    }
    
    // update display
    
    if (nmatchedchar > 0) {
        
        smatchedletters = [NSMutableString stringWithString: [gpm match: nmatchedchar withTargetWord: stargetword]];
    }

    self.display.text = smatchedletters;
    
    // NSLog(@"%@", smatchedletters);

    // update label -- letters already choosen
    
    _letters.text = @""; // set to empty string
    
    // update displayed letters
    
    _letters.text = [gpm displayDict];
    
    // update number of guesses label
    
    _guesses.text = [NSString stringWithFormat:@"%d", nguesses];
    
    int iswon = 0;
    
    // NSLog(@"Num of guessed letters = %d", [gpm getnguessed]);
    
    // pass nguessed and starget word

    if ([gpm getnguessed] == [stargetword length] && nguesses >= 0) { // game is won
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hangman"
                                                        message:@"Congratulations!"
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
        
        // game ends or is won display history
        
        HistoryViewController *hvc = [[HistoryViewController alloc] initWithNibName: @"HistoryViewController" bundle: nil];
        
        [hvc getscoredata: stargetword and: nguesses];
        
        [self presentViewController:hvc animated: YES completion: nil];
        
        iswon++;

    }
    
    NSLog(@"Guesses left = %d", nguesses);
    
    if (nguesses == 0 && !iswon) { // ran out of guesses
        
        // display correct word -- stargetword
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hangman"
                              message:@"You have ran out of guesses! Start a new game."
                              delegate:nil
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil];
        [alert show];
        
        // game ends or is won display history
        
        HistoryViewController *hvc = [[HistoryViewController alloc] initWithNibName: @"HistoryViewController" bundle: nil];
        
        [hvc getscoredata: stargetword and: nguesses];
        
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
        [[segue destinationViewController] setDelegate: nil];
    }
    
}

@end

