//
//  CardGameDeck.h
//  Matchismo
//
//  Created by Ken Hom on 6/23/14.
//  Copyright (c) 2014 Ken Hom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardGameCard.h"


@interface CardGameDeck : NSObject

- (void)addCard:(CardGameCard *)card atTop:(BOOL)atTop;
- (void)addCard:(CardGameCard *)card;

- (CardGameCard *)drawRandomCard;

@end
