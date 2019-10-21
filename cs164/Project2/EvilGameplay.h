//
//  EvilGameplay.h
//  project2
//
//  Created by Mitch Mathura on 2014-05-18.
//  Copyright (c) 2014 Mitch Mathura. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GameplayDeligate.h"

@interface EvilGameplay : NSObject <GameplayDeligate>

@property NSDictionary *dict;

@property NSMutableDictionary *ccdict;
@property NSMutableDictionary *mdict;
@property NSMutableDictionary *eq_class_dict;

@property NSMutableArray *wcc;
@property NSMutableArray *eq_class_arr;

@property NSMutableString *stargetstring;
@property NSMutableString *stempstring;

@property (assign, nonatomic, readwrite) int nguessed;
@property (assign, nonatomic, readwrite) int nwordlength;


- (id)initWithWordLength: (int) nwordlength;

@end
