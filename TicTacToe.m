//
//  TicTacToe.m
//  NetTicTacToe
//
//  Created by Craig Miller on Mon Jan 06 2003.
//  Copyright (c) 2003 Fazesoft. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TicTacToe.h"

@interface TicTacToe()
{
	NSInteger *board;
	NSInteger playerWon, moveNum, currentSide;
}
@end


@implementation TicTacToe

- (instancetype)init
{
	if (self = [super init]) {
		board = malloc(sizeof(uint32_t) * 9);
	}
	
	return self;
}

- (void)newGame:(NSInteger)startingSide
{
	int i;
	
	playerWon=EMPTY;
	currentSide=startingSide;
	
	// zero the board
	for (i=0; i<9; i++) board[i]=EMPTY;
	
	moveNum=0;
}


- (void)dealloc
{
	free(board);
	
}


- (void)drawBoardToSO
{
	int i;
	
	for (i=0; i<9; i++) {
		if (i==3 || i==6) printf("\n");
		
		switch (board[i]) {
			case EMPTY:
				printf(" ");
				break;
			
			case CROSS:
				printf("X");
				break;
			
			case CIRCLE:
				printf("O");
				break;
		}
	}
	printf("\n\n");
}


- (BOOL)addMove:(NSInteger)square
{
	printf("addMove:%d\n", (uint32_t)square);
	
	if (playerWon==EMPTY) {
		if (board[square]==EMPTY) {
			moveNum++;
			board[square]=currentSide;
		} else return NO;
	}
	
	if ([self won]) playerWon=currentSide;
	else [self changeCurrentSide];
	
	return YES;
}


- (void)changeCurrentSide
{
	if (currentSide==CROSS) currentSide=CIRCLE;
	else currentSide=CROSS;
}


- (BOOL)won
{
	// across
	if (board[0]==currentSide && board[1]==currentSide && board[2]==currentSide) return YES;
	else if (board[3]==currentSide && board[4]==currentSide && board[5]==currentSide) return YES;
	else if (board[6]==currentSide && board[7]==currentSide && board[8]==currentSide) return YES;
	
	// down
	else if (board[0]==currentSide && board[3]==currentSide && board[6]==currentSide) return YES;
	else if (board[1]==currentSide && board[4]==currentSide && board[7]==currentSide) return YES;
	else if (board[2]==currentSide && board[5]==currentSide && board[8]==currentSide) return YES;
	
	// diagonal
	else if (board[0]==currentSide && board[4]==currentSide && board[8]==currentSide) return YES;
	else if (board[2]==currentSide && board[4]==currentSide && board[6]==currentSide) return YES;
	
	return NO;
}


- (NSInteger)winner
{
	return playerWon;
}


- (NSInteger)getCurrentSide
{
	return currentSide;
}


- (NSInteger *)getCurrentBoard
{
	return board;
}


- (void)compMove
{
	int plyrSide, move;
	
	if (currentSide==CIRCLE) plyrSide=CROSS;
	else plyrSide=CIRCLE;
	
	move=[self canWinAt:currentSide];
	if (move !=-1 && board[move]==EMPTY) {
		printf("comp can win at %d\n", move);
		[self addCompMove:move];
	} else {
		move=[self canWinAt:plyrSide];
		if (move==-1) move=clock() % 9;
		else printf("comp blocks at %d\n", move);
		[self addCompMove:move];
	}
}


- (void)addCompMove:(NSInteger)move
{
	int i=0;
	
	if ([self addMove:move]==NO) {
		while (i<9 && [self addMove:i]==NO) i++;
	}
}


- (int)canWinAt:(NSInteger)side
{
	// across
	if (board[0]==side && board[1]==side && board[2]==EMPTY) return 2;
	else if (board[0]==side && board[2]==side && board[1]==EMPTY) return 1;
	else if (board[1]==side && board[2]==side && board[0]==EMPTY) return 0;
	
	else if (board[3]==side && board[4]==side && board[5]==EMPTY) return 5;
	else if (board[3]==side && board[5]==side && board[4]==EMPTY) return 4;
	else if (board[4]==side && board[5]==side && board[3]==EMPTY) return 3;
	
	else if (board[6]==side && board[7]==side && board[8]==EMPTY) return 8;
	else if (board[6]==side && board[8]==side && board[7]==EMPTY) return 7;
	else if (board[7]==side && board[8]==side && board[6]==EMPTY) return 6;
	
	// down
	else if (board[0]==side && board[3]==side && board[6]==EMPTY) return 6;
	else if (board[0]==side && board[6]==side && board[3]==EMPTY) return 3;
	else if (board[3]==side && board[6]==side && board[0]==EMPTY) return 0;
	
	else if (board[1]==side && board[4]==side && board[7]==EMPTY) return 7;
	else if (board[1]==side && board[7]==side && board[4]==EMPTY) return 4;
	else if (board[4]==side && board[7]==side && board[1]==EMPTY) return 1;
	
	else if (board[2]==side && board[5]==side && board[8]==EMPTY) return 8;
	else if (board[2]==side && board[8]==side && board[5]==EMPTY) return 5;
	else if (board[5]==side && board[8]==side && board[2]==EMPTY) return 2;
	
	// diagonal
	else if (board[0]==side && board[4]==side && board[8]==EMPTY) return 8;
	else if (board[0]==side && board[8]==side && board[4]==EMPTY) return 4;
	else if (board[4]==side && board[8]==side && board[0]==EMPTY) return 0;
	
	else if (board[2]==side && board[4]==side && board[6]==EMPTY) return 6;
	else if (board[2]==side && board[6]==side && board[4]==EMPTY) return 4;
	else if (board[4]==side && board[6]==side && board[2]==EMPTY) return 2;
	
	else return -1;
}


- (NSInteger)moveNumber
{
	return moveNum;
}

@end
