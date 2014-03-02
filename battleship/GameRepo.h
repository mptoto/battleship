//
//  GameRepo.h
//  battleship
//
//  Created by Michael Mayer on 2/22/14.
//  Copyright (c) 2014 Matthew Toto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"

enum gameSection {
	awaitingMyTurn = 0,
	awaitingOpponentTurn = 1,
	awaitingGameFinish = 2
};
typedef enum gameSection gameSection;

@interface GameRepo : NSObject
@property (nonatomic, strong)	NSArray *allGames;

+(GameRepo *)sharedRepo;

-(Game *) generateNewGame;
-(void)removeGameAt:(NSIndexPath *)indexPath;
-(void)moveGameFrom:(gameSection)fromSection to:(gameSection)toSection for:(Game *)aGame;
-(BOOL)saveChanges;
-(NSString *)gamesArchivePath;
@end
