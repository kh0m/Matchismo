//
//  CardGameCardMatchingGame.m
//  Matchismo
//
//  Created by Ken Hom on 6/25/14.
//  Copyright (c) 2014 Ken Hom. All rights reserved.
//

#import "CardGameCardMatchingGame.h"

@interface CardGameCardMatchingGame ()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of card
@property (nonatomic, strong) NSMutableArray *otherCards;
@property (nonatomic, strong) NSMutableArray *eventMessages;

@end


@implementation CardGameCardMatchingGame

- (NSMutableArray *)eventMessages
{
    if (!_eventMessages){
        _eventMessages = [[NSMutableArray alloc]init];
        [_eventMessages addObject:@"MATCHISMO!"];
    }
    return _eventMessages;
}


- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

- (NSMutableArray *)otherCards
{
    if (!_otherCards) _otherCards = [[NSMutableArray alloc]init];
    return _otherCards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(CardGameDeck *)deck
{
    self = [super init];
    if (self) {
        for (int i=0; i<count; i++) {
            CardGameCard *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}


- (CardGameCardMatchingGame *)resetGameWithCardCount:(NSUInteger)count usingDeck:(CardGameDeck *)deck
{
    [self.cards removeAllObjects];
    [self.eventMessages removeAllObjects];
    [self.eventMessages addObject:@"MATCHISMO!"];
    for (int i=0; i<count; i++) {
        CardGameCard *card = [deck drawRandomCard];
        if (card) {
            [self.cards addObject:card];
        } else {
            break;
        }
    }
    self.score = 0;
    return self;
}



static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;



- (void)chooseCardAtIndex:(NSUInteger)index
{
    CardGameCard *card = [self cardAtIndex:index];
    [self.eventMessages addObject:[NSString stringWithFormat:@"%@ was chosen.",card.contents]];
    
        if (!card.isMatched)
        {
            if (card.isChosen) {
                // card is already chosen. unchoose it.
                card.chosen = NO;
                [self.eventMessages addObject:[NSString stringWithFormat:@""]];
            } else { // card is not chosen yet
                
                // 2 card mode
                if (!self.threeCardMode) {
                    // match it against another card and mark as chosen.
                    for (CardGameCard *otherCard in self.cards) {
                        if (otherCard.isChosen && !otherCard.isMatched) {
                            int matchScore = [card match:@[otherCard]];
                            if (matchScore) {
                                self.score += matchScore*MATCH_BONUS;
                                card.matched = YES;
                                otherCard.matched = YES;
                                [self.eventMessages addObject:[NSString stringWithFormat:@"Matched %@ and %@ for %d points!",card.contents,otherCard.contents,matchScore*MATCH_BONUS]];
                            } else {
                                self.score -= MISMATCH_PENALTY;
                                otherCard.chosen = NO;
                                [self.eventMessages addObject:[NSString stringWithFormat:@"%@ doesn't match %@. %d point penalty.",card.contents,otherCard.contents,MISMATCH_PENALTY]];
                            }
                            break;
                        }
                    }
                }
                
                // 3 card mode
                else
                    // match against two other cards
                    for (CardGameCard *anotherCard in self.cards) {
                        if (anotherCard.isChosen && !anotherCard.isMatched) {
                            [self.otherCards addObject:anotherCard];
                        }
                    }
                if(self.otherCards.count ==2){
                    int matchScore = [card match:self.otherCards];
                    if (matchScore) {
                        self.score += matchScore*MATCH_BONUS;
                        card.matched = YES;
                        [self.eventMessages addObject:[NSMutableString stringWithFormat:@"Match found in %@",card.contents]];
                        for (CardGameCard *card in self.otherCards) {
                            card.matched = YES;
                            [self.eventMessages.lastObject appendFormat:@"%@",card.contents];
                        }
                        [self.eventMessages.lastObject appendFormat:@". +%d points",matchScore*MATCH_BONUS];
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        [self.eventMessages addObject:[NSMutableString stringWithFormat:@"No match found in %@",card.contents]];
                        for (CardGameCard *c in self.otherCards) {
                            c.chosen = NO;
                            [self.eventMessages.lastObject appendFormat:@"%@",card.contents];
                        }
                        [self.eventMessages.lastObject appendFormat:@"%d point penalty.",MISMATCH_PENALTY];
                    }
                }
                
                
                [self.otherCards removeAllObjects];
                self.score -= COST_TO_CHOOSE;
                card.chosen = YES;
            } // end else
        }
}

- (CardGameCard *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
