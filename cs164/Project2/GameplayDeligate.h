//
//  GameplayDeligate.h
//  project2
//
//  Created by Mitch Mathura on 2014-05-18.
//  Copyright (c) 2014 Mitch Mathura. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GameplayDeligate <NSObject>

// add method prototypes to be implemented here
// that are common to both game plays

- (int) getrandomnumber: (int) range;
- (void) updateDict: (NSString*) string;
- (NSString*) displayDict;
- (int) matchChar: (char) ch withTargetWord: (NSString*) stargetword;
- (NSString*) match: (int) nmatched withTargetWord: (NSString*)stargetword;
- (int) getnguessed;
- (void) eqclassforwords: (NSMutableArray*) temp forChar: (char) ch;
- (void) addwordtoeqclass: (NSMutableArray*) temp forChar: (char) ch;
- (void) largesteqclass;
- (id) getcomplementlargesteqclass;

@end
