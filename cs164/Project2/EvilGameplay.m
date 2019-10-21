//
//  EvilGameplay.m
//  project2
//
//  Created by Mitch Mathura on 2014-05-18.
//  Copyright (c) 2014 Mitch Mathura. All rights reserved.
//

#import "EvilGameplay.h"
#include <stdlib.h>

@implementation EvilGameplay

@synthesize dict = _dict;
@synthesize mdict = _mdict;
@synthesize nguessed = _nguessed;
@synthesize stargetstring = _stargetstring;
@synthesize stempstring = _stempstring;
@synthesize ccdict = _ccdict;
@synthesize wcc = _wcc;
@synthesize eq_class_arr = _eq_class_arr;
@synthesize eq_class_dict = _eq_class_dict;
@synthesize nwordlength = _nwordlength;


- (id)initWithWordLength: (int) nwordlength { // default constructor
    
    self = [super init];
    
    if (self) {
        
        // NSLog(@"Constructor");
        
        _dict = @{@"A":@NO, @"B":@NO, @"C":@NO, @"D":@NO, @"E":@NO, @"F":@NO,
                  @"G":@NO, @"H":@NO, @"I":@NO, @"J":@NO, @"K":@NO, @"L":@NO,
                  @"M":@NO, @"N":@NO, @"O":@NO, @"P":@NO, @"Q":@NO, @"R":@NO,
                  @"S":@NO, @"T":@NO, @"U":@NO, @"V":@NO, @"W":@NO, @"X":@NO,
                  @"Y":@NO, @"Z":@NO};
        
        _mdict = [_dict mutableCopy];
        
        _stargetstring = [NSMutableString string];
        
        for (int i = 0; i < nwordlength; i++) { // init with spaces
            
            [_stargetstring insertString:@" " atIndex: i];
            
        }
        
        _nwordlength = nwordlength;
        
        _ccdict = [NSMutableDictionary dictionary];
        _eq_class_dict = [[NSMutableDictionary alloc] init]; // store equivalence classes
        _eq_class_arr = [[NSMutableArray alloc] init]; // store equivalence classes - counts
        _wcc = [[NSMutableArray alloc] init]; // word in char class

    }
    
    return self;
}

- (int) getrandomnumber: (int) range {
    
    return arc4random() % range;
    
}

- (void) updateDict: (NSString*) string {
    
    // update dictionary -- track letter already choosen
    
    if ([[_mdict objectForKey:string] isEqual: @NO]) {
        [_mdict setObject:@YES forKey:string];
    }
    
    // NSLog(@"%@", _mdict);
    
}

- (NSString*) displayDict {
    
    NSString *sletters = @"";
    
    for (id key in _mdict) {
        
        // NSLog(@"key: %@, val: %@", key, [_mdict objectForKey: key]);
        
        if ([[_mdict objectForKey:key] isEqual: @YES]) {
            
            // _letters.text = [NSString stringWithFormat:@"%@%@", self.letters.text, key];
            
            sletters = [NSString stringWithFormat:@"%@%@", sletters, key];
        }
        
    }
    
    // NSLog(@"%@", _mdict);
    
    // NSLog(@"%@", sletters);
    
    return sletters;
    
}

- (int) matchChar: (char) ch withTargetWord: (NSString*) stargetword {
    
    // chech if ch matches starget word
    
    int nmatched = 0;
    
    for (int i = 0; i < [stargetword length]; i++) {
        
        if (ch == [stargetword characterAtIndex: i]) {
            
            // NSLog(@"[%d] = %c", i, ch);
            
            nmatched++;
            
        }
        
    }
    
    return nmatched;
    
}


- (NSString*) match: (int) nmatched withTargetWord: (NSString*)stargetword {
    
    NSString* smatchedletters;
    
    if (nmatched > 0) { // matched
        
        smatchedletters = [NSMutableString stringWithString: @""]; // clear
        
        // search through mdict -- display letters that match
        
        // int nguessed = 0;
        
        _nguessed = 0;
        
        for (int i = 0; i < [stargetword length]; i++) {
            
            // NSLog(@"key: %@, val: %@", key, [_mdict objectForKey: key]);
            
            NSString *t = [NSString stringWithFormat: @"%c", [stargetword characterAtIndex: i]];
            
            if ([[_mdict objectForKey: t] isEqual: @YES]) {
                smatchedletters = [NSMutableString stringWithFormat:@"%@%@", smatchedletters, t];
                _nguessed++; // duplicate letters
                // NSLog(@"%@ - %d", t, _nguessed);
            }
            else {
                smatchedletters = [NSMutableString stringWithFormat:@"%@%c", smatchedletters, '-'];
                // NSLog(@"%c", '-');
            }
            
        } // no match
        
        // update display
        
        // NSLog(@"Matched = %d", nmatched);
        
        return smatchedletters;
        
    }
    
    return @"";
    
}


-(int) getnguessed {
    
    return _nguessed;
    
}

