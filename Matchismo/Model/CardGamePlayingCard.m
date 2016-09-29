//
//  CardGamePlayingCard.m
//  Matchismo
//
//  Created by Ken Hom on 6/24/14.
//  Copyright (c) 2014 Ken Hom. All rights reserved.
//

#import "CardGamePlayingCard.h"

@implementation CardGamePlayingCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 1) {
        
        CardGamePlayingCard *otherCard = [otherCards firstObject];
        if (self.rank == otherCard.rank || [self.suit isEqualToString:otherCard.suit]){
            score = 4;
        }
    }
    
    if ([otherCards count] == 2) {
        CardGamePlayingCard *otherCard1 = [otherCards firstObject];
        CardGamePlayingCard *otherCard2 = [otherCards lastObject];
        // if self and card1 match
        if (self.rank == otherCard1.rank || [self.suit isEqualToString:otherCard1.suit]) {
            score = 2;
            // check self and card2
            if (self.rank == otherCard2.rank || [self.suit isEqualToString:otherCard2.suit]) {
                score = 8;
            }
        } else if (self.rank == otherCard2.rank || [self.suit isEqualToString:otherCard2.suit]) {
            score = 2;
        } else if (otherCard1.rank == otherCard2.rank || [otherCard1.suit isEqualToString:otherCard2.suit]) {
            score = 2;
        }
    }
    
    return score;
}

+ (NSArray *) rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger) maxRank
{
    return [[self rankStrings] count] -1;
}

- (NSString *)contents
{
    // bad way to do it because you will get 11 instead of J
    // return [NSString stringWithFormat:@"%d%@", self.rank, self.suit];
    
    NSArray *rankStrings = [CardGamePlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}


+ (NSArray *)validSuits
{
    return @[@"♥︎",@"♦︎",@"♠︎",@"♣︎"];
}


@synthesize suit = _suit;

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

- (void)setSuit:(NSString *)suit
{
    if ([[CardGamePlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [CardGamePlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
