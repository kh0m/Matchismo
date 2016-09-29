//
//  CardGameCardMatchingGame.h
//  Matchismo
//
//  Created by Ken Hom on 6/25/14.
//  Copyright (c) 2014 Ken Hom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardGameDeck.h"

@interface CardGameCardMatchingGame : NSObject

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(CardGameDeck *)deck;

- (CardGameCardMatchingGame *)resetGameWithCardCount:(NSUInteger)count usingDeck:(CardGameDeck *)deck;

- (void) chooseCardAtIndex: (NSUInteger) index;

- (CardGameCard *)cardAtIndex: (NSUInteger) index;

@property (nonatomic, readonly) NSInteger score;

@property (nonatomic, readwrite) BOOL threeCardMode;

@property (nonatomic,readonly) NSMutableArray* eventMessages;

@end
