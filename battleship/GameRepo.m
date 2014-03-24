//
//  GameRepo.m
//  battleship
//
//  Created by Michael Mayer on 2/22/14.
//  Copyright (c) 2014 Michael M. Mayer. All rights reserved.
//

#import "GameRepo.h"

@implementation GameRepo

+(GameRepo *)sharedRepo
{
	static GameRepo *sharedRepo = nil;
	if(!sharedRepo)
		sharedRepo = [[super allocWithZone:nil] init];
	
	return sharedRepo;
}

+(id)allocWithZone:(NSZone *)zone
{
	return [self sharedRepo];
}

-(instancetype)init
{
	self = [super init];
	if(self) {
		NSString *path = [self gamesArchivePath];
		self.allGames = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
	}
	if (!self.allGames)
		self.allGames = @[[[NSMutableArray alloc] init], [[NSMutableArray alloc] init], [[NSMutableArray alloc] init]];
	
	return self;
}
	
- (Game *) generateNewGame
{
	Game *newGame = [[Game alloc] init];
	[self.allGames[awaitingMyTurn] addObject:newGame];
	
	return newGame;
}


-(void)removeGameAt:(NSIndexPath *)indexPath
{
	[self.allGames[indexPath.section] removeObjectAtIndex:indexPath.row];
}

-(void)moveGameFrom:(gameSection)fromSection to:(gameSection)toSection for:(Game *)aGame
{
	if (fromSection != toSection) {
		[self.allGames[toSection] addObject:aGame];
		[self.allGames[fromSection] removeObjectIdenticalTo:aGame];
	}
}

-(BOOL)saveChanges
{
	return [NSKeyedArchiver archiveRootObject:self.allGames toFile:[self gamesArchivePath]];
}

-(NSString *)gamesArchivePath
{
	NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDirectory = documentDirectories[0];
	
	return [documentDirectory stringByAppendingPathComponent:@"games.archive"];
}

@end
