//
//  GoodGameplay.m
//  project2
//
//  Created by Mitch Mathura on 2014-05-18.
//  Copyright (c) 2014 Mitch Mathura. All rights reserved.
//

#import "GoodGameplay.h"
#include <stdlib.h>

@implementation GoodGameplay

@synthesize dict = _dict;
@synthesize mdict = _mdict;
@synthesize nguessed = _nguessed;


- (id)init { // default constructor
    
    self = [super init];
    
    if (self) {
        
        // NSLog(@"Constructor");
        
        _dict = @{@"A":@NO, @"B":@NO, @"C":@NO, @"D":@NO, @"E":@NO, @"F":@NO,
                 @"G":@NO, @"H":@NO, @"I":@NO, @"J":@NO, @"K":@NO, @"L":@NO,
                 @"M":@NO, @"N":@NO, @"O":@NO, @"P":@NO, @"Q":@NO, @"R":@NO,
                 @"S":@NO, @"T":@NO, @"U":@NO, @"V":@NO, @"W":@NO, @"X":@NO,
                 @"Y":@NO, @"Z":@NO};
        
        _mdict = [_dict mutableCopy];

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

}

-(void) addwordtoeqclass: (NSMutableArray*) temp forChar: (char) ch {

}

-(void) largesteqclass {

}

-(id) getcomplementlargesteqclass {
    
    return nil;

}

@end
