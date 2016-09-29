//
//  CardGameDeck.m
//  Matchismo
//
//  Created by Ken Hom on 6/23/14.
//  Copyright (c) 2014 Ken Hom. All rights reserved.
//

#import "CardGameDeck.h"
#import "CardGameCard.h"

@interface CardGameDeck ()

@property (strong,nonatomic) NSMutableArray *cards;

@end


@implementation CardGameDeck

- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void)addCard:(CardGameCard *)card atTop:(BOOL)atTop
{
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
}

- (void)addCard:(CardGameCard *)card
{
    [self addCard:card atTop:NO];
}


- (CardGameCard *)drawRandomCard
{
    CardGameCard *randomCard = nil;
    
    if ([self.cards count]) {
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
        return randomCard;
}

@end
