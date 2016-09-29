//
//  CardGamePlayingCard.h
//  Matchismo
//
//  Created by Ken Hom on 6/24/14.
//  Copyright (c) 2014 Ken Hom. All rights reserved.
//

#import "CardGameCard.h"

@interface CardGamePlayingCard : CardGameCard

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;
@property (nonatomic, getter = isRed) BOOL red;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
