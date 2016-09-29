//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Ken Hom on 6/20/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardGamePlayingCardDeck.h"
#import "CardGamePlayingCard.h"
#import "CardGameCardMatchingGame.h"

@interface CardGameViewController ()

@property (strong, nonatomic) CardGameCardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *cardModeSelector;
@property (weak, nonatomic) IBOutlet UILabel *eventLabel;
@property (weak, nonatomic) IBOutlet UISlider *eventSlider;
- (IBAction)eventSliderMoved:(UISlider *)sender;

@end

@implementation CardGameViewController

- (CardGameCardMatchingGame *)game
{
    if (!_game) _game = [[CardGameCardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                                  usingDeck:[self createDeck]];
    return _game;
}

- (CardGamePlayingCardDeck *)createDeck
{
    return[[CardGamePlayingCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateMode];
    self.cardModeSelector.enabled = NO;
    [self updateUI];
}

- (void)updateMode
{
    if ([self.cardModeSelector selectedSegmentIndex]==0) {
        self.game.threeCardMode = NO;
    }
    else {
        self.game.threeCardMode = YES;
    }
}

- (IBAction)newGame:(UIButton *)sender
{
    [self.game resetGameWithCardCount:[self.cardButtons count]usingDeck:[self createDeck]];
    [self updateUI];
    self.cardModeSelector.enabled = YES;
    self.eventSlider.enabled = NO;
}



- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        CardGamePlayingCard *card = (CardGamePlayingCard*)[self.game cardAtIndex:cardIndex];
        
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        if (card.isRed) {
            [cardButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score : %ld",(long)self.game.score];
    self.eventLabel.text = [self.game.eventMessages lastObject];
    
    if(self.game.eventMessages.count > 1)
    {
        self.eventSlider.enabled = YES;
        self.eventSlider.maximumValue = self.game.eventMessages.count-1;
        NSLog(@"slider max is %f",self.eventSlider.maximumValue);
    }
    
    self.eventSlider.value = [self.game.eventMessages count]-1;
    self.eventLabel.textColor = [UIColor colorWithWhite:1 alpha:1];

}

- (NSString *)titleForCard:(CardGameCard *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(CardGameCard *)card
{
    return [UIImage imageNamed:(card.isChosen) ? @"CardFront" : @"CardBack"];
}

- (IBAction)eventSliderMoved:(UISlider *)sender {
    self.eventLabel.text = [self.game.eventMessages objectAtIndex:(int)sender.value];
    NSLog(@"index is %d",(int)sender.value);
    
    if (self.eventSlider.value < [self.game.eventMessages count]-1) {
        self.eventLabel.textColor = [UIColor colorWithWhite:1 alpha:0.75];
    }
    else
    {
        self.eventLabel.textColor = [UIColor colorWithWhite:1 alpha:1];
    }
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
