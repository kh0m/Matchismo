//
//  CardGamePlayingCardDeck.m
//  Matchismo
//
//  Created by Ken Hom on 6/24/14.
//  Copyright (c) 2014 Ken Hom. All rights reserved.
//

#import "CardGamePlayingCardDeck.h"
#import "CardGamePlayingCard.h"

@implementation CardGamePlayingCardDeck

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        for (NSString *suit in [CardGamePlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [CardGamePlayingCard maxRank]; rank++) {
                CardGamePlayingCard *card = [[CardGamePlayingCard alloc]init];
                card.rank = rank;
                card.suit = suit;
                if ([card.suit isEqual: @"♥︎"] || [card.suit isEqual: @"♦︎"]) {
                    card.red = YES;
                }
                [self addCard:card];
            }
        }
    }
    
    return self;
}

@end
