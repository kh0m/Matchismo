//
//  CardGameCard.h
//  Matchismo
//
//  Created by Ken Hom on 6/23/14.
//  Copyright (c) 2014 Ken Hom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardGameCard : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;


@end