-(void) eqclassforwords: (NSMutableArray*) temp forChar: (char) ch {
    
    [_ccdict removeAllObjects];
    [_wcc removeAllObjects];

    // NSLog(@"nwordlength = %d", _nwordlength);
    
    _stempstring = [NSMutableString string];
    
    for (int i = 0; i < _nwordlength; i++) { // init with spaces
        
        [_stempstring insertString:@" " atIndex: i];
        
    }
    
    for (int i = 0; i < [temp count]; i++) { // iterate through word list
        
        NSString* s = [NSString stringWithString: [temp objectAtIndex:i]]; // save word in s
        
        for (int j = 0; j < [s length]; j++) {
            
            // compare ch to every other char in word s
            
            if (ch == [s characterAtIndex:j]) { // match
                
                // add char to tmp str
                
                [_stempstring replaceCharactersInRange: NSMakeRange(j,1) withString: [NSString stringWithFormat:@"%c", ch]];
                
                // list word s
                
                // NSLog(@"-> %@", s);
                
            }
            else {
                
                // add a dash
                
                [_stempstring replaceCharactersInRange: NSMakeRange(j,1) withString: [NSString stringWithFormat:@"%c", '-']];
                
                // NSLog(@"-> %@", s);
                
            }
        }
        
        // NSLog(@"\nChar class tempstr => %@\n => %@", _stempstring, s);
        
        // add char classes to dictionary first
        
        [_ccdict setObject: [NSMutableArray array] forKey: _stempstring]; // add tmp str to dictionary keys
        
    }

}

-(void) addwordtoeqclass: (NSMutableArray*) temp forChar: (char) ch {
        
    _stempstring = [NSMutableString string];
    
    for (int i = 0; i < _nwordlength; i++) { // init with spaces
        
        [_stempstring insertString:@" " atIndex: i];
        
    }
    
    for (int i = 0; i < [temp count]; i++) { // iterate through word list
        
        NSString* s = [NSString stringWithString: [temp objectAtIndex:i]]; // save word in s
        
        for (int j = 0; j < [s length]; j++) {
            
            // compare ch to every other char in word s
            
            if (ch == [s characterAtIndex:j]) { // match
                
                // add char to tmp str
                
                [_stempstring replaceCharactersInRange: NSMakeRange(j,1) withString: [NSString stringWithFormat:@"%c", ch]];
                
                // list word s
                
                // NSLog(@"-> %@", s);
                
            }
            else {
                
                // add a dash
                
                [_stempstring replaceCharactersInRange: NSMakeRange(j,1) withString: [NSString stringWithFormat:@"%c", '-']];
                
                // NSLog(@"-> %@", s);
                
            }
        }
        
        // add word to value array
        
        _wcc = [_ccdict objectForKey: _stempstring];
        
        [_wcc addObject: s]; // add word to char class
        
    }

}

-(void) largesteqclass {
    
    NSLog(@"%@", _ccdict); // char classes with words
    
    // use count method to count num words in each equiv class
    
    for (id key in _ccdict) {
        
        NSNumber *n = [NSNumber numberWithInt:(int)[[_ccdict objectForKey: key] count]];
        
        [_eq_class_dict setObject: n forKey: key];
        
        [_eq_class_arr addObject: n];
        
        // NSLog(@"Class %@ Count: %@", key, n);
        
    }
    
    NSLog(@"%@", _eq_class_dict);
    
}

-(id) getcomplementlargesteqclass {
    
    id nstargetword;
    
    // picks largest eq class -- n word families
    
    NSNumber *max =[_eq_class_arr valueForKeyPath:@"@max.self"];
    
    NSLog(@"Max char class = %@", max);
    
    if (max != nil) { // (null) exception
        
        NSArray* ar = [_eq_class_dict allKeysForObject: max];
        
        NSString* skey = [ar objectAtIndex:0];
        
        // NSLog(@"key = %@", skey);
        
        id val = [_ccdict objectForKey: skey];
        
        NSLog(@"Sublist = %@", val);
        
        // sublist becomes new temp list
        
        int nsd = arc4random() % ([max intValue] - 1); // get rand num
        
        nstargetword = [val objectAtIndex: nsd];
        
        NSLog(@"Index = %d word = %@", nsd, nstargetword);
        
        //
        // reveals letter
        //
        
        // max = [NSNumber numberWithInt: 1];
        
        if ([max isEqualToNumber: [NSNumber numberWithInt: 1]]) { // if max equlas 1
            
            // get array of keys
            
            NSArray *keyarr = [_eq_class_dict allKeys];
            
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
            
            id val2 = [_ccdict objectForKey: [keyarr objectAtIndex: nrk]];
            
            // display list of words
            
            NSLog(@"Sublist = %@", val2);
            
            // use sub list as the word list
            
        }
    }
    
    // clear data structure
    
    [_ccdict removeAllObjects];
    [_wcc removeAllObjects];
    [_eq_class_dict removeAllObjects];
    [_eq_class_arr removeAllObjects];

    return nstargetword;

}

@end
